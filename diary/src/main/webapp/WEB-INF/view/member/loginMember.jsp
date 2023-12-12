<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
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
	<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@500&display=swap" rel="stylesheet">
	<style>	
		#font {
			font-family: 'IBM Plex Sans KR', sans-serif;
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
			    <input type="text" class="form-control" id="memberId" name="memberId" maxlength="15" placeholder="입력하기">
			</div>
			<div class="mb-3">
			    <label for="memberPw" class="form-label">비밀번호</label>
			    <input type="password" class="form-control" id="memberPw" name="memberPw" maxlength="15" placeholder="입력하기">
			</div>
			<div class="d-flex">
				<div style="margin-left:auto;">
					<button type="button" id="loginBtn" class="btn btn-dark" style="margin-top:20px; margin-bottom:20px;">로그인</button>
					<a href="${pageContext.request.contextPath}/addMember" class="btn btn-dark">회원 가입</a>
				</div>			
			</div>			
		</form>	
	</div>
</body>

<script>
	$('#memberId').focus();
	
	$('#loginBtn').click(function(){
		
		if($('#memberId').val().trim() == '') {
			alert('아이디를 입력하세요.');
			$('#memberId').focus();
			return;
		}
		
		if($('#memberPw').val().length == 0) {
			alert('비밀번호를 입력하세요.');
			$('#memberPw').focus();
			return;
		}
		
		// form 안의 parameter들을 한 번에 전송 가능한 data로 만듦.
		let dataset = $('#loginForm').serialize();
		
		$.ajax({
			url : '${pageContext.request.contextPath}/login',
            method : 'post',
            data : dataset,
            success : function(result) {
		            	if(result == 'fail') { // 로그인 실패
		            		alert('로그인 실패하였습니다. 아이디 혹은 비밀번호를 확인하세요.');
		            		$('#memberId').focus();
		            	} else { // 로그인 성공
		            		alert('로그인 성공!');
		            		location.href = '${pageContext.request.contextPath}/home';
		            	} 
            }
		});
		
	});
</script>

</html>