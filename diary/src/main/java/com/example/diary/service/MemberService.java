package com.example.diary.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.example.diary.mapper.MemberMapper;
import com.example.diary.vo.Member;

@Service
@Transactional
public class MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	// 로그인
	public Member login(Member paramMember) {
		
		Member resultMember = memberMapper.login(paramMember);
		if(resultMember != null) {
			System.out.println("MemberService login : " + resultMember.toString());
		}
		return resultMember;
	}
	
	// 회원가입
	public int addMember(Member paramMember) {
		
		int result = memberMapper.insertMember(paramMember);
		System.out.println("MemberService addMember : " + result);
		return result;
	}

}
