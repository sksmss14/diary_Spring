package com.example.diary.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.diary.vo.Member;
import com.example.diary.vo.Notice;

@Mapper
public interface NoticeMapper {
	
	List<Notice> selectNoticeList();
	Notice selectNoticeOne(int noticeNo);
	
	int addNotice(Notice notice);
	
	String checkPassword(Member member); // 비밀번호 확인이 성공하면 memberId를 반환한다.
	int updateNotice(Notice notice);
	int deleteNotice(int noticeNo);
	
}
