<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /semi_prj_shoes
%>

<jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/header_startingPage.jsp" />

<title>1:1 문의</title>

<style type="text/css">
#title{
    height : 16 ;
    font-family :'inherit';
    font-size : 12;
    text-align :center;
}

div.button
{
   margin: auto;
   width: 50%;
}

	.badge { /* 댓글 수정, 삭제버튼 pointer */
		cursor: pointer;
	}
	
	h2{
		display:inline-block;
		vertical-align: middle;
	}
	
	#board > thead > tr th{ font-size: 13pt; font-weight: bold;}

</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		$("button#btnCmtGoEdit").click(function() {

		//	alert("수정버튼 test");
			
			var frm = document.commentEditFrm;
			frm.action = "<%= ctxPath%>/qnaCommentEditEnd.shoes";
			frm.method = "post";
			frm.submit();
			
		});
					
	});// end of $(document).ready(function()---------------------------

</script>


<%-- 댓글 보기 시작--%>
<%-- 		<section>
			<hr>
			<h4 class="pt-3">댓글</h4>
			<hr>
			<table class="table-white py-3" style="width: 100%;">
	
				<c:if test="${empty requestScope.commentList}">
					<tr>
						<td class="pl-3 py-3" colspan="6" style="font-weight: bold">댓글 없음</td>
					</tr>
				</c:if>
	
				<c:if test="${not empty requestScope.commentList}">
					<c:forEach var="cvo" items="${requestScope.commentList}">
						<tr style="border-bottom:solid 1px white;">
							<td style="display: none;">${cvo.qna_commentno}</td>
							<td class="pl-3 py-3" style="width: 100px; border-right:solid 1px white;">${cvo.fk_qna_cmtWriter}</td>
							<td class="pl-3 py-3" style="text-align: left;">${cvo.qna_cmtContent}</td>
							<td class="pr-3 py-3" style="font-size: 10pt; text-align: right;">${cvo.qna_cmtRegDate}</td>
							수정하기, 삭제하기 버튼
							<td style="width: 20px;"><span class="badge badge-pill badge-primary ml-2" id="commentEdit">수정</span></td>
							<td style="width: 20px;"><span class="badge badge-pill badge-danger  mx-2" onclick="javascript:history.back()">취소</span></td>
							수정하기, 삭제하기 버튼
						<tr>
					</c:forEach>
				</c:if>
			</table>
		</section> --%>
<%-- 댓글 보기 끝 --%>

<%-- 댓글 수정 폼태그 시작--%>
<hr>
<div class="card my-4">	
	<div class="card-header">댓글남기기</div>
	<div class="card-body">
		<form name="commentEditFrm" style="width: 100%;" class="form-horizontal">
			<div class="row">
				<input type="hidden" name="qna_num" value="${requestScope.qna_num}">	<%-- 게시글 번호 --%>
				<input type="hidden" name="fk_qna_cmtWriter" value="${requestScope.cvo.fk_qna_cmtWriter}">	<%-- 게시글 번호 --%>
				<input type="hidden" name="qna_commentno" value="${requestScope.cvo.qna_commentno}">	<%-- 게시글 번호 --%>
				<div class="form-group col-sm-10">		
					<textarea class="form-control" id="qna_cmtContent" name="qna_cmtContent">${requestScope.cvo.qna_cmtContent}</textarea>
				</div>	
				<div class="form-group col-sm-2">		
					<input class="form-control" id="fk_qna_cmtWriter" name="fk_qna_cmtWriter" value="${(sessionScope.loginuser).name}" />
				</div>	
				<div class="form-group col-sm-2">
					<button type="button" class="btn btn-secondary" id="btnCmtGoEdit">수정</button>
					<button type="button" class="btn btn-secondary" onclick="javascript:history.back()">취소</button>
				</div>	
			</div>
		</form>
	</div>
</div>
<%-- 댓글 수정 폼태그 끝--%>

<%-- <p class="text-center" style="margin-top: 30px;">	
	<button type="button" class="btn btn-secondary" onClick="location.href='<%= ctxPath%>/qnaList.shoes'">목록</button>
	글 수정 및 삭제하기 (작성자 본인만 수정, 삭제 가능)
	<c:if test="${sessionScope.loginuser.userid eq requestScope.bvo.qna_writer}"> 			
		<button type="button" class="btn btn-secondary" onClick="qnaGoEdit()">수정</button>
		<button type="button" class="btn btn-secondary" onClick="qnaGoDelete()">삭제</button>
	</c:if> 
</p>
 --%>
<jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/footer_startingPage.jsp" />