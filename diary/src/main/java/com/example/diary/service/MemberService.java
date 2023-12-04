package com.example.diary.service;

import java.util.Map;

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
		// 디버깅 코드
		System.out.println("MemberService addMember : " + result);
		return result;
	}
	
	public int updateMemberPw(Map<String, Object> paramMap) {
		int result = memberMapper.updateMemberPw(paramMap);
		// 디버깅 코드
		System.out.println("MemberService updateMemberPw(성공:1, 실패:0) : " + result);
		return result;
	}
	
	public int deleteMember(Map<String, Object> paramMap) {
		
		int result = memberMapper.deleteMember(paramMap);
		// 디버깅 코드
		System.out.println("MemberService deleteMember(성공:1, 실패:0) : " + result);
		return result;
	}

}
