<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
	//    /semi_prj_shoes
%>    
<!-- 직접 만든 CSS -->
<link rel="stylesheet" href="<%= ctxPath%>/css/JeongKyeongEun/notice_event.css" />

<style type="text/css">

#body > div > main > div.container > div > button {
	border: solid 1px gray;
    border-radius: inherit;
    font-size: 10pt;
    padding: 0 10px;
    height: 22px;
    background-color: #dfdfdf;
    float: right;
    margin-top: 8px;
    margin-right: 120px;
}

#body > div > main > div.search-form.first.align-right > form > fieldset {
	margin-right: 17px;
}

#body > div {
	padding-top: 10px;
}


	/*페이지네이션 컬러*/
	.my.pagination > .active > a, 
	.my.pagination > .active > span, 
	.my.pagination > .active > a:hover, 
	.my.pagination > .active > span:hover, 
	.my.pagination > .active > a:focus, 
	.my.pagination > .active > span:focus {
	  background: gray;
	  border-color: white;
}

.pagination {
	justify-content : center;
}

#body > div > main > nav > div {
	margin-top: 20px;
}

tbody {
	border-bottom: solid 1px #e9e9e9;
}

li:nth-child(1) > a, li:nth-child(2) > a, li:nth-child(3) > a, li:nth-child(4) > a, li:nth-child(5) > a,
li:nth-child(6) > a, li:nth-child(7) > a {
	color: #212529;
}

</style>

<jsp:include page="../n01_leejeongjun/starting_page/header_startingPage.jsp"/>


<script type="text/javascript">
   
   $(document).ready(function(){
	   
      $("select#sizePerPage").bind("change", function() {
			const frm = document.eventSearchFrm
			frm.action = "event.shoes";
			frm.method = "get";
			frm.submit();
		});
		
		$("select#sizePerPage").val("${requestScope.sizePerPage}");
		
		
		// 검색하기
		$("form[name='eventSearchFrm']").submit(function(){  // 이 폼이 submit 될때 검사하겠다.   검색
			
			if( $("select#searchType").val() == "" ) {
				alert("검색대상을 선택하세요.");
				return false;  // return false;는 submit 을 하지말라는 것이다.
			}
		
		 	if( $("input#searchWord").val().trim() == "" ) {
		 		alert("공백입력은 불가합니다.\n검색어를 올바르게 입력하세요.");
		 		return false;  // return false;는 submit 을 하지말라는 것이다.
		 	}
			
		});
		
		// 검색결과 보이기 (keyUp 또는 keyDown 했을 때 검색결과 보일 것)
		$("input#searchWord").bind("keyup", function() {
			if(event.keyCode == 13) {
				goSearch();
			}
		}); // end of $("input#searchWord").bind("keyup", function() {}-----
		
		// "${requestScope.searchType}"  쌍따옴표 필수!!! 여기는 자바스크립트이다.
		if("${requestScope.searchType}" != "") {
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}");
			
		}		
    	
   });// end of $(document).ready(function()----------------------------------
		  
		   
// Function Declaration 
	function goSearch() {
		
		if( $("select#searchType").val() == "" ) {
			alert("검색대상을 선택하세요.");
			return;  // return 은 함수를 종료하라는 말이다.
		}
	
	 	if( $("input#searchWord").val().trim() == "" ) {
	 		alert("공백입력은 불가합니다.\n검색어를 올바르게 입력하세요.");
	 		return;  // return 은 함수를 종료하라는 말이다.
	 	}
	 	
	 	const frm = document.eventSearchFrm;
	 	frm.action = "event.shoes";  // 자기가 자기한테 가기
	 	frm.method = "get";  // 생략가능. 안 쓰면 get 방식
	 	frm.submit();
	 	
	}   
		   
	  
</script>


			<!-- --------------------------- main --------------------------------------- -->
		<main class="main">
			<h2 class="main title" style="margin-top: 40px; padding-left: 40px; font-weight: bold; ">이벤트게시판</h2>
			
			<div class="search-form first align-right">
				
				<form name="eventSearchFrm" action="event.shoes" method="get">
					
					<%-- 게시글 수 설정을 form 태그 밖에 하면 기능이 구현되지 않는다. --%>
					<span style="color: gray; font-weight: bold; font-size: 12pt; padding-left: 820px;">게시글 수 설정</span>
			        <select id="sizePerPage" name="sizePerPage" style="font-size: 10pt; height: 23px; width: 45px; float: right;"> <%-- select 태그는 이벤트가 change!!! click이 아니다 --%>
				         <option value="10">10</option>
				         <option value="5">5</option>
				         <option value="3">3</option>
			        </select>
			        <br>
			        
			        <input type="submit" value="검색" style="float: right; margin-top: 8px; margin-bottom: 8px;" /> 
			        
					<input type="text" id="searchWord" name="searchWord" style="float: right; margin-right: 8px; margin-top: 8px;">
						<%-- form 태그내에서 전송해야할 input 태그가 만약에 1개 밖에 없을 경우에는 유효성검사가 있더라도 
				               유효성 검사를 거치지 않고 막바로 submit()을 하는 경우가 발생한다.
				               이것을 막아주는 방법은 input 태그를 하나 더 만들어 주면 된다. 
				               그래서 아래와 같이 style="display: none;" 해서 1개 더 만든 것이다. 
				       --%>
			        <input type="text" style="display: none;" /> <%-- 조심할 것은 type="hidden" 이 아니다. --%>
			        
					<select id="searchType" name="searchType" style="height: 30px; float: right; margin-right: 8px; margin-top: 8px;">
						<option value="">검색대상</option>
						<option value="e_userid">작성자</option>
						<option value="e_title">제목</option>
					</select>
				</form>
			</div>
			
			<%-- -------------------- 테이블 시작 -------------------- --%>
			
			<div class="event margin-top">
				<table class="table">
					<thead>   <!-- 여기가 테이블 헤드!! -->
						<tr>
							<th class="w60">번호</th>
							<th class="expand" style="text-align: center;">제목</th>
							<th class="w100">작성자</th>
							<th class="w100" style="text-align: right; padding-right: 30px;">작성일</th>
						</tr>
					</thead>
					
					<tbody> <!-- 여기부터 글 목록 -->
					 	<c:if test="${not empty requestScope.eventList}">
							<c:forEach var="bvo" items="${requestScope.eventList}">	 
								<tr class="eventList">
									<td class="event_no">${bvo.event_no}</td>
									<td class="title indent text-align-left"><a style="color: #212529;" href="<%=ctxPath%>/event_contents.shoes?event_no=${bvo.event_no}">${bvo.e_title}</a></td>
									<td>${bvo.e_userid}</td>
									<td>${bvo.e_date}</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty requestScope.eventList}">
							<tr>
								<td colspan="5" style="text-align: center;">검색된 글이 존재하지 않습니다.</td>
							</tr>	
						</c:if>	
					</tbody>
				</table>
			</div>
			
		
			<!-- -------------------- 새글쓰기 누를 때 -------------------- -->
			<%-- admin 으로 로그인 했을때만 보여준다. --%>
			<c:if test="${not empty sessionScope.loginuser and sessionScope.loginuser.userid eq 'admin'}">   
				<div style="border: solid 0px red; width: 100%;" align="right">
					<button type="button" class="btn btn-secondary btn-sm my-3" onclick="javascript:location.href='<%= ctxPath%>/event_write.shoes'">글쓰기</button>
				</div>
			</c:if>
					
			<%-- 페이지바 보여주기 --%>
			<nav class="col-md-12">
				<div style="display: flex; text-align: center; width: 100%; margin: 50px 0px;" >
				   <ul class="pagination my" style="margin: auto; margin-top: -40px;">${requestScope.pageBar}</ul>
				</div>
			</nav>
			
		</main>
			
	</div>
</div>
     <!-- 중앙 컨텐츠 끝 -->
     
     
     
<jsp:include page="../n01_leejeongjun/starting_page/footer_startingPage.jsp"/>
     
   