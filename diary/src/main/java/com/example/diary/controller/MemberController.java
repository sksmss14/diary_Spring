package com.example.diary.controller;

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
		return "redirect:/home";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		return "redirect:/login";
	}
	
	// 회원가입 폼
	@GetMapping("/addMember")
	public String addMember() {
		
		return "member/addMember";
	}
	
	// 회원가입 액션
	@PostMapping("/addMember")
	public String addMember(Member member) {
		
		int result = memberService.addMember(member);
		System.out.println("MemberController addMember : " + result);
		
		return "redirect:/login";
	}
	
	@GetMapping("/home")
	public String home(Model model, HttpSession session) {
		
		Member loginMember = (Member) session.getAttribute("loginMember");
		if(loginMember == null) {
			return "redirect:/login";
		}
		
		return "home";
	}
}
