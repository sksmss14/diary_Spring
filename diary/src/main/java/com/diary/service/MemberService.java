package com.diary.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.diary.mapper.MemberMapper;
import com.diary.vo.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor // 클래스에 선언된 final 필드들을 매개변수로 하는 생성자를 자동으로 생성
@Transactional
@Service
public class MemberService {
	
	private final MemberMapper memberMapper;
		
	public int idCheck(String memberId) {
		
		int result = memberMapper.idCheck(memberId);
		
		log.debug("아이디 중복 체크(중복o:1,중복x:0) : " + result);
		
		return result;
	}
	
	public Member login(Member paramMember) {
		
		Member resultMember = memberMapper.login(paramMember);
		
		log.debug("로그인 성공 여부 확인(실패:null) : " + resultMember);

		return resultMember;
	}
	
	public int addMember(Member paramMember) {
		
		int result = memberMapper.insertMember(paramMember);

		log.debug("회원가입(성공:1,실패:0) : " + result);
		
		return result;
	}
	
	public int updateMemberPw(Map<String, Object> paramMap) {
		
		int result = memberMapper.updateMemberPw(paramMap);
		
		log.debug("회원 비밀번호 변경(성공:1,실패:0) : " + result);
		
		return result;
	}
	
	public int deleteMember(Map<String, Object> paramMap) {
		
		int result = memberMapper.deleteMember(paramMap);
		
		log.debug("회원탈퇴(성공:1,실패:0) : " + result);
		
		return result;
	}
	
}
