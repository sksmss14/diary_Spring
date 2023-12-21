package com.diary.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.diary.mapper.ScheduleMapper;
import com.diary.vo.Schedule;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor // 클래스에 선언된 final 필드들을 매개변수로 하는 생성자를 자동으로 생성
@Transactional
@Service
public class ScheduleService {
	
	private final ScheduleMapper scheduleMapper;
		
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
