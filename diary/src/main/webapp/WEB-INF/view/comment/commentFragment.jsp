<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<table class="table table-bordered" style="margin-bottom:40px;">
	<colgroup>
		<col width="79%">
		<col width="21%">
	</colgroup>

	<c:forEach var="list" items="${commentList}">
		<tr style="border-top : 1px solid black; border-bottom : 1px solid black;" height="50px;">
			
			<c:if test="${(list.memberId != memberId) && memberLevel == 0}"> <!-- 비회원, 일반 회원&본인 댓글x : 댓글 삭제, 수정 버튼 모두 숨김 -->
				<td colspan="2" style="padding:0 0 0 8px;" class="align-middle">${list.memberId}</td>
			</c:if>
								
			<c:if test="${(list.memberId == memberId) || memberLevel == 1}"> <!-- 일반 회원&본인 댓글o, 관리자 : 댓글 수정, 삭제 버튼 표시 -->
				<td style="border-right:none; padding:0 0 0 8px;" class="align-middle">
					${list.memberId}
				</td>								
				<td style="border-left:none; padding:0 0 0 15px;" class="align-middle">
					<a href="${pageContext.request.contextPath}/updateComment?commentNo=${list.commentNo}" class="commentBtn btn btn-dark" data-value="${list.memberId}">수정</a>
					<a href="${pageContext.request.contextPath}/deleteComment?commentNo=${list.commentNo}&memberId=${list.memberId}&noticeNo=${list.noticeNo}" class="commentBtn btn btn-danger" data-value="${list.memberId}">삭제</a>
				</td>
			</c:if>
			
		</tr>
		<tr>
			<c:if test="${list.isSecret.equals('false') ||  list.memberId == memberId || memberLevel == 1}">		
				<td colspan="2">${list.comment}</td>
			</c:if>
			<c:if test="${list.isSecret.equals('true') && list.memberId != memberId && memberLevel != 1}">
				<td colspan="2" style="color:red;">비밀글입니다. (본인, 관리자만 확인 가능합니다.)</td>
			</c:if>
		</tr>
		<tr style="border-bottom : 1px solid black">
			<td colspan="2">
				${list.createdate}
			</td>
		</tr>
	</c:forEach>
</table>