<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		.container {
			font-family: 'Song Myung', serif;
		}
		
		#tb {
			border: 1px solid black;
		}
	</style>
</head>
<body>
	<!---------------------- 상단바 start --------------------->
	<c:import url="/WEB-INF/view/include/navBar.jsp"></c:import>
	<!---------------------- 상단바 end --------------------->

	<div class="container" style="margin-top:40px; margin-bottom:70px">
	   <h1>반갑습니다. ${loginMember.memberId}님</h1>
	   <div style="margin-bottom : 10px;">
			<button type="button" class="btn btn-dark" id="lastMonth" value="${calendarMap.targetMonth}">이전 달</button>
			<button type="button" class="btn btn-dark" id="nextMonth">다음 달</button>
		</div>
		
	   <div id="calendarContainer"></div>
	     
   </div>
</body>

<script>
	
	// 페이지 로드 시 초기 달력 표시
	updateCalendar();
	
	// 이전 달 버튼 클릭 시
	$('#lastMonth').click(function() {
	    updateCalendar(-1);
	});
	
	// 다음 달 버튼 클릭 시
	$('#nextMonth').click(function() {
	    updateCalendar(1);
	});
	
	// 달력 갱신 함수
    function updateCalendar(monthOffset) {
		
    	let year = ${calendarMap.targetYear};
        let month = $('#lastMonth').val();
        
        $.ajax({
            url : '${pageContext.request.contextPath}/updateCalendar',
            method : 'GET',
            data : {
                targetYear: year,
                targetMonth: month,
                monthOffset: monthOffset
            },
            success : function(response) {
                // 서버에서 받은 데이터로 달력 업데이트
                $('#calendarContainer').html(response);
                $('#lastMonth').val($('#lastMonth').val()-1);
            }
        });
    }
</script>
</html>