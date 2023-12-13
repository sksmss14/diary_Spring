package com.example.diary.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.diary.vo.Member;
import com.example.diary.vo.Notice;
import com.example.diary.service.CommentService;
import com.example.diary.service.NoticeService;
import com.example.diary.vo.Comment;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CommentController {
	
	private CommentService commentService;
	private NoticeService noticeService;
	
	// 생성자 주입(@Autowired 생략)
	public CommentController(CommentService commentService,
								NoticeService noticeService) {
		this.commentService = commentService;
		this.noticeService = noticeService;
	}
	
	@PostMapping("/addComment")
	public String addComment(HttpSession session, Model model,
								int noticeNo, String comment, 
								@RequestParam(defaultValue = "false") String isSecret) {
								
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		Comment c = new Comment();
		
		c.setNoticeNo(noticeNo);
		try {
			c.setMemberId(loginMember.getMemberId()); 
		} catch(NullPointerException e) {
			log.error("로그아웃하고 접근시 NullPointerException 발생 -> null을 반환하면 ajax error 코드 실행");
			return null;
		}
		c.setComment(comment);
		c.setIsSecret(isSecret);
				
		int result = commentService.addComment(c);
		
		log.debug("댓글 추가(성공:1,실패:0) : " + result);
		
		String memberId = loginMember.getMemberId();
		int memberLevel = loginMember.getMemberLevel(); 
		
		int commentCount = commentService.getCommentCount(noticeNo);
		
		List<Comment> commentList = commentService.selectCommentList(noticeNo);

		log.debug("댓글 목록 : " + commentList);
		
		model.addAttribute("commentList", commentList);
		model.addAttribute("commentCount", commentCount);
		model.addAttribute("memberId", memberId);
		model.addAttribute("memberLevel", memberLevel);
		
		return "comment/commentFragment";  
	}
	
	@ResponseBody
	@GetMapping("/commentBtnCheck")
	public String updateCommentBtnCheck(HttpSession session, String memberId) {
		
		// 로그인이 되어 있지 않았다면 로그인 페이지로 이동
		if(session.getAttribute("loginMember") == null) {
			return "notLogin";
		}
		
		Member loginMember = (Member) session.getAttribute("loginMember");
		// 본인이 작성한 댓글이 아니고 일반회원일 때 noticeOne으로 redirect
		if(!loginMember.getMemberId().equals(memberId) && loginMember.getMemberLevel() == 0) {
			return "notMyComment";
		}
		
		// 성공 : 해당 댓글을 작성한 회원 + 관리자
		return "success";
	}
	
	@GetMapping("/updateComment")
	public String updateComment(HttpSession session, Model model,
									int commentNo) {
		
		Comment commentOne = commentService.selectCommentOne(commentNo);
		
		model.addAttribute("commentOne", commentOne);
		
		return "comment/updateComment";
	}
	
	@ResponseBody
	@PostMapping("/updateComment")
	public String updateComment(HttpSession session, 
									int commentNo, String comment, String memberId,
									@RequestParam(defaultValue = "false") String isSecret, 
									String memberPw) {
		
		// 로그인이 되어 있지 않았다면 로그인 페이지로 이동
		if(session.getAttribute("loginMember") == null) {
			return "notLogin";
		}
		
		Member loginMember = (Member) session.getAttribute("loginMember");
		// 해당 댓글을 작성하지 않은 일반 회원(관리자x)일 때 noticeOne으로 redirect
		if(!loginMember.getMemberId().equals(memberId) && loginMember.getMemberLevel() == 0) {
			return "notMyComment";
		}
		
		// Member 객체에 입력한 비밀번호 추가
		loginMember.setMemberPw(memberPw);
		
		// 비밀번호 확인
		int checkPassword = commentService.checkPassword(loginMember);
		if(checkPassword == 0) { 
			return "failCheckPassword";
		}
		// 수정(비밀번호 확인 완료 후 작업)
		Comment paramComment = new Comment();
		paramComment.setCommentNo(commentNo);
		paramComment.setComment(comment);
		paramComment.setIsSecret(isSecret);
		
		int result = commentService.updateComment(paramComment);
		
		log.debug("댓글 수정(성공:1,실패:0) : " + result);
		
		if(result != 1) {
			return "fail";
		}
		return "success";
	}
	
	@GetMapping("/deleteComment")
	public String deleteComment(HttpSession session, Model model,
								int commentNo, String memberId, int noticeNo) { // noticeNo의 defaultValue = null
				
		model.addAttribute("commentNo", commentNo);
		model.addAttribute("memberId", memberId);
		model.addAttribute("noticeNo", noticeNo);
			
		return "comment/deleteComment";
	}
	
	@ResponseBody
	@PostMapping("/deleteComment")
	public String deleteComment(HttpSession session, 
								int commentNo, String memberPw, String memberId) {
		
		// 로그인이 되어 있지 않았다면 로그인 페이지로 이동
		if(session.getAttribute("loginMember") == null) {
			return "notLogin";
		}
		
		Member loginMember = (Member) session.getAttribute("loginMember");
		// 해당 댓글을 작성하지 않은 일반 회원(관리자x)일 때 noticeOne으로 redirect
		if(!loginMember.getMemberId().equals(memberId) && loginMember.getMemberLevel() == 0) {
			return "notMyComment";
		}
		
		// Member 객체에 입력한 비밀번호 추가
		loginMember.setMemberPw(memberPw);
		
		// 비밀번호 확인
		int checkPassword = commentService.checkPassword(loginMember);
		if(checkPassword == 0) { 
			return "failCheckPassword";
		}
		// 삭제(비밀번호 확인 완료 후 작업)
		int result = commentService.deleteComment(commentNo);
		
		log.debug("댓글 삭제(성공:1,실패:0) : " + result);
		
		if(result != 1) {
			return "fail";
		}	
		return "success";
	}
	
}
