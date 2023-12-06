package com.example.diary.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.example.diary.mapper.MemberMapper;
import com.example.diary.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class MemberService {
	
	private MemberMapper memberMapper;
	
	// 생성자 주입(@Autowired 생략)
	public MemberService(MemberMapper memberMapper) {
		this.memberMapper = memberMapper;
	}
	
	// 아이디 중복 체크
	public int idCheck(String memberId) {
		int result = memberMapper.idCheck(memberId);
		
		log.debug("아이디 중복 체크(중복o:1,중복x:0) : " + result);
		
		return result;
	}
	
	// 로그인
	public Member login(Member paramMember) {
		
		Member resultMember = memberMapper.login(paramMember);
		
		log.debug("로그인 성공 : " + resultMember);

		return resultMember;
	}
	
	// 회원가입
	public int addMember(Member paramMember) {
		
		int result = memberMapper.insertMember(paramMember);

		log.debug("회원가입(성공:1,실패:0) : " + result);
		
		return result;
	}
	
	// 비밀번호 변경
	public int updateMemberPw(Map<String, Object> paramMap) {
		int result = memberMapper.updateMemberPw(paramMap);
		
		log.debug("회원 비밀번호 변경(성공:1,실패:0) : " + result);
		
		return result;
	}
	
	// 회원탈퇴
	public int deleteMember(Map<String, Object> paramMap) {
		
		int result = memberMapper.deleteMember(paramMap);
		
		log.debug("회원탈퇴(성공:1,실패:0) : " + result);
		
		return result;
	}

}
