<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<!-- jsp 파일 -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
	
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
	
	<div style="margin-top:50px; margin-bottom:50px; width:50%; padding:65px;" class="mx-auto border rounded" id="font">
		<h3>공지 수정</h3>
		<form method="post" action="${pageContext.request.contextPath}/notice/updateNoticeOne">
			<input type="hidden" value="${notice.noticeNo}" name="noticeNo">
			
			<div class="mb-3 mt-3">
				<label for="noticeTitle" class="form-label">제목</label>
			    <input type="text" class="form-control" id="noticeTitle" name="noticeTitle" value="${notice.noticeTitle}">
			</div>
			<div class="mb-3">
				<label for="noticeContent" class="form-label">내용</label>
				<textarea name="noticeContent" id="noticeContent" class="form-control" rows="15" maxlength="1000" style="resize:none; margin-bottom:10px;">${notice.noticeContent}</textarea>			
			</div>
			<div class="mb-3 mt-3">
				<label for="password" class="form-label">비밀번호 입력</label>
			    <input type="password" class="form-control" id="password" name="password">
			</div>		
			<button>수정하기</button>		
		</form>
	</div>
</body>

<script>
	$('#password').focus();
</script>
</html>