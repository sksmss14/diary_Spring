<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일정 수정</title>
	
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
	
	<div style="margin-top:130px; width:50%; padding:65px;" class="mx-auto border rounded" id="font">
		<h3>일정 수정</h3>
		<form method="post" id="updateForm" action="${pageContext.request.contextPath}/updateSchedule">
			<input type="hidden" value="${scheduleNo}" name="scheduleNo">
			
			<input type="hidden" value="${scheduleYear}" name="scheduleYear">
			<input type="hidden" value="${scheduleMonth}" name="scheduleMonth">
			<input type="hidden" value="${scheduleDay}" name="scheduleDay">
			
			<div class="mb-3 mt-3">
				<label for="scheduleMemo" class="form-label">내용</label>
				<textarea name="scheduleMemo" id="scheduleMemo" class="form-control" rows="5" style="resize:none; margin-bottom:10px;" maxlength="300" placeholder="입력하기">${scheduleMemo}</textarea>			
			</div>
			<div class="d-flex">
	
				<select class="form-select" name="scheduleEmoji" id="scheduleEmoji" style="width:120px;">
				<c:if test="${scheduleEmoji == 1}">
				  <option value="0">감정 선택</option>
				  <option value="1" selected>&#128512;</option> <!-- happy -->
				  <option value="2">&#128545;</option> <!-- angry -->
				  <option value="3">&#128532;</option> <!-- sad -->
				  <option value="4">&#128518;</option> <!-- enjoy -->
				</c:if>
				<c:if test="${scheduleEmoji == 2}">
				  <option value="0">감정 선택</option>
				  <option value="1">&#128512;</option> <!-- happy -->
				  <option value="2" selected>&#128545;</option> <!-- angry -->
				  <option value="3">&#128532;</option> <!-- sad -->
				  <option value="4">&#128518;</option> <!-- enjoy -->
				</c:if>
				<c:if test="${scheduleEmoji == 3}">
				  <option value="0">감정 선택</option>
				  <option value="1">&#128512;</option> <!-- happy -->
				  <option value="2">&#128545;</option> <!-- angry -->
				  <option value="3" selected>&#128532;</option> <!-- sad -->
				  <option value="4">&#128518;</option> <!-- enjoy -->
				</c:if>
				<c:if test="${scheduleEmoji == 4}">
				  <option value="0">감정 선택</option>
				  <option value="1">&#128512;</option> <!-- happy -->
				  <option value="2">&#128545;</option> <!-- angry -->
				  <option value="3">&#128532;</option> <!-- sad -->
				  <option value="4" selected>&#128518;</option> <!-- enjoy -->
				</c:if>
				</select>
				
				<button type="button" id="updateBtn" class="btn btn-dark" style="margin-left:auto;">일정 수정</button>	
			</div>			
		</form>
	</div>
</body>

<script>
	$('#scheduleMemo').focus();
	
	$('#updateBtn').click(function(){
		if($('#scheduleEmoji').val() == 0) {
			alert('감정을 선택하세요.');
			return;
		} else if($('#scheduleMemo').val() == 0) {
			alert('일정을 입력하세요.');
			$('#scheduleMemo').focus();
			return;
		}
		$('#updateForm').submit();
	});
</script>
</html>