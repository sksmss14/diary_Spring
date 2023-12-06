package com.example.diary.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.diary.vo.Member;
import com.example.diary.service.CommentService;
import com.example.diary.vo.Comment;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CommentController {
	
	private CommentService commentService;
	
	// 생성자 주입(@Autowired 생략)
	public CommentController(CommentService commentService) {
		this.commentService = commentService;
	}
	
	@PostMapping("/addComment")
	public String addComment(HttpSession session, int noticeNo, String comment, String isSecret) {
						
		// 로그인이 되어 있지 않았다면 로그인 페이지로 이동
		if(session.getAttribute("loginMember") == null) {
			return "redirect:/login";
		}
		
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		Comment c = new Comment();
		// 비밀글 체크가 되어 있다면 Comment 객체의 isSecret 변수에 true 할당
		if(isSecret == null) {
			isSecret = "false";
		}
		
		c.setNoticeNo(noticeNo);
		c.setMemberId(loginMember.getMemberId());
		c.setComment(comment);
		c.setIsSecret(isSecret);
				
		int result = commentService.addComment(c);

		log.debug("댓글 추가(성공:1,실패:0)" + result);
		
		return "redirect:/noticeOne?noticeNo="+noticeNo;
	}
	
	@GetMapping("/updateComment")
	public String updateComment(HttpSession session, Model model,
									int commentNo, int noticeNo, String memberId) {
		
		// 로그인이 되어 있지 않았다면 로그인 페이지로 이동
		if(session.getAttribute("loginMember") == null) {
			return "redirect:/login";
		}
		
		Member loginMember = (Member) session.getAttribute("loginMember");
		// 본인이 작성한 댓글이 아니면 noticeOne으로 redirect
		if(!loginMember.getMemberId().equals(memberId)) {
			return "redirect:/noticeOne?noticeNo=" + noticeNo;
		}
		Comment commentOne = commentService.selectCommentOne(commentNo);
		
		model.addAttribute("commentOne", commentOne);
		
		return "comment/updateComment";
	}
	
	@PostMapping("/updateComment")
	public String updateComment(HttpSession session, 
									int commentNo, String comment, 
									@RequestParam(defaultValue = "false") String isSecret, 
									String password, int noticeNo) {
		
		// 로그인이 되어 있지 않았다면 로그인 페이지로 이동
		if(session.getAttribute("loginMember") == null) {
			return "redirect:/login";
		}
		
		Member loginMember = (Member) session.getAttribute("loginMember");
		// Member 객체에 입력한 비밀번호 추가
		loginMember.setMemberPw(password);
		
		// 비밀번호 확인(비밀번호가 틀렸다면 공지 화면으로 redirect)
		int checkPassword = commentService.checkPassword(loginMember);
		if(checkPassword == 0) { 
			return "redirect:/notice";
		}
		// 수정(비밀번호 확인 완료 후 작업)
		Comment paramComment = new Comment();
		paramComment.setCommentNo(commentNo);
		paramComment.setComment(comment);
		paramComment.setIsSecret(isSecret);
		
		int result = commentService.updateComment(paramComment);
		
		log.debug("댓글 수정(성공:1,실패:0) : " + result);
		
		return "redirect:/noticeOne?noticeNo=" + noticeNo;
	}
	
	@GetMapping("/deleteComment")
	public String deleteComment(HttpSession session, Model model,
								int commentNo, int noticeNo, String memberId) {
		
		// 로그인이 되어 있지 않았다면 로그인 페이지로 이동
		if(session.getAttribute("loginMember") == null) {
			return "redirect:/login";
		}
		
		Member loginMember = (Member) session.getAttribute("loginMember");
		// 본인이 작성한 댓글이 아니면 noticeOne으로 redirect
		if(!loginMember.getMemberId().equals(memberId)) {
			return "redirect:/noticeOne?noticeNo=" + noticeNo;
		}
			
		model.addAttribute("commentNo", commentNo);
		model.addAttribute("noticeNo", noticeNo);
			
		return "comment/deleteComment";
	}
	
	@PostMapping("/deleteComment")
	public String deleteComment(HttpSession session, 
								int commentNo, String memberPw, int noticeNo) {
		
		// 로그인이 되어 있지 않았다면 로그인 페이지로 이동
		if(session.getAttribute("loginMember") == null) {
			return "redirect:/login";
		}
		
		Member loginMember = (Member) session.getAttribute("loginMember");
		// Member 객체에 입력한 비밀번호 추가
		loginMember.setMemberPw(memberPw);
		
		// 비밀번호 확인(비밀번호가 틀렸다면 공지 화면으로 redirect)
		int checkPassword = commentService.checkPassword(loginMember);
		if(checkPassword == 0) { 
			return "redirect:/notice";
		}
		// 삭제(비밀번호 확인 완료 후 작업)
		int result = commentService.deleteComment(commentNo);
		
		log.debug("댓글 삭제(성공:1,실패:0) : " + result);
		
		return "redirect:/noticeOne?noticeNo=" + noticeNo;
	}
	
}
