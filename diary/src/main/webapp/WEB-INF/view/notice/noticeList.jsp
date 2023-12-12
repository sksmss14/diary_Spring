<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>공지 목록</title>
	
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
		.aStyle {
  			text-decoration: none;
		}
	
		.container {
			font-family: 'IBM Plex Sans KR', sans-serif;
		}
		
		#tb {
			border: 1px solid black;
		}
	</style>
</head>
<body>
	<!---------------------- 상단바 start --------------------->
	<c:if test="${memberId == null}">
		<c:import url="/WEB-INF/view/include/logoutNavBar.jsp"></c:import>
	</c:if>
	<c:if test="${memberId != null}">
		<c:import url="/WEB-INF/view/include/navBar.jsp"></c:import>
	</c:if>
	<!---------------------- 상단바 end --------------------->
	
	<!---------------------- 공지 start --------------------->
	<div class="container" style="margin-top:50px;">
		<c:set var="noticeNo" value="1"></c:set> <!-- 공지 번호 생성 -->
		<h3>공지</h3>
		<table class="table table-bordered" id="tb">
			<colgroup>
				<col width="10%">
				<col width="20%">
				<col width="70%">
			</colgroup>
			<tr>
				<td>번호</td>
				<td>아이디</td>
				<td>제목</td>
			</tr>
			<c:forEach var="n" items="${noticeList}">
				<tr>
					<td>${noticeNo}</td>
					<td>${n.memberId}</td>
					<td>
						<a href="${pageContext.request.contextPath}/noticeOne?noticeNo=${n.noticeNo}" class="aStyle">
							${n.noticeTitle}
						</a>				
					</td>
				</tr>
				<c:set var="noticeNo" value="${noticeNo + 1}"></c:set> <!-- 공지 번호 증가 처리 -->
			</c:forEach>
		</table>
		<c:if test="${memberLevel == 1}">
			<div class="d-flex">
				<a href="${pageContext.request.contextPath}/addNotice" class="btn btn-dark" style="margin-left:auto;">공지 추가</a>
			</div>			
		</c:if>
	</div>
	<!---------------------- 공지 end --------------------->
</body>
</html>