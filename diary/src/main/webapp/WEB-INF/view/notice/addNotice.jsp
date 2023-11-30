<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<h1>공지 추가하기</h1>
	<form method="post" action="${pageContext.request.contextPath}/addNotice">
		<div>
			<h3>제목</h3>
			<input type="text" name="noticeTitle"> 
		</div>
		<div>
			<h3>내용</h3>
			<textarea name="noticeContent"></textarea>
		</div>
		<button>추가하기</button>
	</form>
</body>
</html>