package com.example.diary.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.diary.vo.Comment;
import com.example.diary.vo.Member;

@Mapper
public interface CommentMapper {

	int getCommentCount(int noticeNo);
	
	List<Comment> selectCommentList(int noticeNo);
	
	Comment selectCommentOne(int commentNo);
		
	int addComment(Comment comment);
	
	String checkPassword(Member member);
	int updateComment(Comment comment);
	
	int deleteAllComments(int noticeNo);
	
	int deleteComment(int commentNo);
}
