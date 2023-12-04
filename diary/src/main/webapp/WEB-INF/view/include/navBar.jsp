<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-sm bg-light navbar-light">

	<div class="container-fluid">
	   <!-- Links -->
	   <ul class="navbar-nav"> 
	     <li class="nav-item">
	       <a class="nav-link navbar-brand" href="${pageContext.request.contextPath}/home">홈</a>
	     </li>
	     <li class="nav-item">
	       <a class="nav-link" href="${pageContext.request.contextPath}/notice">공지</a>
	     </li>
	     <li class="nav-item">
	       <a class="nav-link" href="${pageContext.request.contextPath}/updateMemberPw">비밀번호 수정</a>
	     </li>
	     <li class="nav-item">
	       <a class="nav-link" href="${pageContext.request.contextPath}/deleteMember">회원탈퇴</a>
	     </li> 
	     <li class="nav-item">
	       <a class="nav-link" href="${pageContext.request.contextPath}/logout">로그아웃</a>
	     </li>
	   </ul>
	   
	 </div>
	 
</nav>