package com.example.diary.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.diary.service.MemberService;
import com.example.diary.vo.Member;

import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/login")
	public String login(HttpSession session) {
		// 로그인이 되어 있다면 home 화면으로 redirect
		if(session.getAttribute("loginMember") != null) {
			return "redirect:/home";
		}
				
		return "member/loginMember";
	}
	
	@PostMapping("/login") 
	public String login(HttpSession session, Member paramMember) { // 오버로딩 사용
		
		Member loginMember = memberService.login(paramMember);
		// 로그인을 실패하였다면 로그인 화면으로 redirect
		if(loginMember == null) {
			return "redirect:/login";
		}
		
		System.out.println("MemberController login : " + loginMember.toString());
		session.setAttribute("loginMember", loginMember);
		System.out.println("로그인 성공 : " + loginMember.getMemberId());
		return "redirect:/home";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		return "redirect:/login";
	}
	
	// 회원가입 폼
	@GetMapping("/addMember")
	public String addMember(HttpSession session) {
		
		if(session.getAttribute("loginMember") != null) {
			// 로그인이 되어 있는 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/home";
		}
		
		return "member/addMember";
	}
	
	// 회원가입 액션
	@PostMapping("/addMember")
	public String addMember(HttpSession session, Member member) {
		
		if(session.getAttribute("loginMember") != null) {
			// 로그인이 되어 있는 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/home";
		}
		
		int result = memberService.addMember(member);
		System.out.println("MemberController addMember : " + result);
		
		return "redirect:/login";
	}
	
	// 비밀번호 변경 폼
	@GetMapping("/updateMemberPw")
	public String updateMemberPw(HttpSession session) {
		
		if(session.getAttribute("loginMember") == null) {
			// 로그인이 되어 있지 않은 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/login";
		}
		
		return "member/updateMemberPw";
	}
	
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
		System.out.println("MemberController updateMemberPw(성공:1,실패:0) : " + result);
		if(result != 1) {
			return "redirect:/home";
		}
		
		session.invalidate();
		return "redirect:/login";
	}
	
	@GetMapping("/deleteMember")
	public String deleteMember(HttpSession session) {
		
		if(session.getAttribute("loginMember") == null) {
			// 로그인이 되어 있지 않은 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/login";
		}
		
		return "member/deleteMember";
	}
	
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
		System.out.println("MemberController deleteMember(성공:1,실패:0) : " + result);
		if(result != 1) {
			return "redirect:/home";
		}
		
		session.invalidate();
		return "redirect:/login";
		
	}
	
}
