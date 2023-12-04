package com.example.diary.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.diary.mapper.ScheduleMapper;
import com.example.diary.vo.Schedule;

@Service
@Transactional
public class ScheduleService {
	
	@Autowired private ScheduleMapper scheduleMapper;
	
	public List<Map<String, Object>> getScheduleListByMonth(Map<String, Object> paramMap) {
		
		List<Map<String, Object>> selectScheduleListByMonth = scheduleMapper.selectScheduleListByMonth(paramMap);
		// 디버깅 코드
		System.out.println("ScheduleService getScheduleListByMonth : " + selectScheduleListByMonth);
		return selectScheduleListByMonth;
	}
	
	public List<Schedule> getScheduleByDay(Map<String, Object> paramMap) {
		
		List<Schedule> selectScheduleByDay = scheduleMapper.selectScheduleByDay(paramMap);
		// 디버깅 코드
		System.out.println("ScheduleService getScheduleListByDay : " + selectScheduleByDay);
		return selectScheduleByDay;
	}
	
	public int addSchedule(Map<String, Object> paramMap) {
		int result = scheduleMapper.addSchedule(paramMap);
		// 디버깅 코드
		System.out.println("ScheduleService 일정 추가(성공:1,실패:0) : " + result);
		return result;
	}
	
	public int updateSchedule(Schedule paramSchedule) {
		int result = scheduleMapper.updateSchedule(paramSchedule);
		// 디버깅 코드
		System.out.println("ScheduleService 일정 수정(성공:1,실패:0) : " + result);
		return result;
	}
	
	public int deleteSchedule(int scheduleNo) {
		int result = scheduleMapper.deleteSchedule(scheduleNo);
		// 디버깅 코드
		System.out.println("ScheduleService 일정 삭제(성공:1,실패:0) : " + result);
		return result;
	}

}
