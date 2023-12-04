package com.example.diary.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.diary.mapper.CommentMapper;
import com.example.diary.vo.Comment;
import com.example.diary.vo.Member;

@Service
@Transactional
public class CommentService {
	
	@Autowired
	CommentMapper commentMapper;
	
	public int getCommentCount(int noticeNo) {
		
		int result = commentMapper.getCommentCount(noticeNo);
		// 디버깅
		System.out.println("CommentService getCommentCount : " + result);
		return result;
	}
	
	public List<Comment> selectCommentList(int noticeNo) {
		
		List<Comment> selectCommentList= commentMapper.selectCommentList(noticeNo);
		// 디버깅
		System.out.println("CommentService selectCommentList : " + selectCommentList);
		return selectCommentList;	
	}
	
	public Comment selectCommentOne(int commentNo) {
		
		Comment selectCommentOne = commentMapper.selectCommentOne(commentNo);
		// 디버깅
		System.out.println("CommentService selectCommentOne : " + selectCommentOne);
		return selectCommentOne;
	}
	
	public int addComment(Comment comment) {
		int result = commentMapper.addComment(comment);
		// 디버깅 코드
		System.out.println("commentService 댓글 추가(성공:1, 실패:0) : " + result);
		return result;
	}
	
	public String checkPassword(Member paramMember) {
		
		String checkPassword = commentMapper.checkPassword(paramMember);
		// 디버깅 코드
		System.out.println("CommentService checkPassword : memberId= " + checkPassword);
		return checkPassword;
	}
	
	public int updateComment(Comment comment) {
		int result = commentMapper.updateComment(comment);
		// 디버깅 코드
		System.out.println("commentService 댓글 수정(성공:1, 실패:0) : " + result);
		return result;
	}
	
	public int deleteAllComments(int noticeNo) {
		int deleteCommentCnt = commentMapper.deleteAllComments(noticeNo);
		// 디버깅 코드
		System.out.println("commentService 삭제된 댓글 개수 : " + deleteCommentCnt);
		return deleteCommentCnt;
	}
	
	public int deleteComment(int commentNo) {
		int result = commentMapper.deleteComment(commentNo);
		// 디버깅 코드
		System.out.println("commentService 댓글 삭제(성공:1, 실패:0) : " + result);
		return result;
	}
}
