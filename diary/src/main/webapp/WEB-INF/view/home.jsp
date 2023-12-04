<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
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
			<a href="${pageContext.request.contextPath}/home?targetYear=${calendarMap.targetYear}&targetMonth=${calendarMap.targetMonth - 1}" class="btn btn-dark">이전 달</a>
			<a href="${pageContext.request.contextPath}/home?targetYear=${calendarMap.targetYear}&targetMonth=${calendarMap.targetMonth + 1}" class="btn btn-dark">다음 달</a>
		</div>
		
	   <h3 style="margin:20px 0 20px 0;">${calendarMap.targetYear}년 ${calendarMap.targetMonth + 1}월</h3>
	   <!---------------------- 캘린더 start --------------------->
	     
	   <table class="table table-bordered" id="tb">
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
									<div>${m.memo}</div>
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
</body>
</html>