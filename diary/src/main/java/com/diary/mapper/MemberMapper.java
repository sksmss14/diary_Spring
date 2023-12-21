package com.diary.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.diary.vo.Member;

@Mapper
public interface MemberMapper {
	
	int idCheck(String memberId);
	Member login(Member member);
	
	int insertMember(Member member);
	
	int updateMemberPw(Map<String, Object> paramMap);
	
	int deleteMember(Map<String, Object> paramMap);
	
}
