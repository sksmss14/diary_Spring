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
	   <div style="margin-bottom : 10px; margin-top : 20px;">
	   
	        <!-- ajax 페이징 코드 -->
	   		<input type="hidden" value="${calendarMap.targetYear}" id="targetYear">
	   		<input type="hidden" value="${calendarMap.targetMonth}" id="targetMonth">
			<button type="button" class="btn btn-dark" id="lastMonth" onclick="return false;">이전 달</button>
			<button type="button" class="btn btn-dark" id="nextMonth">다음 달</button>
			
		</div>
	 
	 
	   <div id="calendarContainer">
		   <h3 style="margin:20px 0 20px 0;">${calendarMap.targetYear}년 ${calendarMap.targetMonth + 1}월</h3>
			<table class="table table-bordered" id="tb" style="height:600px">
				<colgroup>
						<col width="14%" />
					    <col width="14%" />
					    <col width="14%" />
					    <col width="14%" />
					    <col width="14%" />
					    <col width="14%" />
					    <col width="14%" />
				</colgroup>
				<thead>
					<tr>
						<td style="color:red; background-color:#DCDCDC;">일</td>
						<td style="background-color:#DCDCDC;">월</td>
						<td style="background-color:#DCDCDC;">화</td>
						<td style="background-color:#DCDCDC;">수</td>
						<td style="background-color:#DCDCDC;">목</td>
						<td style="background-color:#DCDCDC;">금</td>
						<td style="background-color:#DCDCDC;">토</td>
					</tr>
				</thead>
				<tbody>
					 <tr>
				         <c:forEach var="i" begin="1" end="${calendarMap.totalTd}">
				            <c:set var="d" value="${i - calendarMap.beginBlank}"></c:set>
				            <td>
				               <c:if test="${d < 1 || d > calendarMap.lastDate}">
				                  &nbsp;
				               </c:if>
				               <c:if test="${!(d < 1 || d > calendarMap.lastDate)}">
				                  <a href="${pageContext.request.contextPath}/scheduleByDay?scheduleYear=${calendarMap.targetYear}&scheduleMonth=${calendarMap.targetMonth + 1}&scheduleDay=${d}">
				                  	${d}
				                  </a>
				                         
				               	  <div>
									<c:forEach var="m" items="${list}">
										<c:if test="${m.scheduleDay == d}">
											<div>${m.cnt}개의 일정</div>
										</c:if>
									</c:forEach>	
								  </div>
				               </c:if>
				               
				               <!-- 한행에 7열씩.. -->
				               <c:if test="${i < calendarMap.totalTd && i%7 == 0}">
				                  </tr><tr>
				               </c:if>
				            </td>
				         </c:forEach>
			     	 </tr>
				</tbody>
			</table>
	   </div>
	     
   </div>
</body>

<script>
		
	// 이전 달 버튼 클릭 시
	$('#lastMonth').click(function() {
		updateCalendar(-1);
	});
	
	// 다음 달 버튼 클릭 시
	$('#nextMonth').click(function() {
	    updateCalendar(1);
	});
	
	// 달력 갱신 함수
    function updateCalendar(monthPlusMinus) {
		
    	if(monthPlusMinus == 1) {
       		$('#targetMonth').val( Number($('#targetMonth').val()) + 1);
       	} else if(monthPlusMinus == -1) {
       		$('#targetMonth').val( Number($('#targetMonth').val()) - 1);
       	}
		
    	let year = $('#targetYear').val();
        let month = $('#targetMonth').val();
        
        $.ajax({
            url : '${pageContext.request.contextPath}/changeCalendar',
            method : 'GET',
            data : {
                targetYear: year,
                targetMonth: month
            },
            success : function(response) {
            
                // 서버에서 받은 데이터로 달력 업데이트
                $('#calendarContainer').html(response);
                              
                if($('#targetMonth').val() == -1) {
                	$('#targetMonth').val(11);
                	$('#targetYear').val( Number($('#targetYear').val()) - 1);
                }
                if($('#targetMonth').val() == 12) {
                	$('#targetMonth').val(0);
                	$('#targetYear').val( Number($('#targetYear').val()) + 1);
                }
                // 디버깅
                console.log($('#targetYear').val() + '년 ' + $('#targetMonth').val() + '월');
             },
             error : function(error) { 
            	// 로그아웃된 상태에서 버튼 클릭시 changeCalendar 메서드에서 null을 반환하여 ajax 실행x -> error 발생
            	alert('로그아웃 상태입니다. 로그인 페이지로 이동합니다.');
         		location.href = '${pageContext.request.contextPath}/login';
             }
        });
    }
</script>
</html>