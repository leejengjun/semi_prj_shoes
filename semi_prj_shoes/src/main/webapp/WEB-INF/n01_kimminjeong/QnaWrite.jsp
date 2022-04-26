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
        font-family :inherit;
        font-size : 12;
        text-align :center;
    }

</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("button#btnQnaInsert").click(function(){ // 버튼을 클릭하면 글쓰기를 위해서 폼을 전송합니다.
			
			if(  $("input[name=qna_subject]").val().trim() == ""  ){
				alert("글제목은 필수 입력사항입니다.");
				return;
			}
			
			if(  $("textarea[name=qna_content]").val().trim() == ""  ){
				alert("글내용은 필수 입력사항입니다.");
				return;
			}
			
/* 			if ( $("select[name=pnum]").val() == 'pdtList' ){
				alert("문의하실 상품을 고르세요.");
				return;
			} */
			
			if( parseInt($("input[name=qna_subject]").val().length) > 100  ){
				alert("글제목은 100자까지 가능합니다.");
				return;
			}
			
			if( parseInt($("textarea[name=qna_content]").val().length) > 500 ) {
				alert("글내용은 300자까지 가능합니다.");
				return;
			}
			
			
			var frm = document.QnaWriteFrm;
			frm.action="<%= ctxPath%>/qnaWrite.shoes";
			frm.method="POST";
			frm.submit();
			
			
		});// end of $("button#btnQnaInsert").click(function(){})---------------------------------
		
		
	});// end of $(document).ready(function(){})------------------------------------
</script>


	<div class="container" style="margin-bottom: 250px;">	
		<div class="col-md-12 text-center">
	    <br>
	  	<h2 style=" color: gray;">&nbsp;&nbsp;1:1 문의</h2>
	    <br>특정 상품에 대한 문의는 상품 정보 상세 페이지를 이용해 주시기 바랍니다.<br>
		등록된 문의는 수정 및 삭제가 불가능합니다.<br>
		1:1 문의에 주소, 연락처 등 개인정보 및 계좌정보를 남기실 경우, 질문이 삭제될 수 있습니다.<br>
		계좌정보는 MY > 계정관리 > 환불계좌관리 에 등록해 주시기 바랍니다.
		<br>
		</div>

<%-- 글쓰기 본문 시작 --%>
	<article>
		<div class="container" role="main">
		    <form method="post" action="/qnaWrite.shoes" name="QnaWriteFrm" enctype="multipart/form-data">
		    <%-- <input type="hidden" name="qna_id" value="${sessionScope.sessionID}"> --%>
		    <div class="row">
			    <div class="col-md-6">
			    	<div class="form-group">
			            <label for="qna_writer">작성자</label><!--  추가 --> 
			            <input type="text" class="form-control" style="width: 50%" name="qna_writer" value="${sessionScope.loginuser.userid}" readonly /> 		        
			    	</div>
		    	</div>   
		   	</div>
	    	<div class="form-group">
		    	<label for="title">문의유형</label>
					<select id="category" style="width: 50%;" class="form-control" name="category" title="카테고리분류" onchange="chageSelect()">
						<option value= "">전체</option>														 	
						<option value="1">AS 및 취급방법 문의</option>					 	
						<option value="2">상품 관련 문의</option>							 	
						<option value="3">배송관련 문의</option>							 	
						<option value="4">기타문의</option>								
					 </select>
			</div>
<%-- 	        <tr> 	// 제품 정보 불러온 후에 다시 추가할 것
	            <td id="title">제품명</td>	                        				<td>
					<select name="pnum">
								<option value="pdtList">문의할 상품을 선택하세요</option>								
							<c:forEach var="pvo" items="상품리스트">
								<option value="${pvo.pnum}">${pvo.pname}</option>
							</c:forEach>
					</select>
	        </tr>   --%>             
	        <div class="form-group">
                <label for="content">제목</label>
                <input name="qna_subject" class="form-control" type="text" size="70" maxlength="190" required autofocus />
	        </div>
	        
	         <div class="form-group">
                <label for="content">내용</label>
                <textarea name="qna_content" class="form-control" maxlength="300" cols="78" rows="20"></textarea>            
			</div>
	         <div class="custom-file">
	           <label for="file" class="form-label"></label><br>      
	           <input type="file" name="qna_file" accept=".jpg, .png"/>
			 </div>		               
		    </form>
		</div>
	</article>	
<%-- 글쓰기 본문 끝 --%>         

		<p class="text-center" style="margin-top: 30px;">
			<button id="btnQnaInsert" type="button" class="btn btn-dark btn-md">글쓰기</button>
			<button type="button" class="btn btn-dark btn-md" onclick="javascript:history.back()">취소하기</button>
            <button type="button" class="btn btn-dark btn-md" onClick="location.href='<%=ctxPath%>/qnaList.shoes'">목록</button>          
		</p>
	          
	    
</div>
<jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/footer_startingPage.jsp" />