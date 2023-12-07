package com.example.diary.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.diary.service.CalendarService;
import com.example.diary.service.ScheduleService;
import com.example.diary.vo.Member;
import com.example.diary.vo.Schedule;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	private CalendarService calendarService;
	private ScheduleService scheduleService;
	
	// 생성자 주입(@Autowired 생략)
	public HomeController(CalendarService calendarService, ScheduleService scheduleService) {
		this.calendarService = calendarService;
		this.scheduleService = scheduleService;
	}
	
	@GetMapping("/home")
	public String home(HttpSession session, Model model,
			Integer targetYear, Integer targetMonth) {
		// 로그인 후에만 접근 가능
		if(session.getAttribute("loginMember") == null) {
			return "redirect:/login";
		}
		Member loginMember = (Member) session.getAttribute("loginMember");
						
		Map<String, Object> calendarMap = calendarService.getCalendar(targetYear, targetMonth);
		model.addAttribute("calendarMap", calendarMap);
		
		log.debug("달력 레이아웃 parameter : " + calendarMap);
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("memberId", loginMember.getMemberId());
		paramMap.put("year", calendarMap.get("targetYear"));
		paramMap.put("month", (Integer) calendarMap.get("targetMonth")+1);
		
		List<Map<String, Object>> list = scheduleService.getScheduleListByMonth(paramMap);
		model.addAttribute("list", list);
		
		log.debug("달력 데이터 목록 : " + calendarMap);
		
		return "home";
	}
		
	@GetMapping("/updateCalendar")
	public String lastCalendar(HttpSession session, Model model,
								Integer targetYear, Integer targetMonth) {		
		// 로그인 후에만 접근 가능
		if(session.getAttribute("loginMember") == null) {
			return "redirect:/login";
		}
		Member loginMember = (Member) session.getAttribute("loginMember");
				
		Map<String, Object> calendarMap = calendarService.getCalendar(targetYear, targetMonth);
		model.addAttribute("calendarMap", calendarMap);
		
		log.debug("달력 레이아웃 parameter : " + calendarMap);
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("memberId", loginMember.getMemberId());
		paramMap.put("year", calendarMap.get("targetYear"));
		paramMap.put("month", (Integer) calendarMap.get("targetMonth")+1);
		
		List<Map<String, Object>> list = scheduleService.getScheduleListByMonth(paramMap);
		model.addAttribute("list", list);
		
		log.debug("달력 데이터 목록 : " + calendarMap);
		
		return "calendar/calendarFragment";
	}
}
