package com.diary.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.diary.mapper.CommentMapper;
import com.diary.vo.Comment;
import com.diary.vo.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor // 클래스에 선언된 final 필드들을 매개변수로 하는 생성자를 자동으로 생성
@Transactional
@Service
public class CommentService {
	
	private final CommentMapper commentMapper;
		
	public int getCommentCount(int noticeNo) {
		
		int result = commentMapper.getCommentCount(noticeNo);
		
		log.debug("댓글 개수 : " + result);
		
		return result;
	}
	
	public List<Comment> selectCommentList(int noticeNo) {
		
		List<Comment> selectCommentList= commentMapper.selectCommentList(noticeNo);
		
		log.debug("댓글 목록 : " + selectCommentList);
		
		return selectCommentList;	
	}
	
	public Comment selectCommentOne(int commentNo) {
		
		Comment selectCommentOne = commentMapper.selectCommentOne(commentNo);
	
		log.debug("수정 전 댓글 : " + selectCommentOne);
		
		return selectCommentOne;
	}
	
	public int addComment(Comment comment) {
		int result = commentMapper.addComment(comment);
		
		log.debug("댓글 추가(성공:1, 실패:0) : " + result);
		
		return result;
	}
	
	public int checkPassword(Member paramMember) {
		
		int checkPassword = commentMapper.checkPassword(paramMember);
		
		log.debug("비밀번호 확인(성공:1,실패:0) : " + checkPassword);

		return checkPassword;
	}
	
	public int updateComment(Comment comment) {
		int result = commentMapper.updateComment(comment);

		log.debug("댓글 수정(성공:1, 실패:0) : " + result);
		
		return result;
	}
	
	public int deleteAllComments(int noticeNo) {
		int deleteCommentCnt = commentMapper.deleteAllComments(noticeNo);
	
		log.debug("삭제된 댓글 개수 : " + deleteCommentCnt);
		
		return deleteCommentCnt;
	}
	
	public int deleteComment(int commentNo) {
		int result = commentMapper.deleteComment(commentNo);

		log.debug("댓글 삭제(성공:1, 실패:0) : " + result);
		
		return result;
	}
}
