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
	<c:import url="/WEB-INF/view/include/logoutNavBar.jsp"></c:import>
	<!---------------------- 상단바 end --------------------->

	<div style="margin-top:130px; width:30%; padding:65px;" class="mx-auto border rounded" id="font">
		<h1>로그인</h1>
		<form id="loginForm" method="post" action="${pageContext.request.contextPath}/login">
			<div class="mb-3 mt-3">
			    <label for="memberId" class="form-label">아이디</label>
			    <input type="text" class="form-control" id="memberId" name="memberId">
			</div>
			<div class="mb-3">
			    <label for="memberPw" class="form-label">비밀번호</label>
			    <input type="password" class="form-control" id="memberPw" name="memberPw">
			</div>
			<button id="loginBtn" class="btn btn-dark" style="margin-top:20px; margin-bottom:20px;">로그인</button>
		</form>
		<a href="${pageContext.request.contextPath}/addMember">회원 가입</a>
	</div>
</body>

<script>
	$('#memberId').focus();
</script>

</html>