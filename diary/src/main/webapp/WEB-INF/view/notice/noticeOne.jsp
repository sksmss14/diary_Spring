<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>공지 상세</title>
	
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
		
		td {
			border-right:1px solid black;
			border-left:1px solid black;
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

	
	<div class="container" style="margin-top:50px;" id="font">
	<!---------------------- 공지 상세창 start --------------------->
		<h3>공지 상세</h3>
		<table class="table table-bordered" style="border:1px solid black">
			<colgroup>
				<col width="10%">
				<col width="90%">
			</colgroup>
			<tr>
				<td>제목</td>
				<td>
					${noticeOne.noticeTitle}
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					${noticeOne.noticeContent}
				</td>
			</tr>
		</table>
		
			<div class="d-flex" style="margin-bottom:13px;" id="btnTextCheck">
				<c:if test="${memberLevel == 1}">
					<a href="${pageContext.request.contextPath}/updateNotice?noticeNo=${noticeOne.noticeNo}" style="margin-right:10px;" id="updateNoticeBtn" class="btn btn-dark">공지 수정</a>
					<a href="${pageContext.request.contextPath}/deleteNotice?noticeNo=${noticeOne.noticeNo}" id="deleteNoticeBtn" class="btn btn-danger">공지 삭제</a>
				</c:if>
				<!--collapse start-->
				<a href="#newList" data-bs-toggle="collapse" class="btn btn-dark" style="margin-left:auto">

					댓글 : <span id="commentCnt">${commentCount}</span>개
				</a>
			</div>		
			<!---------------------- 공지 상세창 end --------------------->
		
			<div class="row">
				<!---------------------- 댓글 작성창 start --------------------->
				<div class="col-md-6">	
					<c:if test="${memberId != null}">
						<form method="post" id="addForm">
							<input type="hidden" value="${noticeOne.noticeNo}" name="noticeNo">
							<div class="mb-3 mt-3">
								<label for="comment" class="form-label">댓글</label>
								<textarea name="comment" id="comment" placeholder="입력하기" class="form-control" rows="3" style="resize:none; margin-bottom:10px;" maxlength="100"></textarea>		
							</div>
							<div class="form-check d-flex">
							    <input class="form-check-input" type="checkbox" value="true" id="flexCheckDefault" name="isSecret">
							    <label class="form-check-label" for="flexCheckDefault" style="margin-left:6px;">비밀글</label>
							    <button type="button" class="btn btn-dark" style="margin-top:20px; margin-bottom:20px; margin-left:auto;" id="addCommentBtn">작성하기</button>
							</div>
						</form>
					</c:if>
				</div>	
				<!---------------------- 댓글 작성창 end --------------------->
				
				<!---------------------- 댓글창 start --------------------->
				<div id="newList" class="collapse col-md-6">
					<table class="table table-bordered" style="margin-bottom:40px;">
						<colgroup>
							<col width="79%">
							<col width="21%">
						</colgroup>
						
						<c:forEach var="list" items="${commentList}">
							<tr style="border-top : 1px solid black; border-bottom : 1px solid black;" height="50px;">
								
								<c:if test="${(list.memberId != memberId) && memberLevel == 0}"> <!-- 비회원, 일반 회원&본인 댓글x : 댓글 삭제, 수정 버튼 모두 숨김 -->
									<td colspan="2" style="padding:0 0 0 8px;" class="align-middle">${list.memberId}</td>
								</c:if>
													
								<c:if test="${(list.memberId == memberId) || memberLevel == 1}"> <!-- 일반 회원&본인 댓글o, 관리자 : 댓글 수정, 삭제 버튼 표시 -->
									<td style="border-right:none; padding:0 0 0 8px;" class="align-middle">
										${list.memberId}
									</td>								
									<td style="border-left:none; padding:0 0 0 15px;" class="align-middle">
										<a href="${pageContext.request.contextPath}/updateComment?commentNo=${list.commentNo}" class="commentBtn btn btn-dark" data-value="${list.memberId}">수정</a>
										<a href="${pageContext.request.contextPath}/deleteComment?commentNo=${list.commentNo}&memberId=${list.memberId}&noticeNo=${list.noticeNo}" class="commentBtn btn btn-danger" data-value="${list.memberId}">삭제</a>
									</td>
								</c:if>
								
							</tr>
							<tr>
								<!-- 비밀글 체크x or 현재 접속자와 댓글 작성자가 동일 or 관리자 -->
								<c:if test="${list.isSecret == 'false' ||  list.memberId == memberId || memberLevel == 1}">		
									<td colspan="2">${list.comment}</td>
								</c:if>
								<!-- 비밀글 체크 and 현재 접속자와 댓글 작성자가 다름 and 관리자x -->
								<c:if test="${list.isSecret == 'true' && list.memberId != memberId && memberLevel != 1}">
									<td colspan="2" style="color:red;">비밀글입니다. (본인, 관리자만 확인 가능합니다.)</td>
								</c:if>
							</tr>
							<tr style="border-bottom : 1px solid black">
								<td colspan="2">
									${list.createdate}
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>	
				<!---------------------- 댓글창 end --------------------->
			</div>
		</div>				
</body>
<script>
	
	// 댓글 추가
	$('#addCommentBtn').click(function(){
		
		if($('#comment').val().trim() == '') {
			alert('댓글을 입력하세요.');
			$('#comment').focus();
			return;
		}
		
		// form 안의 parameter들을 한 번에 전송 가능한 data로 만듦.
		let dataset = $('#addForm').serialize();
		
		$.ajax({
			url : '${pageContext.request.contextPath}/addComment',
            method : 'post',
            data : dataset,
            success : function(result){
            	console.log('댓글 추가 성공');
            	$('#comment').val('');
            	// 댓글 버튼에 표시되는 댓글 개수 변경
            	$('#commentCnt').text(parseInt($('#commentCnt').text())+1);
				$('#newList').html(result);
				// 스크롤 바를 맨 밑으로 이동시키고 애니메이션의 속도를 0.05초로 설정
				$('html, body').animate({ scrollTop: $(document).height() }, 50);
   			},
   			error : function(){
   				// 로그아웃된 상태에서 버튼 클릭시 error 발생
            	alert('로그아웃 상태입니다. 로그인 페이지로 이동합니다.');
         		location.href = '${pageContext.request.contextPath}/login';
   			}
		});
		
	});
	
	// 해당 댓글을 작성한 회원을 제외하고 접근 제한
	$('.commentBtn').one('click',function(e){
		
		e.preventDefault();
		
		$.ajax({
			url : '${pageContext.request.contextPath}/commentBtnCheck',
			data : {memberId : e.target.dataset.value}, // a 태그의 data-value 
			method : 'get',
            success : function(result){
            	if(result == 'notLogin') {
            		alert('권한이 없습니다.');
            		location.href = '${pageContext.request.contextPath}/login';
            	} else if(result == 'notMyComment') {
            		alert('권한이 없습니다.');
            		location.href = '${pageContext.request.contextPath}/noticeOne?noticeNo=${noticeOne.noticeNo}';
            	} else { // 성공 : 해당 댓글을 작성한 회원 or 관리자
            		location.href = e.target.getAttribute('href');
            	}
            }
		});
		
	})
	
</script>
</html>