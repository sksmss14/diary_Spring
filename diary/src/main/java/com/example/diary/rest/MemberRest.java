package com.example.diary.rest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.diary.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class MemberRest {
	
	private MemberService memberService;
	
	public MemberRest(MemberService memberService) {
		this.memberService = memberService;
	}
	
	@GetMapping("/idCheck")
	public int idCheck(String memberId) {
		
		int result = memberService.idCheck(memberId);
		
		log.debug("아이디 중복 체크(중복o:1,중복x:0) : " + result);
		
		return result;
	}
}
