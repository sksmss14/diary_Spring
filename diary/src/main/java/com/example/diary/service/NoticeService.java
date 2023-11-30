package com.example.diary.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.example.diary.mapper.NoticeMapper;
import com.example.diary.vo.Notice;

public class NoticeService {
	
	@Autowired
	NoticeMapper noticeMapper;

		public int addNotice(Notice paramNotice) {
			
			int result = noticeMapper.insertNotice(paramNotice);
			// 디버깅 코드
			System.out.println("NoticeService addNotice : " + result);
			return result;
		}
}
