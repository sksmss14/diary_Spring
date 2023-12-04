package com.example.diary.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.diary.service.ScheduleService;
import com.example.diary.vo.Member;
import com.example.diary.vo.Schedule;

import jakarta.servlet.http.HttpSession;

@Controller
public class ScheduleController {
	
	@Autowired
	ScheduleService scheduleService;
	
	@GetMapping("/scheduleByDay")
	public String scheduleByDay(HttpSession session, Model model,
									int scheduleYear, int scheduleMonth,
									int scheduleDay) {
		
		if(session.getAttribute("loginMember") == null) {
			// 로그인이 되어 있지 않은 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/login";
		}		
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		model.addAttribute("scheduleYear", scheduleYear);
		model.addAttribute("scheduleMonth", scheduleMonth);
		model.addAttribute("scheduleDay", scheduleDay);
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("memberId", loginMember.getMemberId());
		paramMap.put("scheduleYear", scheduleYear);
		paramMap.put("scheduleMonth", scheduleMonth);
		paramMap.put("scheduleDay", scheduleDay);
		List<Schedule> list = scheduleService.getScheduleByDay(paramMap);
		model.addAttribute("list", list);
		
		return "schedule/scheduleByDay";
	}
	
	@PostMapping("/scheduleByDay")
	public String scheduleByDay(HttpSession session,
									int scheduleYear, int scheduleMonth, 
									int scheduleDay, String scheduleMemo,
									int scheduleEmoji) {
		
		if(session.getAttribute("loginMember") == null) {
			// 로그인이 되어 있지 않은 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/login";
		}
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		String scheduleDate = scheduleYear + "-" + scheduleMonth + "-" + scheduleDay;
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("memberId", loginMember.getMemberId());
		paramMap.put("scheduleDate", scheduleDate);
		paramMap.put("scheduleMemo", scheduleMemo);
		paramMap.put("scheduleEmoji", scheduleEmoji);
		int result = scheduleService.addSchedule(paramMap);
			
		return "redirect:/scheduleByDay?scheduleYear=" + scheduleYear + "&scheduleMonth=" + scheduleMonth + "&scheduleDay=" + scheduleDay;
		
	}
	
	@GetMapping("/updateSchedule")
	public String updateSchedule(HttpSession session, Model model,
									int scheduleNo, String scheduleMemo,
									int scheduleEmoji,
									int scheduleYear, int scheduleMonth,
									int scheduleDay) {
		
		if(session.getAttribute("loginMember") == null) {
			// 로그인이 되어 있지 않은 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/login";
		}
		model.addAttribute("scheduleNo", scheduleNo);
		model.addAttribute("scheduleMemo", scheduleMemo);
		model.addAttribute("scheduleEmoji", scheduleEmoji);
		
		model.addAttribute("scheduleYear", scheduleYear);
		model.addAttribute("scheduleMonth", scheduleMonth);
		model.addAttribute("scheduleDay", scheduleDay);
		
		return "schedule/updateSchedule";
	}
	
	@PostMapping("/updateSchedule")
	public String updateSchedule(HttpSession session, 
									int scheduleNo, String scheduleMemo,
									int scheduleEmoji,
									int scheduleYear, int scheduleMonth, 
									int scheduleDay) {
		
		if(session.getAttribute("loginMember") == null) {
			// 로그인이 되어 있지 않은 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/login";
		}
		
		Schedule s = new Schedule();
		s.setScheduleNo(scheduleNo);
		s.setScheduleMemo(scheduleMemo);
		s.setScheduleEmoji(scheduleEmoji);
		int result = scheduleService.updateSchedule(s);
		
		return "redirect:/scheduleByDay?scheduleYear=" + scheduleYear + "&scheduleMonth=" + scheduleMonth + "&scheduleDay=" + scheduleDay;
	}
	
	@GetMapping("/deleteSchedule")
	public String deleteSchedule(HttpSession session,
									int scheduleNo, int scheduleYear,
									int scheduleMonth, int scheduleDay) {
		
		if(session.getAttribute("loginMember") == null) {
			// 로그인이 되어 있지 않은 상태
			// 리다이렉트할 컨트롤러 url
			return "redirect:/login";
		}
		
		int result = scheduleService.deleteSchedule(scheduleNo);
		
		return "redirect:/scheduleByDay?scheduleYear=" + scheduleYear + "&scheduleMonth=" + scheduleMonth + "&scheduleDay=" + scheduleDay;
	}
}
