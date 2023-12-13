<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="scheduleNo" value="1"></c:set>
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
			<a href="${pageContext.request.contextPath}/deleteSchedule?scheduleNo=${s.scheduleNo}&scheduleYear=${scheduleYear}&scheduleMonth=${scheduleMonth}&scheduleDay=${scheduleDay}" class="btn btn-danger">삭제</a>
		</div>
	</div>
	<c:set var="scheduleNo" value="${scheduleNo + 1}"></c:set> <!-- 일정 번호 증가 처리 -->
</c:forEach>