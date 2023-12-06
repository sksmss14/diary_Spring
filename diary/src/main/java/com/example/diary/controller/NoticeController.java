package com.example.diary.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.diary.service.CommentService;
import com.example.diary.service.NoticeService;
import com.example.diary.vo.Comment;
import com.example.diary.vo.Member;
import com.example.diary.vo.Notice;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class NoticeController {
	
	private NoticeService noticeService;
	private CommentService commentService;
	
	// 생성자 주입(@Autowired 생략)
	public NoticeController(NoticeService noticeService, CommentService commentService) {
		this.noticeService = noticeService;
		this.commentService = commentService;
	}
	
	@GetMapping("/notice")
	public String notice(Notice paramNotice, HttpSession session, Model model) {
		
		List<Notice> noticeList = noticeService.selectNoticeList(paramNotice);
		log.debug("공지 목록 : " + noticeList);
		
		String memberId = null;
		if(session.getAttribute("loginMember") != null) {
			Member loginMember = (Member) session.getAttribute("loginMember");
			memberId = loginMember.getMemberId();
		}
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("memberId", memberId);
		
		return "notice/noticeList";
	
	}
	
	@GetMapping("/addNotice")
	public String addNotice(HttpSession session) {
		
		// session 유효성 검사
		if(session.getAttribute("loginMember") == null) {
			// 로그인이 되어 있지 않은 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/login";
		}
		
		// 관리자인지 일반 회원인지 확인(일반 회원이라면 홈화면으로 redirect)
		Member loginMember = (Member) session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() == 0) {
			return "redirect:/home";
		}

		return "notice/addNotice";
	}
	
	@PostMapping("/addNotice")
	public String addNotice(HttpSession session, Notice paramNotice) {
		
		// session 유효성 검사
		if(session.getAttribute("loginMember") == null) {
			// 로그인이 되어 있지 않은 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/login";
		}
		
		// 관리자인지 일반 회원인지 확인(일반 회원이라면 홈화면으로 redirect)
		Member loginMember = (Member) session.getAttribute("loginMember");	
		if(loginMember.getMemberLevel() == 0) {
			return "redirect:/home";
		}
		
		paramNotice.setMemberId(loginMember.getMemberId());
		int result = noticeService.addNotice(paramNotice);
		
		log.debug("공지 추가(성공:1,실패:0) : " + result);
		
		return "redirect:/notice";
	}
	
	@GetMapping("/noticeOne")
	public String noticeOne(int noticeNo, HttpSession session, Model model) {
	
		String memberId = null;
		if(session.getAttribute("loginMember") != null) {
			Member loginMember = (Member) session.getAttribute("loginMember");
			memberId = loginMember.getMemberId();
		}
		
		Notice noticeOne = noticeService.selectNoticeOne(noticeNo);
		int commentCount = commentService.getCommentCount(noticeNo);
		
		List<Comment> commentList = commentService.selectCommentList(noticeNo);

		log.debug("댓글 목록 : " + commentList);
		
		model.addAttribute("noticeOne", noticeOne);
		model.addAttribute("commentList", commentList);
		model.addAttribute("commentCount", commentCount);
		model.addAttribute("memberId", memberId);
			
		return "notice/noticeOne";
	}
	
	@GetMapping("/updateNotice")
	public String updateNotice(HttpSession session, int noticeNo, Model model) {
		
		// session 유효성 검사
		if(session.getAttribute("loginMember") == null) {
			// 로그인이 되어 있지 않은 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/login";
		}
		
		// 관리자인지 일반 회원인지 확인(일반 회원이라면 공지화면으로 redirect)
		Member loginMember = (Member) session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() == 0) {
			// 일반회원이라면 notice로 redirect
			return "redirect:/notice";
		}
		
		Notice noticeOne = noticeService.selectNoticeOne(noticeNo);
		model.addAttribute("noticeOne", noticeOne);
		
		return "notice/updateNoticeOne";
	}
	
	@PostMapping("/updateNotice")
	public String updateNotice(HttpSession session, Notice paramNotice, String password) {
		
		// session 유효성 검사
		if(session.getAttribute("loginMember") == null) {
			// 로그인이 되어 있지 않은 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/login";
		}
		
		// 관리자인지 일반 회원인지 확인(일반 회원이라면 홈화면으로 redirect)
		Member loginMember = (Member) session.getAttribute("loginMember");	
		if(loginMember.getMemberLevel() == 0) {
			return "redirect:/home";
		}
		
		// Member 객체에 입력한 비밀번호 추가
		loginMember.setMemberPw(password);
		
		// 비밀번호 확인(비밀번호가 틀렸다면 공지 화면으로 redirect)
		int checkPassword = noticeService.checkPassword(loginMember);
		if(checkPassword == 0) { 
			return "redirect:/notice";
		}
		// 수정(비밀번호 확인 완료 후 작업)
		int result = noticeService.updateNotice(paramNotice);
		
		log.debug("공지 수정(성공:1,실패:0)" + result);
		
		return "redirect:/noticeOne?noticeNo=" + paramNotice.getNoticeNo();
	}
	
	@GetMapping("/deleteNotice")
	public String deleteNotice(HttpSession session, int noticeNo, Model model) {
		
		// session 유효성 검사
		if(session.getAttribute("loginMember") == null) {
			// 로그인이 되어 있지 않은 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/login";
		}
		
		// 관리자인지 일반 회원인지 확인(일반 회원이라면 공지화면으로 redirect)
		Member loginMember = (Member) session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() == 0) {
			return "redirect:/notice";
		}
		
		model.addAttribute("noticeNo", noticeNo);
		
		return "notice/deleteNotice";
	}
	
	@PostMapping("/deleteNotice")
	public String deleteNotice(HttpSession session, int noticeNo, String memberPw) {
		
		// session 유효성 검사
		if(session.getAttribute("loginMember") == null) {
			// 로그인이 되어 있지 않은 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/login";
		}
				
		// 관리자인지 일반 회원인지 확인(일반 회원이라면 홈화면으로 redirect)
		Member loginMember = (Member) session.getAttribute("loginMember");	
		if(loginMember.getMemberLevel() == 0) {
			return "redirect:/home";
		}

		// Member 객체에 입력한 비밀번호 추가
		loginMember.setMemberPw(memberPw);
		// 비밀번호 확인(비밀번호가 틀렸다면 공지 화면으로 redirect)
		int checkPassword = noticeService.checkPassword(loginMember);
		if(checkPassword == 0) {
			return "redirect:/notice";
		}
				
		// 삭제하려는 공지의 모든 댓글 삭제(비밀번호 확인 완료 후 작업)
		int deleteCommentCnt = commentService.deleteAllComments(noticeNo);
		
		log.debug("삭제된 댓글 개수 : " + deleteCommentCnt);
		
		// 공지 삭제(비밀번호 확인 완료 후 작업)
		int result = noticeService.deleteNotice(noticeNo);
		
		log.debug("공지 삭제(성공:1,실패:0) : " + result);
				
		return "redirect:/notice";
	}

}
