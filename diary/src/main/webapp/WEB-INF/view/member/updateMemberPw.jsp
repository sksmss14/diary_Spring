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

	<div style="margin-top:150px; width:30%; padding:65px;" class="mx-auto border rounded" id="font">
		<h1>비밀번호 수정</h1>
		<form method="post" action="${pageContext.request.contextPath}/updateMemberPw">
			<div class="mb-3 mt-3">
				<label for="oldPw" class="form-label">원래 비밀번호</label>
			    <input type="password" class="form-control" id="oldPw" name="oldPw" maxlength="15">
			</div>
			<div class="mb-3">
				<label for="newPw" class="form-label">변경할 비밀번호</label>
			    <input type="password" class="form-control" id="newPw" name="newPw" maxlength="15">
			</div>
			<button class="btn btn-dark">변경하기</button>
		</form>
	</div>
</body>

<script>
	$('#oldPw').focus();
</script>
</html>