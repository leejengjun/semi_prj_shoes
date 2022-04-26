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

#body > div > div {
	margin-top: 40px;
}

#body > div > div.container {
	padding-top: -20px;
}

#body > div.content-container.clearfix > div:nth-child(3) > b > font {
	padding-bottom: 20px;
}

#body > div > div.container > div > table > tbody > tr > th {
    border-collapse: separate;
    box-sizing: border-box;
    font-weight: bold;
    display: table-cell;
    text-align: center;
    border-bottom: 1px solid #e9e9e9;
    background: #f5f5f5;
}

tbody > tr:nth-child(4) > td:nth-child(2) {
	height: 300px;
}

#container > div.container > div.container > div > table > tbody > tr > th {
	border-right: solid 1px #e9e9e9;
	background-color: #eceef0;
}
</style>

<jsp:include page="../n01_leejeongjun/starting_page/header_startingPage.jsp"/>


<script type="text/javascript">
	
	//문의사항 글수정
	function noticeGoEdit() {  // /noticeEdit.shoes 를 properties에 추가하고 action 만들어야함
		
		var frm = document.noticeEditFrm
		frm.action = "<%= ctxPath%>/noticeEdit.shoes";
		frm.method = "POST";
		frm.submit();
		
	}// end of function noticeGoEdit() --------------------------
	
	// 문의사항 글 삭제 
	function noticeGoDelete() {
		
		var notice_no = "${requestScope.bvo.notice_no}";
		var n_userid  = "${requestScope.bvo.n_userid}";
		
		// 팝업창 크기 조절 //
		var pop_width = 600;
		var pop_height = 300;
		
		var pop_left = Math.ceil((window.screen.width - pop_width)/2);
		var pop_top = Math.ceil((window.screen.height - pop_height)/2);
		// 팝업창 크기 조절 //
		
		
		var url = "<%= ctxPath%>/noticeDelete.shoes?notice_no="+notice_no+"&n_userid="+n_userid;
		
		window.open(url, "deleteCheck", "left="+pop_left+", top="+pop_top+", width="+pop_width+", height="+pop_height);
		
	}// end of noticeGoDelete(){}--------------------------------------
	
</script>
	
</script>

	<!------- 글 위에 공지사항 큰 글씨 시작 ------->
	<div align="left">
	    <br>
	    <b><font color="black" size="6" color="black">&nbsp;&nbsp;공지사항</font></b>
		<br>
	</div>
	<!------- 글쓰기 폼태그 위에 공지사항 큰 글씨 끝 ------->
	
	
	
		<!-- --------------------------- main --------------------------------------- -->
	
	<div class="container" style="padding-top: 60px;" >
		<div class="row">
			<table class="table" style="text-align:center; border: 1px solid #dddddd; margin-top: -40px;">
				<tbody>
					<tr>
						<th style="width: 20%">글 제목</th>
						<td colspan="2" style="text-align: left;">${requestScope.bvo.n_title}</td>
					</tr>
					<tr>
						<th>작성자</th>
						<c:if test="${requestScope.bvo.n_userid eq 'admin'}">
							<td colspan="2" style="text-align: left;">관리자</td>
						</c:if>
					</tr>
					<tr>
						<th>작성일</th>
						<td colspan="2" style="text-align: left;">${requestScope.bvo.n_date}</td>
					</tr>
					<tr>
						<th style="vertical-align: middle;">내용</th>
						<c:if test="${not empty requestScope.bvo.n_file}">
							<td style="text-align: left;"><img src="/semi_prj_shoes/images/JeongKyeongEun/${requestScope.bvo.n_file}" class="img-fluid" style="width: 100%;" />
							<br><br>${requestScope.bvo.n_contents}<br></td>
						</c:if>
						<c:if test="${empty requestScope.bvo.n_file}">
							<td colspan="2" style="min-height: 200px; text-align: left;">${requestScope.bvo.n_contents}</td>
						</c:if>
					</tr>	
					
					
					<tr>  <%-- <c:if> 문을 통해 첨부파일 유무에 따른 문구 출력 --%>
						<th>첨부파일</th>
						<c:if test="${not empty requestScope.bvo.n_file}">
							<td class="pl-3 py-3" colspan="3" style="font-weight: bold; text-align: left;">본문 내용 참조</td>
						</c:if>
						<c:if test="${empty requestScope.bvo.n_file}">
							<td class="pl-3 py-3" colspan="3" style="font-weight: bold; text-align: left;">없음</td>	<%-- 첨부파일 없을때 --%>
						</c:if>
					</tr>
																				
				</tbody>
			</table>
		</div>		
		
			<%-- 글내용 보기에서 '수정' '목록' '삭제' 버튼 --%>
			<p class="text-center" style="margin-top: 20px; width: 100%;">	
				<%-- admin 으로 로그인 했을때만 수정버튼을 보여준다. --%>
				<c:if test="${not empty sessionScope.loginuser and sessionScope.loginuser.userid eq 'admin'}">   		
					<button type="button" class="btn btn-secondary" onClick="noticeGoEdit()">수정</button>
				</c:if>	
				
				<button type="button" class="btn btn-secondary" onClick="location.href='<%= ctxPath%>/notice.shoes'">목록</button>
				
				<%-- admin 으로 로그인 했을때만 삭제버튼을 보여준다. --%>	
				<c:if test="${not empty sessionScope.loginuser and sessionScope.loginuser.userid eq 'admin'}">   
					<button type="button" class="btn btn-secondary" onClick="noticeGoDelete()">삭제</button>
				</c:if>
			</p>
	</div>


<%-- 글내용 보기에서 '수정'버튼 클릭 시 보여주는 기존 글 입력정보 --%>
<form name="noticeEditFrm"  enctype="multipart/form-data" >
	<input type="hidden" name="notice_no"  value="${requestScope.bvo.notice_no}" />
	<input type="hidden" name="n_userid"   value="${requestScope.bvo.n_userid}" />
	<input type="hidden" name="n_title"    value="${requestScope.bvo.n_title}" />
	<input type="hidden" name="n_contents" value="${requestScope.bvo.n_contents}" />
	<input type="hidden" name="n_file"     value="${requestScope.bvo.n_file}" />
</form>

     
<jsp:include page="../n01_leejeongjun/starting_page/footer_startingPage.jsp"/>