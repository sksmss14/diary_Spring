package com.diary.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.diary.mapper.NoticeMapper;
import com.diary.vo.Member;
import com.diary.vo.Notice;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor // 클래스에 선언된 final 필드들을 매개변수로 하는 생성자를 자동으로 생성
@Transactional
@Service
public class NoticeService {
	
	private final NoticeMapper noticeMapper;
		
	public List<Notice> selectNoticeList(Notice paramNotice) {
		
		List<Notice> noticeList = noticeMapper.selectNoticeList();

		log.debug("공지 목록 : " + noticeList);
		
		return noticeList;
	}
	
	public Notice selectNoticeOne(int noticeNo) {
		
		Notice selectNoticeOne = noticeMapper.selectNoticeOne(noticeNo);

		log.debug("공지 상세 : " + selectNoticeOne);
		
		return selectNoticeOne;
	}

	public int addNotice(Notice paramNotice) {
		
		int result = noticeMapper.addNotice(paramNotice);

		log.debug("공지 추가(성공:1,실패:0) : " + result);
		
		return result;
	}
	
	public int checkPassword(Member paramMember) {
		
		int checkPassword = noticeMapper.checkPassword(paramMember);

		log.debug("비밀번호 확인(성공:1,실패:0) : " + checkPassword);
		
		return checkPassword;
	}
	
	public int updateNotice(Notice paramNotice) {
		
		int result = noticeMapper.updateNotice(paramNotice);

		log.debug("공지 수정 (성공:1,실패:0) : " + result);
		
		return result;
	}
	
	public int deleteNotice(int noticeNo) {
		
		int result = noticeMapper.deleteNotice(noticeNo);

		log.debug("공지 삭제 (성공:1,실패:0) : " + result);
		
		return result;
	}
			
}
