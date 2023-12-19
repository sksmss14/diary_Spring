package com.example.diary.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.diary.service.ScheduleService;
import com.example.diary.vo.Member;
import com.example.diary.vo.Schedule;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor // 클래스에 선언된 final 필드들을 매개변수로 하는 생성자를 자동으로 생성
@Controller
public class ScheduleController {
	
	private final ScheduleService scheduleService;
		
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
		
		log.debug("일정 목록 : " + list);
		
		model.addAttribute("list", list);
		
		return "schedule/scheduleByDay";
	}
	
	@PostMapping("/addSchedule")
	public String scheduleByDay(HttpSession session, Model model,
									int scheduleYear, int scheduleMonth, 
									int scheduleDay, String scheduleMemo,
									int scheduleEmoji) {
		
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		Map<String, Object> paramMap1 = new HashMap<>();
		
		try {
			paramMap1.put("memberId", loginMember.getMemberId()); 
		} catch(NullPointerException e) {
			log.error("로그아웃하고 접근시 NullPointerException 발생 -> null을 반환하면 ajax error 코드 실행");
			return null;
		}
		paramMap1.put("scheduleMemo", scheduleMemo);
		paramMap1.put("scheduleEmoji", scheduleEmoji);
		
		// 일정 추가
		int result = scheduleService.addSchedule(paramMap1, scheduleYear, scheduleMonth, scheduleDay);
		
		log.debug("일정 추가(성공:1,실패0) : " + result);
		
		Map<String, Object> paramMap2 = new HashMap<>();
		paramMap2.put("memberId", loginMember.getMemberId());
		paramMap2.put("scheduleYear", scheduleYear);
		paramMap2.put("scheduleMonth", scheduleMonth);
		paramMap2.put("scheduleDay", scheduleDay);
		
		// 일정 추가 후 view에 보낼 일정 목록
		List<Schedule> list = scheduleService.getScheduleByDay(paramMap2);
		
		log.debug("일정 목록 : " + list);
		
		model.addAttribute("list", list);
		
		// 수정 링크의 parameter
		model.addAttribute("scheduleYear", scheduleYear);
		model.addAttribute("scheduleMonth", scheduleMonth);
		model.addAttribute("scheduleDay", scheduleDay);
			
		return "schedule/scheduleFragment";
		
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
		
		log.debug("일정 수정(성공:1,실패:0) : " + result);
		
		return "redirect:/scheduleByDay?scheduleYear=" + scheduleYear + "&scheduleMonth=" + scheduleMonth + "&scheduleDay=" + scheduleDay;
	}
	
	@GetMapping("/deleteSchedule")
	public String deleteSchedule(HttpSession session, Model model,
									int scheduleNo, int scheduleYear,
									int scheduleMonth, int scheduleDay) {
		
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		// 일정 삭제
		int result = scheduleService.deleteSchedule(scheduleNo);
		
		log.debug("일정 삭제(성공:1,실패:0) : " + result);
		
		Map<String, Object> paramMap = new HashMap<>();
		try {
			paramMap.put("memberId", loginMember.getMemberId()); 
		} catch(NullPointerException e) {
			log.error("로그아웃하고 접근시 NullPointerException 발생 -> null을 반환하면 ajax error 코드 실행");
			return null;
		}
		paramMap.put("scheduleYear", scheduleYear);
		paramMap.put("scheduleMonth", scheduleMonth);
		paramMap.put("scheduleDay", scheduleDay);
		
		// 일정 삭제 후 view에 보낼 일정 목록
		List<Schedule> list = scheduleService.getScheduleByDay(paramMap);
		
		log.debug("일정 목록 : " + list);
		
		model.addAttribute("list", list);
		
		// 수정 링크의 parameter
		model.addAttribute("scheduleYear", scheduleYear);
		model.addAttribute("scheduleMonth", scheduleMonth);
		model.addAttribute("scheduleDay", scheduleDay);
		
		return "schedule/scheduleFragment";
	}
}
