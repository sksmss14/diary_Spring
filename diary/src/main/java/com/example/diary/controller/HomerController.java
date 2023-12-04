package com.example.diary.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.diary.service.CalendarService;
import com.example.diary.service.ScheduleService;
import com.example.diary.vo.Member;
import com.example.diary.vo.Schedule;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomerController {
	
	@Autowired CalendarService calendarService;
	@Autowired ScheduleService scheduleService;
	
	@GetMapping("/home")
	public String home(HttpSession session, Model model,
						@RequestParam(required = false) Integer targetYear,
						@RequestParam(required = false) Integer targetMonth
						) {
		// 로그인 후에만 접근 가능
		if(session.getAttribute("loginMember") == null) {
			return "redirect:/login";
		}
		Member loginMember = (Member) session.getAttribute("loginMember");
				
		Map<String, Object> calendarMap = calendarService.getCalendar(targetYear, targetMonth);
		model.addAttribute("calendarMap", calendarMap);
			
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("memberId", loginMember.getMemberId());
		paramMap.put("year", calendarMap.get("targetYear"));
		paramMap.put("month", (Integer) calendarMap.get("targetMonth")+1);
		List<Map<String, Object>> list = scheduleService.getScheduleListByMonth(paramMap);
		model.addAttribute("list", list);
		
		return "home";
	}
}
