package com.example.diary.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.diary.service.MemberService;
import com.example.diary.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	
	private MemberService memberService;
	
	// 생성자 주입(@Autowired 생략)
	public MemberController(MemberService memberService) {
		this.memberService = memberService;
	}
	
	// 로그인(get)
	@GetMapping("/login")
	public String login(HttpSession session) {
		// 로그인이 되어 있다면 home 화면으로 redirect
		if(session.getAttribute("loginMember") != null) {
			return "redirect:/home";
		}
				
		return "member/loginMember";
	}
	
	// 로그인(post)
	@PostMapping("/login") 
	public String login(HttpSession session, Member paramMember) { // 오버로딩 사용
		
		Member loginMember = memberService.login(paramMember);
		// 로그인을 실패하였다면 로그인 화면으로 redirect
		if(loginMember == null) {
			return "redirect:/login";
		}

		log.debug("로그인 성공 : " + loginMember);
		
		session.setAttribute("loginMember", loginMember);
		return "redirect:/home";
	}
	
	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		return "redirect:/login";
	}
	
	// 회원가입(get)
	@GetMapping("/addMember")
	public String addMember(HttpSession session) {
		
		if(session.getAttribute("loginMember") != null) {
			// 로그인이 되어 있는 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/home";
		}
		
		return "member/addMember";
	}
	
	@ResponseBody
	@GetMapping("/idCheck")
	public int idCheck(String memberId) {
		
		int result = memberService.idCheck(memberId);
		
		log.debug("아이디 중복 체크(중복o:1,중복x:0) : " + result);
		
		return result;
	}
	
	// 회원가입(post)
	@PostMapping("/addMember")
	public String addMember(HttpSession session, Member member) {
		
		if(session.getAttribute("loginMember") != null) {
			// 로그인이 되어 있는 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/home";
		}
		
		int result = memberService.addMember(member);
		
		log.debug("회원가입(성공:1,실패:0) : " + result);
		
		return "redirect:/login";
	}
	
	// 비밀번호 변경(get)
	@GetMapping("/updateMemberPw")
	public String updateMemberPw(HttpSession session) {
		
		if(session.getAttribute("loginMember") == null) {
			// 로그인이 되어 있지 않은 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/login";
		}
		
		return "member/updateMemberPw";
	}
	
	// 비밀번호 변경(post)
	@PostMapping("/updateMemberPw")
	public String updateMemberPw(HttpSession session, String oldPw, String newPw) {
		
		if(session.getAttribute("loginMember") == null) {
			// 로그인이 되어 있지 않은 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/login";
		}
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("memberId", memberId);
		paramMap.put("oldPw", oldPw);
		paramMap.put("newPw", newPw);
		
		int result = memberService.updateMemberPw(paramMap);
		
		log.debug("회원 비밀번호 변경(성공:1,실패:0) : " + result);
		
		if(result != 1) {
			return "redirect:/home";
		}
		
		session.invalidate();
		return "redirect:/login";
	}
	
	// 회원탈퇴(get)
	@GetMapping("/deleteMember")
	public String deleteMember(HttpSession session) {
		
		if(session.getAttribute("loginMember") == null) {
			// 로그인이 되어 있지 않은 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/login";
		}
		
		return "member/deleteMember";
	}
	
	// 회원탈퇴(post)
	@PostMapping("/deleteMember")
	public String deleteMember(HttpSession session, String memberPw) {
		
		if(session.getAttribute("loginMember") == null) {
			// 로그인이 되어 있지 않은 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/login";
		}
		
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("memberId", memberId);
		paramMap.put("memberPw", memberPw);
		
		int result = memberService.deleteMember(paramMap);
		
		log.debug("회원탈퇴(성공:1,실패:0) : " + result);
		
		if(result != 1) {
			return "redirect:/home";
		}
		
		session.invalidate();
		return "redirect:/login";
		
	}
	
}
