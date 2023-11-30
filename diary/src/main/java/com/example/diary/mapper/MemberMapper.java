package com.example.diary.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.diary.vo.Member;

@Mapper
public interface MemberMapper {
	
	Member login(Member member);
	
	// 회원가입
	int insertMember(Member member);
	
}
