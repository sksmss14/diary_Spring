package com.example.diary.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.diary.vo.Member;

@Mapper
public interface MemberMapper {
	
	// 로그인
	int idCheck(String memberId);
	Member login(Member member);
	
	// 회원가입
	int insertMember(Member member);
	
	// 비밀번호 수정
	int updateMemberPw(Map<String, Object> paramMap);
	
	// 회원 탈퇴
	int deleteMember(Map<String, Object> paramMap);
	
}
