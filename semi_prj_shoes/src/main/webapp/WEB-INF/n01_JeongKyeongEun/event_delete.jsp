<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
    String ctxPath = request.getContextPath();
    //    /semi_prj_shoes
%>
<!DOCTYPE html>
<html>
<head>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.css" > 
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.js"></script>


<style type="text/css">
#title{
    height : 16 ;
    font-family :'돋움';
    font-size : 12;
    text-align :center;
}
div.button
{
   margin: auto;
   width: 50%;
}
html {
	margin-top: 27px;
}

body > div > h3 {
	padding-bottom: 5px;
	font-weight: bold;
}

body > div > h5 {
	padding-bottom: 30px;
	color: red;
}

</style>

<script type="text/javascript">
	// 글 삭제를 위한 확인 메세지를 띄운다.
	$(document).ready(function() {
		// 글삭제 '네'버튼 클릭시 함수 실행
		$("button#deleteYes").click(function() {
			var frm = document.eventDeleteFrm;
			frm.action = "<%= ctxPath%>/eventDelete.shoes";
			frm.method = "post";
			frm.submit();		
		});
		
		// 글삭제 '아니오'버튼 클릭시 함수 실행 
		$("button#deleteNo").click(function() {
			self.close();
			opener.location.href="<%= ctxPath%>/event_contents.shoes?event_no="+event_no+"&goBackURL=${requestScope.goBackURL}";
		
		});// end of$(document).ready(function() {}--------------------
	});
</script>
		
	<div class="container my-5 text-center">
	<h3> 이벤트 게시판 글을 삭제하시겠습니까?</h3>	
	<h5> 삭제후에는 다시 복구할 수 없습니다.</h5>	
	<%-- 글 삭제하기 (작성자 본인만 삭제 가능) --%>
			<button type="button" class="btn btn-secondary" id="deleteYes">네</button>
			<button type="button" class="btn btn-secondary" id="deleteNo">아니오</button>
	</div>

<%-- 글내용 보기에서 '삭제'버튼 클릭 시 해당 글번호 --%>
	<form name="eventDeleteFrm">
		<input type="hidden" name="event_no" value="${requestScope.event_no}">
		<input type="hidden" name="e_userid" value="${requestScope.e_userid}">
	</form>
