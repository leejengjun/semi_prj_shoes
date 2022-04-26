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
		
		// 댓글 수정하기		
		var qna_commentno = 0;
		var loginuser = "${sessionScope.loginuser.userid}";
		
		$(document).on("click", "span#commentEdit", function() {
			 
			qna_commentno = $(this).parent().parent().find("td:first-child").text();			// 댓글번호
			var fk_qna_cmtWriter = $(this).parent().parent().find("td:nth-child(2)").text();	// 댓글 작성자
			var qna_cmtContent = $(this).parent().parent().find("td:nth-child(3)").text();		// 댓글 내용
			var qna_num = $(this).parent().parent().find("td:nth-child(5)").text();
					

			$("input.editSubmit[name=qna_commentno]").val(qna_commentno);		// 댓글수정 hidden 폼 댓글 번호
			$("input.editSubmit[name=fk_qna_cmtWriter]").val(fk_qna_cmtWriter);	// 댓글수정 hidden 폼 댓글 작성자
			$("input.editSubmit[name=qna_cmtContent]").val(qna_cmtContent);		// 댓글수정 hidden 폼 댓글 내용
			$("input.editSubmit[name=qna_num]").val(qna_num);					// 댓글수정 hidden 폼 글번호
			
			var frm = document.commentEditFrm;
			frm.action = "<%= ctxPath%>/qnaCommentEdit.shoes";
			frm.method = "post";
			frm.submit();
			
		});

		
		// 댓글 삭제하기			
		qna_commentno = 0;
		loginuser ="${sessionScope.loginuser.userid}";
		
		$(document).on("click","span#commentDelete", function() {
			
			qna_commentno = $(this).parent().parent().find("td:first-child").text();	// 댓글번호
			
			var pop_width = 600;
			var pop_height = 300;
			
			var pop_left = Math.ceil((window.screen.width - pop_width)/2);
			var pop_top = Math.ceil((window.screen.height - pop_height)/2);
			
			var url = "<%= ctxPath%>/qnaCommentDelete.shoes?qna_commentno="+qna_commentno;
			
			window.open(url, "checkDelete", "left="+pop_left+", top="+pop_top+", width="+pop_width+", height="+pop_height);
			
		});
		
		
	});// end of $(document).ready(function()---------------------------
	

	// function declaration		
	
	// 문의사항 글수정
	function qnaGoEdit() {
		
		var frm = document.qnaEditFrm
		frm.action = "<%= ctxPath%>/qnaEdit.shoes";
		frm.method = "POST";
		frm.submit();
		
	}// end of function goEdit() --------------------------
	
	// 문의사항 글 삭제 
	function qnaGoDelete() {
		
		var qna_num = "${requestScope.bvo.qna_num}";	 
		var qna_writer = "${requestScope.bvo.qna_writer}";
		
		var pop_width = 600;
		var pop_height = 300;
		
		var pop_left = Math.ceil((window.screen.width - pop_width)/2);
		var pop_top = Math.ceil((window.screen.height - pop_height)/2);
		
		var url = "<%= ctxPath%>/qnaDelete.shoes?qna_num="+qna_num+"&qna_writer="+qna_writer;
		
		window.open(url, "deleteCheck", "left="+pop_left+", top="+pop_top+", width="+pop_width+", height="+pop_height);

	}// end of qnaGoDelete(){}--------------------------------------
	
	
	// 댓글 쓰기
	function insertComment() {
		
		var frm = document.commentFrm;
		frm.action="<%= ctxPath%>/qnaComment.shoes";
		frm.method="post";
		frm.submit();
		
	}// end of function insertComment(){}--------------------



</script>

	<div class="container" style="margin-top:50px; width: 100%">	
		<div align="center">
		    <br>
		  	<font size="5" color="gray">&nbsp;&nbsp;1:1 문의</font>
		    <br>특정 상품에 대한 문의는 상품 정보 상세 페이지를 이용해 주시기 바랍니다.<br>
			등록된 문의는 수정 및 삭제가 불가능합니다.<br>
			1:1 문의에 주소, 연락처 등 개인정보 및 계좌정보를 남기실 경우, 질문이 삭제될 수 있습니다.<br>
			계좌정보는 MY > 계정관리 > 환불계좌관리 에 등록해 주시기 바랍니다.<br>
		</div>
	</div>
	
<%-- 글 내용 보기 시작--%>
	<div class="container my-1">
		<div class="row">
			<table class="table" style="margin-top: 50px;">
				<thead>
					<tr class="table-active">
						<th scope="col" style="background-color: white; width: 60%;"> 글제목 : ${requestScope.bvo.qna_subject}<br>
																					  작성자 : ${requestScope.bvo.qna_writer}</th>
						<th scope="col" style= "width: 40%; background-color: white;" class="text-right">등록일자 : ${requestScope.bvo.qna_regDate}<br>					
																										 조회수 : ${requestScope.bvo.qna_viewCnt}</th>					
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="height: 300px; text-align: left;">${requestScope.bvo.qna_content}</td>
					</tr>
				</tbody>
			</table>				
		</div>			
	</div>
					<section>																			
						<p class="pt-3">첨부파일</p>
						<hr>
						<table class="table-white py-3" style="width: 100%;">					
						<c:if test="${not empty requestScope.bvo.qna_file}">
						<tr><%-- <c:if> 문을 통해 첨부파일 유무에 따른 문구 출력 --%>
							<td> <img src="/semi_prj_shoes/images/kimminjeong/${requestScope.bvo.qna_file}" class="img-fluid" style="width: 40%;" /> </td>
						</tr>
						</c:if>						
						<c:if test="${empty requestScope.bvo.qna_file}">
						<tr>
							<td class="pl-3 py-3" colspan="6" style="font-weight: bold">첨부파일 없음</td>	<%-- 첨부파일 없을때 --%>
						</tr>
						</c:if>
						</table>
					</section>

<%-- 글 내용 보기 끝 --%>

<%-- 댓글 보기 시작--%>
<hr>
		<section>
			<p class="pt-3">댓글</p>
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
							<c:if test="${cvo.fk_qna_cmtWriter eq 'admin'}">
							<td class="pl-3 py-3" style="width: 100px; border-right:solid 1px white;">관리자</td>
							</c:if>
							<c:if test="${cvo.fk_qna_cmtWriter ne 'admin'}">
							<td class="pl-3 py-3" style="width: 100px; border-right:solid 1px white;">${cvo.fk_qna_cmtWriter}</td>
							</c:if>													
							<td class="pl-3 py-3" style="text-align: left;">${cvo.qna_cmtContent}</td>
							<td class="pr-3 py-3" style="font-size: 10pt; text-align: right;">${cvo.qna_cmtRegDate}</td>
							<td style="display: none;">${requestScope.bvo.qna_num}</td>
							<%-- 수정하기, 삭제하기 버튼 --%>
							<td style="width: 20px;"><span class="badge badge-pill badge-secondary ml-2" id="commentEdit">수정</span></td>
							<td style="width: 20px;"><span class="badge badge-pill badge-secondary  mx-2" id="commentDelete">삭제</span></td>
							<%-- 수정하기, 삭제하기 버튼 --%>
						<tr>
					</c:forEach>
				</c:if>
			</table>
		</section>
<%-- 댓글 보기 끝 --%>

<%-- 댓글 작성부분 시작--%>
<hr>
<div class="card my-4">	
	<div class="card-header">댓글남기기</div>
	<div class="card-body">
		<form name="commentFrm" style="width: 100%;" class="form-horizontal">
				<input type="hidden" name="fk_qna_num" value="${requestScope.bvo.qna_num}">	<%-- 게시글 번호 --%>
				<div class="col-sm-2">		
					<span><%-- 작성자 : ${(sessionScope.loginuser).name} --%></span>  
				</div>
				<br>
				<input type="hidden" name="fk_qna_cmtWriter" style="text-align: right;" value="${(sessionScope.loginuser).userid}" />	
				<div class="form-group col-sm-12">		
					<textarea class="form-control" id="qna_cmtContent" name="qna_cmtContent" placeholder="댓글을 입력하세요."></textarea>
				</div>	
				<div class="form-group col-sm-12">
					<button type="button" class="btn btn-secondary replyAddBtn" onclick="insertComment()">댓글작성</button>
				</div>	
		</form>
	</div>
</div>
	
<%-- 댓글 작성부분 끝 --%>

<p class="text-center" style="margin-top: 30px;">	
	<button type="button" class="btn btn-secondary" onClick="location.href='<%= ctxPath%>/qnaList.shoes'">목록</button>
	<%-- 글 수정 및 삭제하기 (작성자 본인만 수정, 삭제 가능) --%>
	<c:if test="${sessionScope.loginuser.userid eq requestScope.bvo.qna_writer}"> 			
		<button type="button" class="btn btn-secondary" onClick="qnaGoEdit()">수정</button>
		<button type="button" class="btn btn-secondary" onClick="qnaGoDelete()">삭제</button>
	</c:if> 
</p>

<%-- 글내용 보기에서 '수정'버튼 클릭 시 보여주는 기존 글 입력정보 --%>
<form name="qnaEditFrm" enctype="multipart/form-data">
	<input type="hidden" name="qna_num" value="${requestScope.bvo.qna_num}" />
	<input type="hidden" name="qna_writer" value="${requestScope.bvo.qna_writer}" />
	<input type="hidden" name="qna_subject" value="${requestScope.bvo.qna_subject}" />
	<input type="hidden" name="qna_content" value="${requestScope.bvo.qna_content}" />
	<input type="hidden" name="qna_file" value="${requestScope.bvo.qna_file}" />
</form>

<%-- 댓글보기에서 '수정'버튼 클릭 시 보여주는 기존 댓글 입력정보 --%>
<form name="commentEditFrm">
	<input class="editSubmit" type="hidden" name="qna_num" value="${requestScope.bvo.qna_num}"/>
	<input class="editSubmit" type="hidden" name="qna_commentno" />
	<input class="editSubmit" type="hidden" name="fk_qna_cmtWriter" />
	<input class="editSubmit" type="hidden" name="qna_cmtContent" />
</form>

<jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/footer_startingPage.jsp" />