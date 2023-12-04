package com.example.diary.vo;

import lombok.Data;

@Data
public class Comment {
	private int commentNo;
	private int noticeNo;
	private String memberId;
	private String comment;
	private String createdate;
	private String isSecret;
}
