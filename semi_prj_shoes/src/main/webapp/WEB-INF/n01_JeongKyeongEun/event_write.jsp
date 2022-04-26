<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<%
	String ctxPath = request.getContextPath();
	//    /semi_prj_shoes
%>     
    
<!-- 직접 만든 CSS -->
<link rel="stylesheet" href="<%= ctxPath%>/css/JeongKyeongEun/notice_event_write.css" />

<style type="text/css">




#body > div.content-container.clearfix > div > div.col-md-12.text-left > h2 {
	margin-top: -10px;
	padding-left: 150px;
}


#body > div.content-container.clearfix > aside {
	width: 12%;
	margin-left: -30px;
}


table.table2{
         border-collapse: separate;
         border-spacing: 1px;
         text-align: left;
         line-height: 1.5;
         border-top: 1px solid #ccc;
         margin : 20px 10px;
 }
 table.table2 tr {
          width: 50px;
          padding: 10px;
         font-weight: bold;
         vertical-align: top;
         border-bottom: 1px solid #ccc;
 }
 table.table2 td {
          width: 100px;
          padding: 10px;
          vertical-align: top;
          border-bottom: 1px solid #ccc;
 }
 
 #body > div.content-container.clearfix > div > div.container > form > table {
 	margin-left: 150px;
 }
 
form > table > tbody > tr:nth-child(2) > td > table > tbody > tr > td {
	text-align: center;
}

#container > div.container > div.container > form > table > tbody > tr:nth-child(2) > td > table > tbody > tr:nth-child(4) > td:nth-child(2) {
	text-align: left;
}

</style>

<jsp:include page="../n01_leejeongjun/starting_page/header_startingPage.jsp"/>

<script type="text/javascript">

  $(document).ready(function(){
	  
	  $("button#btnSubmit").click(function(){
	  
	    if( $("input[name=e_title]").val().trim() == "" ) {
			alert("글 제목을 입력하세요.");
			return;
		}
		
		if( $("textarea[name=e_contents]").val().trim() == "" ) {
			alert("글 내용을 입력하세요.");
			return;
		}
		
		if( parseInt($("input[name=e_title]").val().length) > 100 ) {
			alert("글 제목은 100자까지 가능합니다.");
			return;
		}
		
		if( parseInt($("textarea[name=e_contents]").val().length) > 4000 ) {
			alert("글 내용은 4000자까지 가능합니다.");
			return;
		}
			
		const frm = document.event_Frm;
		frm.action = "<%= ctxPath%>/event_write.shoes";
		frm.method = "post";
		frm.submit();
		  
	  });
	  
  });
</script>

</head>
<body>


	<!------- 글쓰기 폼태그 위에 이벤트게시판 큰 글씨 시작 ------->
	<div class="col-md-12 text-left">
	    <br>
	  	<h2 style="color: black; font-weight: bolder;">&nbsp;&nbsp;이벤트 게시판</h2>
		<br>
	</div>
	<!------- 글쓰기 폼태그 위에 이벤트게시판 큰 글씨 끝 ------->


	<!-- 글쓰기 폼태그 시작 -->


	<%-- !!!!! ==== 중요 ==== !!!!! --%>
	<%-- 폼에서 파일을 업로드 하려면 반드시 method 는 POST 이어야 하고 
     	 enctype="multipart/form-data" 으로 지정해주어야 한다.!! --%>

	<div class="container" role="main">
		<form name="event_Frm" enctype="multipart/form-data">
			<table  style="padding-top:50px" align = center width=100% border=0 cellpadding=2 >
				<input type="hidden" name="event_no" value="${requestScope.bvo.event_no}">
				<tr>
	               <td height=20 align= center bgcolor=#ccc><font color=white> 글쓰기</font></td>
	            </tr>
				
				<tr>
		            <td bgcolor=white>
			            <table class = "table2">
			
							<!-- 작성자 받아오기!!! hidden 으로 감춰놈 -->
							 <tr>
				                 <input type="hidden" style="width: 100%" name="e_userid" value="admin" />
				             </tr>
							
							<!-- 글제목 쓰기!!!  -->
							<tr>
				                <td>제목</td>
				                <td><input name="e_title" type="text" size="105" maxlength="100" required autofocus /></td>
				            </tr>
				            
							<!-- 글내용 쓰기!!!  -->
							<tr>
				                <td>글내용</td>
				                <td><textarea name="e_contents" maxlength="4000" cols="107" rows="17"></textarea></td>
				            </tr>
				            
							<!-- 파일 첨부하기!!!  -->
							<tr>
				                <td>첨부파일</td>
				                <td><input type="file" name="e_file" accept=".jpg, .png"/></td>
				            </tr>
							
						</table>
					</td>
                </tr>
			</table>
		
		<!-- 글쓰기 취소 목록 버튼 시작 -->
			<p class="text-center" style="margin-top: 30px; width: 100%;">
				<input type="reset" class="btn btn-secondary btn-md" value="취소">
				<button type="button" id="btnSubmit" class="btn btn-secondary btn-md">등록</button>
				<button type="button" class="btn btn-secondary btn-md" onClick="location.href='<%=ctxPath%>/event.shoes'">목록</button>
			</p>
			<!-- 글쓰기 취소 목록 버튼 끝 -->
		
		
		<!-- 글쓰기 폼태그 끝 -->
		</form>
	</div>


</body>
</html>


<jsp:include page="../n01_leejeongjun/starting_page/footer_startingPage.jsp"/>