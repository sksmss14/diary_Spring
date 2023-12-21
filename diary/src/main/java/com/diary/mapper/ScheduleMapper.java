package com.diary.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.diary.vo.Schedule;

@Mapper
public interface ScheduleMapper {
	
	List<Map<String, Object>> selectScheduleListByMonth(Map<String, Object> paramMap);
	
	List<Schedule> selectScheduleByDay(Map<String, Object> paramMap);
	
	int addSchedule(Map<String, Object> paramMap);
	
	int updateSchedule(Schedule paramSchedule);
	
	int deleteSchedule(int scheduleNo);
}
