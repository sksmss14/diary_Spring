<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>	
	
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
	</style>
</head>
<body>
	<!---------------------- 상단바 start --------------------->
	<c:import url="/WEB-INF/view/include/navBar.jsp"></c:import>
	<!---------------------- 상단바 end --------------------->
	
	<div style="margin-top:130px; margin-bottom:50px; width:30%; padding:65px;" class="mx-auto border rounded" id="font">
		<h3>댓글 수정</h3>
		<form method="post" action="${pageContext.request.contextPath}/updateComment">
			<input type="hidden" name="noticeNo" value="${commentOne.noticeNo}">
			<input type="hidden" name="commentNo" value="${commentOne.commentNo}">
			<div class="mb-3 mt-3">
				<label for="comment" class="form-label">댓글 내용</label>
				<textarea id="comment" name="comment" placeholder="댓글 입력하기" class="form-control" rows="3" style="resize:none; margin-bottom:10px;" maxlength="100">${commentOne.comment}</textarea>
			</div>
			<div class="form-check">
			<c:if test="${commentOne.isSecret == 'true'}">
				<input class="form-check-input" type="checkbox" value="true" id="flexCheckDefault" name="isSecret" checked>
			</c:if>
			<c:if test="${commentOne.isSecret == 'false'}">
				<input class="form-check-input" type="checkbox" value="true" id="flexCheckDefault" name="isSecret">
			</c:if>    
			    <label class="form-check-label" for="flexCheckDefault">비밀글</label>
			</div>
			<div class="mb-3 mt-3">
				<label for="password" class="form-label">비밀번호 입력</label>
			    <input type="password" class="form-control" id="password" name="password">
			</div>		
			<button class="btn btn-dark">수정하기</button>		
		</form>
	</div>
</body>

<script>
	$('#password').focus();
</script>
</html>