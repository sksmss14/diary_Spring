<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">

	<div class="container-fluid">
	   <!-- Links -->
	   <ul class="navbar-nav"> 
	     <li class="nav-item">
	       <a class="nav-link navbar-brand" href="${pageContext.request.contextPath}/member/memberHome">홈</a>
	     </li>
	     <li class="nav-item">
	       <a class="nav-link" href="${pageContext.request.contextPath}/notice">공지</a>
	     </li>
	     <li class="nav-item">
	       <a class="nav-link" href="${pageContext.request.contextPath}/member/modifyMember">비밀번호 수정</a>
	     </li>
	     <li class="nav-item">
	       <a class="nav-link" href="${pageContext.request.contextPath}/member/removeMember">회원탈퇴</a>
	     </li> 
	     <li class="nav-item">
	       <a class="nav-link" href="${pageContext.request.contextPath}/member/logoutMember">로그아웃</a>
	     </li>
	   </ul>
	   
	 </div>
	 
</nav>