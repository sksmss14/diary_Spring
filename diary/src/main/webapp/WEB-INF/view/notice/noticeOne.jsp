<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<!-- 부트스트랩 CDN -->
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	
	<!-- 폰트 -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Song+Myung&display=swap" rel="stylesheet">

	<style>
		#font {
			font-family: 'Song Myung', serif;
		}
		
		td {
			border-right:1px solid black;
			border-left:1px solid black;
		}
	</style>
</head>
<body>
	<!---------------------- 상단바 start --------------------->
	<c:if test="${memberId == null}">
		<c:import url="/WEB-INF/view/include/logoutNavBar.jsp"></c:import>
	</c:if>
	<c:if test="${memberId != null}">
		<c:import url="/WEB-INF/view/include/navBar.jsp"></c:import>
	</c:if>
	<!---------------------- 상단바 end --------------------->

	
	<div class="container" style="margin-top:50px;" id="font">
	<!---------------------- 공지 상세창 start --------------------->
		<h3>공지 상세</h3>
		<table class="table table-bordered" style="border:1px solid black">
			<colgroup>
				<col width="10%">
				<col width="90%">
			</colgroup>
			<tr>
				<td>제목</td>
				<td>
					${noticeOne.noticeTitle}
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					${noticeOne.noticeContent}
				</td>
			</tr>
		</table>
		
			<div class="d-flex" style="margin-bottom:13px;">
				<a href="${pageContext.request.contextPath}/updateNotice?noticeNo=${noticeOne.noticeNo}" style="margin-right:10px;">공지 수정</a>
				<a href="${pageContext.request.contextPath}/deleteNotice?noticeNo=${noticeOne.noticeNo}">공지 삭제</a>
				<!--collapse start-->
				<a href="#demo" data-bs-toggle="collapse" class="btn btn-dark" style="margin-left:auto">
					댓글 : ${commentCount}개
				</a>
			</div>		
			<!---------------------- 공지 상세창 end --------------------->
		
			<div class="row">
				<!---------------------- 댓글 작성창 start --------------------->
				<div class="col-md-6">	
					<c:if test="${memberId != null}">
						<form method="post" action="${pageContext.request.contextPath}/addComment">
							<input type="hidden" value="${noticeOne.noticeNo}" name="noticeNo">
							<div class="mb-3 mt-3">
								<label for="comment" class="form-label">댓글</label>
								<textarea name="comment" id="comment" placeholder="댓글 입력하기" class="form-control" rows="3" style="resize:none; margin-bottom:10px;" maxlength="100"></textarea>		
							</div>
							<div class="form-check">
							    <input class="form-check-input" type="checkbox" value="true" id="flexCheckDefault" name="isSecret">
							    <label class="form-check-label" for="flexCheckDefault">비밀글</label>
							</div>
							<div>
								<button class="btn btn-dark" style="margin-top:20px; margin-bottom:20px;">작성하기</button>
							</div>
						</form>
					</c:if>
				</div>	
				<!---------------------- 댓글 작성창 end --------------------->
				
				<!---------------------- 댓글창 start --------------------->
				<div id="demo" class="collapse col-md-6">
					<table class="table table-bordered" style="margin-bottom:40px;">
						<colgroup>
							<col width="80%">
							<col width="10%">
							<col width="10%">
						</colgroup>
							
						<c:forEach var="list" items="${commentList}">
							<tr style="border-top : 1px solid black; border-bottom : 1px solid black;">
								<td>${list.memberId}</td>
								<td>
									<a href="${pageContext.request.contextPath}/updateComment?commentNo=${list.commentNo}&memberId=${list.memberId}&noticeNo=${noticeOne.noticeNo}">수정</a>
								</td>
								<td>
									<a href="${pageContext.request.contextPath}/deleteComment?commentNo=${list.commentNo}&memberId=${list.memberId}&noticeNo=${noticeOne.noticeNo}">삭제</a>
								</td>
							</tr>
							<tr>
								<c:if test="${list.isSecret.equals('false') ||  list.memberId == memberId}">		
									<td colspan="3">${list.comment}</td>
								</c:if>
								<c:if test="${list.isSecret.equals('true') && list.memberId != memberId}">
									<td colspan="3" style="color:red;">비밀글입니다. (본인만 확인 가능)</td>
								</c:if>
							</tr>
							<tr style="border-bottom : 1px solid black">
								<td colspan="3">
									${list.createdate}
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>	
				<!---------------------- 댓글창 end --------------------->
			</div>
		</div>		
		
</body>
</html>