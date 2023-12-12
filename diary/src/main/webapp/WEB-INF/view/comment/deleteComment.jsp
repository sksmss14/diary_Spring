<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>댓글 삭제</title>
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
		<h3>댓글 삭제</h3>
		<form method="post" id="deleteForm">		
			<input type="hidden" value="${commentNo}" name="commentNo">
			<input type="hidden" value="${memberId}" name="memberId">			
			<div class="mb-3 mt-3">
				<label for="memberPw" class="form-label">비밀번호 입력</label>
			    <input type="password" class="form-control" id="memberPw" placeholder="입력하기" name="memberPw" maxlength="15">
			</div>
			<div class="d-flex">
				<button type="button" class="btn btn-danger" id="deleteBtn" style="margin-top:15px; margin-left:auto;">삭제하기</button>
			</div>	
		</form>
	</div>
</body>

<script>
 	$('#memberPw').focus();
 	
	$('#deleteBtn').click(function(){
				
		if($('#memberPw').val().length == 0) {
			alert('비밀번호를 입력하세요.');
			$('#memberPw').focus();
			return;
		}
		
		// form 안의 parameter들을 한 번에 전송 가능한 data로 만듦.
		let dataset = $('#deleteForm').serialize();
		
		// 수정중
		$.ajax({
			url : '${pageContext.request.contextPath}/deleteComment',
			method : 'post',
            data : dataset,
            success : function(result){
		            	if(result == 'notLogin'){ // 로그아웃 상태
		            		alert('권한이 없습니다.');
		            		location.href = '${pageContext.request.contextPath}/login';
		            	} else if(result == 'notMyComment') { // 해당 댓글을 작성하지 않은 일반 회원(관리자x)일 때
		            		alert('권한이 없습니다.');
		            		location.href = '${pageContext.request.contextPath}/noticeOne?noticeNo=${noticeNo}';
		            	} else if(result == 'failCheckPassword'){ // 비밀번호 불일치
		            		alert('비밀번호가 일치하지 않습니다.'); 
		            		$('#memberPw').focus();
		            	} else if(result == 'fail') { // 공지 삭제 실패
		            		alert('댓글 삭제 실패하였습니다.');		            		
		            	} else { // 성공
		            		alert('댓글 삭제 성공!');
		            		location.href = '${pageContext.request.contextPath}/noticeOne?noticeNo=${noticeNo}';
		            	}
		            	
            }
		});
	});
 	
 	
</script>
</html>