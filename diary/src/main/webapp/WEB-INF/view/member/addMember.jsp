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
		<h1>회원가입</h1>
		<form id="addForm" method="post" action="${pageContext.request.contextPath}/addMember">
			<div class="d-flex mt-3 mb-3">
				<div style="width:170px;">
				    <label for="memberId" class="form-label">아이디</label>
				    <input type="text" class="form-control" id="memberId" name="memberId" maxlength="15">
				</div>
				<div class="align-self-end">
					<div class="btn btn-dark" style="margin-left:30px; width:90px;" id="idCheck">중복 체크</div>
				</div>
			</div>
			
			<div class="mb-3">
			    <label for="memberPw" class="form-label">비밀번호</label>
			    <input type="password" class="form-control" id="memberPw" name="memberPw" maxlength="15">
			</div>
			<div class="mb-3">
			    <label for="memberPwCheck" class="form-label">비밀번호 확인</label>
			    <input type="password" class="form-control" id="memberPwCheck" name="memberPwCheck" maxlength="15">
			</div>		
			<button type="button" id="addBtn" style="margin-top:20px;" class="btn btn-dark">회원가입</button>
		</form>
	</div>
</body>

<script type="text/javascript">
	
	$('#memberId').focus();
	
	// 정규식을 이용한 ID 입력 체크(영문 소문자, 숫자만 입력 가능)
	$('#memberId').keyup(function(){
		$(this).val($(this).val().replace(/[^a-z0-9]/g, ''));
	});
	
	let isIdCheck = false; 
	// 중복체크를 하고 난 뒤 아이디 입력란에 사용 가능한 아이디를 지우고 새로운 아이디를 입력했을 경우에 대처
	$('#memberId').keydown(function(){
		isIdCheck = false;
	});
	
	// 중복체크 버튼
	$('#idCheck').click(function(){
		
		let memberId = $('#memberId').val();
		if(memberId != '') {
			$.ajax({
				url : '${pageContext.request.contextPath}/idCheck',
				method : 'get',
				data : {memberId : memberId},
				success : function(json) {
						if(json == 1) {
							alert('이미 사용중인 아이디입니다.');
							$('#memberId').focus();
						} else if(memberId.length < 5) {
							alert('아이디를 5자 이상 입력하세요.');
							$('#memberId').focus();
						} else {
							isIdCheck = true;
							alert('사용 가능한 아이디입니다.');
							$('#memberPw').focus();
						}
					},
				error : function(err) {
					console.log(err);
				}
			}); 
		 } else {
			alert('아이디를 입력하세요.');
			$('#memberId').focus();
		}
	});

	// 회원가입 버튼
	$('#addBtn').click(function(){
		
		if(isIdCheck == false) {
			alert('ID 중복체크를 하세요.')
			$('#memberId').focus();
			return;
		}
		
		let checkNumber = $('#memberPw').val().search(/[0-9]/g);
	    let checkEnglish = $('#memberPw').val().search(/[a-z]/ig);
	    
	    if($('#memberPw').val() == '') { 
			// 비밀번호 창에 아무것도 입력하지 않았을 때
			alert('비밀번호를 입력하세요.');
			return;
		} else if($('#memberPw').val() != $('#memberPwCheck').val()) { 
			// 비밀번호 일치 확인
			alert('비밀번호가 일치하지 않습니다.');
			return;
		} else if($('#memberPw').val().length < 6 || $('#memberPwCheck').val().length < 6) { 
			// 비밀번호 창의 입력값의 length가 6 미만일 때
			alert('비밀번호를 6자 이상 입력하세요.');
			return;
		} else if(checkNumber <0 || checkEnglish <0){
			// 숫자와 영어를 혼용하지 않았을 때
	        alert("비밀번호는 숫자와 영문자를 혼용하여야 합니다.");
	        return;
	    } 
		
	    alert('가입이 완료되었습니다.');
		$('#addForm').submit();
	});
</script>

</html>