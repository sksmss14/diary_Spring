package com.example.diary.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.diary.mapper.NoticeMapper;
import com.example.diary.vo.Member;
import com.example.diary.vo.Notice;

@Service
@Transactional
public class NoticeService {
	
	@Autowired
	private NoticeMapper noticeMapper;
	
	public List<Notice> selectNoticeList(Notice paramNotice) {
		
		List<Notice> noticeList = noticeMapper.selectNoticeList();
		// 디버깅 코드
		System.out.println("NoticeService selectNotice : " + noticeList.toString());
		
		return noticeList;
	}
	
	public Notice selectNoticeOne(int noticeNo) {
		
		Notice selectNoticeOne = noticeMapper.selectNoticeOne(noticeNo);
		// 디버깅 코드
		System.out.println("NoticeService selectNoticeOne : " + selectNoticeOne.toString());
		return selectNoticeOne;
	}

	public int addNotice(Notice paramNotice) {
		
		int result = noticeMapper.addNotice(paramNotice);
		// 디버깅 코드
		System.out.println("NoticeService addNotice : " + result);
		return result;
	}
	
	public String checkPassword(Member paramMember) {
		
		String checkPassword = noticeMapper.checkPassword(paramMember);
		// 디버깅 코드
		System.out.println("NoticeService checkPassword : memberId= " + checkPassword);
		return checkPassword;
	}
	
	public int updateNotice(Notice paramNotice) {
		int result = noticeMapper.updateNotice(paramNotice);
		// 디버깅 코드
		System.out.println("NoticeService updateNotice : " + result);
		return result;
	}
	
	public int deleteNotice(int noticeNo) {
		int result = noticeMapper.deleteNotice(noticeNo);
		// 디버깅 코드
		System.out.println("NoticeService deleteNotice(성공:1, 실패:0) : " + result);
		return result;
	}
			
}
