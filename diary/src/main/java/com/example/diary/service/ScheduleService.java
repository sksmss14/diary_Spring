package com.example.diary.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.diary.mapper.ScheduleMapper;
import com.example.diary.vo.Schedule;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class ScheduleService {
	
	private ScheduleMapper scheduleMapper;
	
	// 생성자 주입(@Autowired 생략)
	public ScheduleService(ScheduleMapper scheduleMapper) {
		this.scheduleMapper = scheduleMapper;
	}
	
	public List<Map<String, Object>> getScheduleListByMonth(Map<String, Object> paramMap) {
		
		List<Map<String, Object>> selectScheduleListByMonth = scheduleMapper.selectScheduleListByMonth(paramMap);
		
		log.debug("달력 데이터 목록 : " + selectScheduleListByMonth);
		
		return selectScheduleListByMonth;
	}
	
	public List<Schedule> getScheduleByDay(Map<String, Object> paramMap) {
		
		List<Schedule> selectScheduleByDay = scheduleMapper.selectScheduleByDay(paramMap);

		log.debug("날짜별 일정 목록 : " + selectScheduleByDay);
		
		return selectScheduleByDay;
	}
	
	public int addSchedule(Map<String, Object> paramMap,
							int scheduleYear, int scheduleMonth, int scheduleDay) {
		
		String scheduleDate = scheduleYear + "-" + scheduleMonth + "-" + scheduleDay;
		paramMap.put("scheduleDate", scheduleDate);
		
		int result = scheduleMapper.addSchedule(paramMap);

		log.debug("일정 추가(성공:1,실패:0) : " + result);
		
		return result;
	}
	
	public int updateSchedule(Schedule paramSchedule) {
		int result = scheduleMapper.updateSchedule(paramSchedule);
	
		log.debug("일정 수정(성공:1,실패:0) : " + result);
		
		return result;
	}
	
	public int deleteSchedule(int scheduleNo) {
		int result = scheduleMapper.deleteSchedule(scheduleNo);

		log.debug("일정 삭제(성공:1,실패:0) : " + result);
		
		return result;
	}

}
