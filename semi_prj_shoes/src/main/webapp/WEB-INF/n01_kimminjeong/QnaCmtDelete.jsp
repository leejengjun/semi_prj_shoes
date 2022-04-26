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

<title>1:1 문의</title>

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

</style>

<script type="text/javascript">
	// 댓글 삭제를 위한 확인 메세지를 띄운다.
	$(document).ready(function() {
		// 댓글삭제 '네' 버튼 클릭시 함수 실행
		$("button#deleteCmtYes").click(function() {
			var frm = document.cmtDeleteFrm;
			frm.action = "<%= ctxPath%>/qnaCommentDelete.shoes";
			frm.method = "post";
			frm.submit();			
			window.opener.location.reload();
		});
		
		// 댓글삭제 '아니오' 버튼 클릭시 함수 실행 
		$("button#deleteCmtNo").click(function() {
			self.close();			
			opener.reload(true);
		
		});// end of $(document).ready(function() {}--------------------
	});

</script>
		
		<div class="container my-5" style="margin-top: 30px; text-align: center;">
		<h4>댓글을 삭제하시겠습니까?</h4>	
		<%-- 댓글 삭제하기 (작성자 본인만 삭제 가능) --%>
				<button type="button" class="btn btn-secondary" id="deleteCmtYes">네</button>
				<button type="button" class="btn btn-secondary" id="deleteCmtNo">아니오</button>
		</div>

<%-- 글내용 보기에서 '삭제'버튼 클릭 시 해당 글번호 --%>
	<form name="cmtDeleteFrm">
		<input type="hidden" name="qna_commentno" value="${requestScope.qna_commentno}">
		<input type="hidden" name="qna_commentno" value="${requestScope.qna_commentno}">
	</form>

