<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>공지 수정</title>
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
	
	<div style="margin-top:50px; margin-bottom:50px; width:50%; padding:65px;" class="mx-auto border rounded" id="font">
		<h3>공지 수정</h3>
		<form method="post" action="${pageContext.request.contextPath}/updateNotice" id="updateForm">
			<input type="hidden" value="${noticeOne.noticeNo}" name="noticeNo">
			<div class="mb-3 mt-3">
				<label for="noticeTitle" class="form-label">제목</label>
			    <input type="text" class="form-control" id="noticeTitle" name="noticeTitle" value="${noticeOne.noticeTitle}" placeholder="입력하기">
			</div>
			<div class="mb-3">
				<label for="noticeContent" class="form-label">내용</label>
				<textarea name="noticeContent" id="noticeContent" class="form-control" rows="15" maxlength="1000" style="resize:none; margin-bottom:10px;" placeholder="입력하기">${noticeOne.noticeContent}</textarea>			
			</div>
			<div class="mb-3 mt-3">
				<label for="password" class="form-label">비밀번호 입력</label>
			    <input type="password" class="form-control" id="memberPw" name="memberPw" maxlength="15" placeholder="입력하기">
			</div>
			<div class="d-flex">
				<button type="button" class="btn btn-dark" id="updateBtn" style="margin-top:15px; margin-left:auto;">수정하기</button>
			</div>				
		</form>
	</div>
</body>

<script>
	$('#memberPw').focus();
	
	$('#updateBtn').click(function(){
		
		if($('#noticeTitle').val().length == 0) {
			alert('제목을 입력하세요.');
			$('#noticeTitle').focus();
			return;
		}
		
		if($('#noticeContent').val().length == 0) {
			alert('내용을 입력하세요.');
			$('#noticeContent').focus();
			return;
		}
		
		if($('#memberPw').val().length == 0) {
			alert('비밀번호를 입력하세요.');
			$('#memberPw').focus();
			return;
		}
		
		// form 안의 parameter들을 한 번에 전송 가능한 data로 만듦.
		let dataset = $('#updateForm').serialize();
		
		$.ajax({
			url : '${pageContext.request.contextPath}/updateNotice',
			method : 'post',
            data : dataset,
            success : function(result){
		            	if(result == 'notLogin'){ // 로그아웃 상태
		            		alert('권한이 없습니다.');
		            		location.href = '${pageContext.request.contextPath}/login';
		            	} else if(result == 'notAdmin') { // 일반 회원일 때
		            		alert('권한이 없습니다.');
		            		location.href = '${pageContext.request.contextPath}/home';
		            	} else if(result == 'failCheckPassword'){ // 비밀번호 불일치
		            		alert('비밀번호가 일치하지 않습니다.');
		            		location.href = '${pageContext.request.contextPath}/updateNotice?noticeNo=${noticeOne.noticeNo}';
		            	} else if(result == 'fail') { // 공지 삭제 실패
		            		alert('공지 수정 실패하였습니다.');
		            		location.href = '${pageContext.request.contextPath}/updateNotice?noticeNo=${noticeOne.noticeNo}';
		            	} else { // 성공
		            		alert('공지 수정 성공!');
		            		location.href = '${pageContext.request.contextPath}/notice';
		            	}
		            	
            }
		});
		
	});
</script>
</html>