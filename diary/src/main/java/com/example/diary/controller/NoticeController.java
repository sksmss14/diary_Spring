package com.example.diary.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.diary.service.NoticeService;
import com.example.diary.vo.Notice;

public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	@GetMapping("/addNotice")
	public String addNotice() {
		
		return "notice/addNotice";
	}
	
	@PostMapping("/addNotice")
	public String addNotice(Notice paramNotice) {
		
		int result = noticeService.addNotice(paramNotice);
		System.out.println("NoticeController addNotice : " + result);
		
		return "redirect:/notice";
	}

}
