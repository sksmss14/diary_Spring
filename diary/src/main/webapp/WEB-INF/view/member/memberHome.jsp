<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		<!-- 달력 -->
		<div>
			<div style="margin-bottom : 10px;">
				<a href="${pageContext.request.contextPath}/member/memberHome?targetY=${targetY}&targetM=${targetM-1}" class="btn btn-dark">이전 달</a>
				<a href="${pageContext.request.contextPath}/member/memberHome?targetY=${targetY}&targetM=${targetM+1}" class="btn btn-dark">다음 달</a>
			</div>
			
			<div style="font-size:20px">현재 접속자 수 : ${applicationScope.currentCnt}</div>
			<h3 style="margin:20px 0 20px 0;">${targetY}년 ${targetM+1}월</h3>
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
						<c:forEach var="i" begin="1" end="${totalTd}" step="1">
							<c:set var="d" value="${i - beginBlank}"></c:set>
							<c:if test="${i%7 == 1}">
							
								<td style="color:red;">
								
							</c:if>
							<c:if test="${i%7 != 1}">
							
								<td>
								
							</c:if>					
									<c:if test="${d < 1 || d > lastD }">
										&nbsp;
									</c:if>
									<c:if test="${!(d < 1 || d > lastD)}">
										<a href="${pageContext.request.contextPath}/schedule/scheduleByDay?scheduleYear=${targetY}&scheduleMonth=${targetM+1}&scheduleDay=${d}">
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
									
									<c:if test="${i<totalTd && i%7 == 0}">
										<tr></tr>
									</c:if>			
								</td>
						</c:forEach>
					</tr>
				</tbody>			
			</table>
		</div>
	</div>		
</body>
</html>