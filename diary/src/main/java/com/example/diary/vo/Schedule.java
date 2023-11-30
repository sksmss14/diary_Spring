package com.example.diary.vo;

import lombok.Data;

@Data
public class Schedule {
	private int scheduleNo;
	private String memberId;
	private String scheduleDate;
	private String scheduleMemo;
	private String createdate;
}
