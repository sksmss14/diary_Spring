<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일별 일정 목록</title>
	
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
	
	<!---------------------- 일정 목록 창 start --------------------->
	<div class="container" id="font">
		<div class="row">
			<div class="col-md-8" style="margin-top:50px;">
				<h3 style="margin-bottom:15px;">${scheduleYear}년 ${scheduleMonth}월 ${scheduleDay}일 일정 목록</h3>
				<div id="newList">		
					<c:set var="scheduleNo" value="1"></c:set> <!-- 일정 번호 생성 -->		
					<c:forEach var="s" items="${list}">
						<c:if test="${s.scheduleEmoji == 1}">
							<div style="font-size:20px;">No.${scheduleNo} : &#128512;</div>
						</c:if>
						<c:if test="${s.scheduleEmoji == 2}">
							<div style="font-size:20px;">No.${scheduleNo} : &#128545;</div>
						</c:if>
						<c:if test="${s.scheduleEmoji == 3}">
							<div style="font-size:20px;">No.${scheduleNo} : &#128532;</div>
						</c:if>
						<c:if test="${s.scheduleEmoji == 4}">
							<div style="font-size:20px;">No.${scheduleNo} : &#128518;</div>
						</c:if>
						
						<div>
							<textarea class="form-control" style="resize:none; margin-top:5px;" disabled readonly rows="5" maxlength="300">${s.scheduleMemo}</textarea>
						</div>
						<div class="mb-3 mt-3 d-flex">
							<div style="margin-left:auto;">
								<a href="${pageContext.request.contextPath}/updateSchedule?scheduleNo=${s.scheduleNo}&scheduleMemo=${s.scheduleMemo}&scheduleEmoji=${s.scheduleEmoji}&scheduleYear=${scheduleYear}&scheduleMonth=${scheduleMonth}&scheduleDay=${scheduleDay}" class="btn btn-dark">수정</a>
								<a class="btn btn-danger deleteBtn" data-value="${s.scheduleNo}">삭제</a>
							</div>
						</div>
						<c:set var="scheduleNo" value="${scheduleNo + 1}"></c:set> <!-- 일정 번호 증가 처리 -->
					</c:forEach>
				</div>				
			</div>
			<div class="col-md-4"></div>
		</div>
	<!---------------------- 일정 목록 창 end --------------------->
	
	<!---------------------- 일정 추가 창 start --------------------->
	<div class="row">
		<div class="col-md-8">
		<h3 style="margin-top:20px; margin-bottom:15px;">일정 추가</h3>
		<form method="post" id="scheduleForm">
			<input type="hidden" name="scheduleYear" value="${scheduleYear}">
			<input type="hidden" name="scheduleMonth" value="${scheduleMonth}">
			<input type="hidden" name="scheduleDay" value="${scheduleDay}">
			<div class="row">
				<div class="col-md-2">
					<select class="form-select" name="scheduleEmoji" id="scheduleEmoji" style="width:120px;">
					  <option value="0" selected>감정 선택</option>
					  <option value="1">&#128512;</option> <!-- happy -->
					  <option value="2">&#128545;</option> <!-- angry -->
					  <option value="3">&#128532;</option> <!-- sad -->
					  <option value="4">&#128518;</option> <!-- enjoy -->
					</select>
				</div>
				<div class="col-md-10"></div>
			</div>
			<textarea rows="5" maxlength="300" name="scheduleMemo" id="scheduleMemo" placeholder="입력하기" class="form-control" style="resize:none; margin-top:10px;"></textarea>
			<div class="d-flex">
				<button type="button" class="btn btn-dark mt-3" style="margin-bottom:20px; margin-left:auto;" id="addBtn">일정 추가</button>
			</div>
		</form>
		</div>
		<div class="col-md-4"></div>
	</div>
		<!---------------------- 일정 추가 창 end --------------------->
	</div>
</body>
<script>
			
	$('#scheduleEmoji').focus();
	
	// 일정 추가
	$('#addBtn').click(function(){
		
		if($('#scheduleEmoji').val() == 0) {
			alert('감정을 선택하세요.');
			$('#scheduleEmoji').focus();
			return;
		} else if($('#scheduleMemo').val().trim() == '') {
			alert('일정을 입력하세요.');
			$('#scheduleMemo').focus();
			return;
		}
		        
        let dataset = $('#scheduleForm').serialize();
		
		$.ajax({
			url : '${pageContext.request.contextPath}/addSchedule',
			method : 'post',
			data : dataset,
			success : function(result) {
				console.log('일정 추가 성공');
				$('#scheduleMemo').val('');
				$('#scheduleEmoji').val(0);
				$('#newList').html(result);
				// 스크롤 바를 맨 밑으로 이동시키고 애니메이션의 속도를 0.05초로 설정
				$('html, body').animate({ scrollTop: $(document).height() }, 50);
			},
			error : function() {
				// 로그아웃된 상태에서 버튼 클릭시 error 발생
            	alert('로그아웃 상태입니다. 로그인 페이지로 이동합니다.');
         		location.href = '${pageContext.request.contextPath}/login';
			}
		});
	});
	
	// 동적으로 추가된 요소에 대해서도 이벤트를 처리하기 위해 부모 요소(#newList)에 이벤트를 위임
	// click : 적용할 이벤트
	// .deleteBtn : 이벤트를 적용할 태그
	// function() : 동작 함수
	$('#newList').on('click', '.deleteBtn', function(e) {
		
		console.log('동적으로 추가된 요소');
			
		$.ajax({
			url : '${pageContext.request.contextPath}/deleteSchedule',
			method : 'get',
			data : {
				scheduleNo : e.target.dataset.value, // a 태그의 data-value 
				scheduleYear : '${scheduleYear}',
				scheduleMonth : '${scheduleMonth}',
				scheduleDay : '${scheduleDay}'
			},
			success : function(result) {
				console.log('일정 삭제 성공');
				$('#newList').html(result);
			},
			error : function() {
				// 로그아웃된 상태에서 버튼 클릭시 error 발생
            	alert('로그아웃 상태입니다. 로그인 페이지로 이동합니다.');
         		location.href = '${pageContext.request.contextPath}/login';
			}
		});
		
	});

</script>
</html>