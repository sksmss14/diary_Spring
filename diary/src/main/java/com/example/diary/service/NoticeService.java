package com.example.diary.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.diary.mapper.NoticeMapper;
import com.example.diary.vo.Member;
import com.example.diary.vo.Notice;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class NoticeService {
	
	private NoticeMapper noticeMapper;
	
	// 생성자 주입(@Autowired 생략)
	public NoticeService(NoticeMapper noticeMapper) {
		this.noticeMapper = noticeMapper;
	}
	
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
