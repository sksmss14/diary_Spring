<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호 변경</title>
	
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
	<c:import url="/WEB-INF/view/include/navBar.jsp"></c:import>
	<!---------------------- 상단바 end --------------------->

	<div style="margin-top:150px; width:30%; padding:65px;" class="mx-auto border rounded" id="font">
		<h1>비밀번호 수정</h1>
		<form method="post" id="updateForm">
			<div class="mb-3 mt-3">
				<label for="oldPw" class="form-label">변경 전 비밀번호</label>
			    <input type="password" class="form-control" id="oldPw" name="oldPw" maxlength="15" placeholder="입력하기">
			</div>
			<div class="mb-3">
				<label for="newPw" class="form-label">변경할 비밀번호</label>
			    <input type="password" class="form-control" id="newPw" name="newPw" maxlength="15" placeholder="입력하기">
			</div>
			<div>
				<label for="memberPwCheck" class="form-label">변경할 비밀번호 확인</label>
			    <input type="password" class="form-control" id="memberPwCheck" maxlength="15" placeholder="입력하기">
			</div>
			<div class="d-flex">
				<button type="button" id="updateBtn" class="btn btn-dark" style="margin-top:15px; margin-left:auto;">변경하기</button>
			</div>
		</form>
	</div>
</body>

<script>
	$('#oldPw').focus();
	
	$('#updateBtn').click(function(){
		
		if($('#oldPw').val().length == 0) {
			alert('변경 전 비밀번호를 입력하세요.');
			$('#oldPw').focus();
			return;
		}
		
		if($('#newPw').val().length == 0) {
			alert('변경할 비밀번호를 입력하세요.');
			$('#newPw').focus();
			return;
		} else if($('#newPw').val() != $('#memberPwCheck').val()) { 
			// 비밀번호 일치 확인
			alert('변경할 비밀번호가 일치하지 않습니다.');
			$('#newPw').focus();
			return;
		}
		
		// form 안의 parameter들을 한 번에 전송 가능한 data로 만듦.
		let dataset = $('#updateForm').serialize();
		
		$.ajax({
			url : '${pageContext.request.contextPath}/updateMemberPw',
			method : 'post',
            data : dataset,
            success : function(result){
		            	if(result == 'notLogin'){ // 로그아웃 상태 
		            		location.href = '${pageContext.request.contextPath}/login';
		            	} else if(result == 'fail') { // 회원 탈퇴 실패
		            		alert('비밀번호 변경 실패하였습니다. 변경 전 비밀번호를 확인하세요.');
		            		$('#oldPw').focus();
		            	} else { // 회원 탈퇴 성공
		            		alert('비밀번호 변경 성공!');
		            		location.href = '${pageContext.request.contextPath}/login';
		            	}
            }
		});
	});
	
</script>
</html>