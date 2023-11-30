package com.example.diary.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.diary.vo.Notice;

@Mapper
public interface NoticeMapper {
	
	int insertNotice(Notice notice);
	
}
