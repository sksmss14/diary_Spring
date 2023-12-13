<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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