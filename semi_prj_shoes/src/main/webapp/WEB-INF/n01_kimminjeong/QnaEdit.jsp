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
        font-family :'돋움';
        font-size : 12;
        text-align :center;
    }
</style>

<script type="text/javascript">

	// 수정버튼 클릭시 작동
	$(document).ready(function() {
		
		$("button#btnEditInsert").click(function() {
			
			if($("input[name=qna_subject]").val().trim() == "" ) {
				alert("글제목은 필수 입력사항입니다.")
				return;
			}
			
			if($("textarea[name=qna_content]").val().trim() == "") {
				alert("글내용은 필수 입력사항입니다.")
				return;
			}
			
/*			if($("select[name=pnum]").val().trim() == "pdtList") {
				alert("문의하실 상품을 고르세요.");
				return;
			}*/
			
			if( parseInt($("input[name=qna_subject]").val().length) > 100 ) {
				alert("글제목은 100자까지 가능합니다.");
				return;			
			}
		// 오류 해결 필요 : qnaEdit.shoes:278 Uncaught TypeError: Cannot read properties of undefined (reading 'length')		
/* 		 	if( parseInt($("input[name=qna_content]").val().length) > 300 ) {
				alert("글내용은 300자까지 가능합니다.");
				return;
			}  */
	
			var frm = document.qnaEditFrm;
			frm.action="<%= ctxPath%>/qnaEditEnd.shoes";
			frm.method="POST";
			frm.submit();
		
		});// end of $("button#btnEditInsert").click(function(){})--------------------
		
	})// end of $(document).ready(function() {})---------------------------

</script>

	<div class="container" style="margin-top:50px; width: 100%">	
		<div align="center">
		    <br>
		    <b><font size="5" color="gray">&nbsp;&nbsp;1:1 문의</font></b>
		    <br>특정 상품에 대한 문의는 상품 정보 상세 페이지를 이용해 주시기 바랍니다.<br>
			등록된 문의는 수정 및 삭제가 불가능합니다.<br>
			1:1 문의에 주소, 연락처 등 개인정보 및 계좌정보를 남기실 경우, 질문이 삭제될 수 있습니다.<br>
			계좌정보는 MY > 계정관리 > 환불계좌관리 에 등록해 주시기 바랍니다.
		</div>
	</div>
	
<%-- 글쓰기 폼태그 수정 --%>		
	<article>
		<div class="container" role="main">	
		    <form method="post" name="qnaEditFrm" enctype="multipart/form-data">
		    <input type="hidden" name="qna_num" value="${requestScope.bvo.qna_num}"> 
		    <div class="row">
			    <div class="col-md-6">
			    	<div class="form-group">
		            <label for="qna_writer">작성자</label><!-- value : "${sessionScope.loginuser.userid}" 추가 --> 
		            <input type="text" class="form-control" name="qna_writer" value="${sessionScope.loginuser.userid}" readonly /></td> 
					</div>
				</div>
			</div>			
				<div class="form-group">
		        	<label for="title">문의유형</label>
						<select id="category"  style="width: 50%;" class="form-control" name="category" title="카테고리분류" ><%-- onchange="changeSelect()" --%>
							<option value= "">전체</option>															 	
							<option value="1" >AS 및 취급방법 문의</option>								 	
							<option value="2" >상품 관련 문의</option>								 	
							<option value="3" >배송관련 문의</option>							 	
							<option value="4" >기타문의</option>									
						</select>
				</div>
<%--	        <tr>
	            <td id="title">제품명</td>	                        				<td>
					<select name="pnum">
								<option value="pdtList">문의할 상품을 선택하세요</option>								
							<c:forEach var="pvo" items="상품리스트">
								<option value="${pvo.pnum}">${pvo.pname}</option>
							</c:forEach>
					</select>
	        	</tr>    --%>            
	            <div class="form-group">
	              	<label for="content">제목</label>
	                <input name="qna_subject" class="form-control" type="text" size="70" maxlength="100" required autofocus value="${requestScope.bvo.qna_subject}" />
	            </div> 
	                   
	            <div class="form-group">
	            <label for="content">내용</label>
	                <textarea name="qna_content" class="form-control" maxlength="300" cols="78" rows="20">${requestScope.bvo.qna_content}</textarea>            
				</div>
	                   
	            <div class="form-group">
	            <label for="file">기존 첨부파일 : </label><br>	<%-- 기존에 있었던 첨부파일을 보여준다. --%>
					<c:choose>
						<c:when test="${not empty requestScope.bvo.qna_file}">
							<img src="<%= ctxPath%>/images/kimminjeong/${requestScope.bvo.qna_file}" style="width: 300px; height: 300px;"/>
						</c:when>	
						<c:otherwise>
							<span>첨부파일 없음</span>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="form-group">
	             <label for="file" class="form-label"></label>
                 <input type="file" name="qna_file" accept=".jpg, .png"/>
                </div>
		    </form>
		</div>    
	</article>	    
<%-- 글수정 폼태그 끝 --%>
   	 
		<p class="text-center" style="margin-top: 30px;">
            <button type="button" class="btn btn-secondary" onClick="location.href='<%= ctxPath%>/qnaList.shoes'" >목록</button>            
            <button id="btnEditInsert" type="button" class="btn btn-secondary">수정</button>
			<button type="button" class="btn btn-secondary" onclick="javascript:history.back()">취소</button>
	    </p>

</div>
<jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/footer_startingPage.jsp" />