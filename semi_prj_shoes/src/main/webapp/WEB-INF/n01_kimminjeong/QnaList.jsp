<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
    String ctxPath = request.getContextPath();
    //    /semi_prj_shoes
%>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/header_startingPage.jsp" />


<style type="text/css">
 ul {
 /*  width: 300px; */
  margin-left: auto;
  margin-right: auto;
} 

.page_wrap {
	text-align:center;
	font-size:0;
	margin-bottom: 200px;
 }
.page_nation {
	display:inline-block;
}
.page_nation .none {
	display:none;
}
.page_nation a {
	display:block;
	margin:0 3px;
	float:left;
	border:1px solid #e6e6e6;
	width:28px;
	height:28px;
	line-height:28px;
	text-align:center;
	background-color:#fff;
	font-size:13px;
	color:black;
	text-decoration:none;
}

a {
color: black;
}

.page_nation .arrow {
	border:1px solid #ccc;
}

.text-center{
        height : 16;
        font-family :inherit;
        font-size : 12;
        text-align :center;
    }

#searchForm {
 width: 100%;
 text-align: left;
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

</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		$("select#sizePerPage").bind("change", function() {
			const frm = document.qnaSearchFrm
			frm.action = "qnaList.shoes";
			frm.method = "get";
			frm.submit();
		});
		
		$("select#sizePerPage").val("${requestScope.sizePerPage}");
		
		// 검색하기
		$("form[name='qnaSearchFrm']").submit(function() {
			
			if($("select#searchType").val() == "") {
				alert("검색대상을 선택하세요.");
				return false;
			}
			
			if($("input#searchWord").val().trim() == "") {
				alert("검색어를 입력하세요.");
				return false;
			}			
		});
		
		// 검색결과 보이기 (keyUp 또는 keyDown 했을 때 검색결과 보일 것)
		$("input#searchWord").bind("keyup", function() {
			if(event.keyCode == 13) {
				goSearch();
			}
		}); // end of $("input#searchWord").bind("keyup", function() {}-----
		
		if("${requestScope.searchType}" != "") {
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}");
			
		}		
		
	}); // end of $(document).ready(function() {}-----------------

	function goSearch() {
		
		if($("select#searchType").val() == "") {
			alert("검색대상을 올바르게 선택하세요.");
			return;
		}
		
		if($("input#searchWord").val().trim() == ""){
		alert("검색어를 올바르게 입력하세요.");
		return;		
		}	
		
		const frm = document.qnaSearchFrm
		frm.action = "qnaList.shoes";
		frm.method = "get";
		frm.submit();
	}
			
</script>

	<%-- 새글쓰기 누를 때 --%>
	<div class="container" style="margin-top:50px; width: 100%">
		<div align="center"><font size="5" color="gray">1:1문의</font></div>
		<%-- 유저가 로그인 한 상태 && 관리자가 아닐때에만 글쓰기가 가능하도록 한다. --%>
		<c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.userid ne 'admin' }">
		<div class="col-md-12 text-lg-end text-right">
			<button type="button" class="btn btn-secondary" onClick="location.href='<%= ctxPath%>/qnaWrite.shoes'">글쓰기</button>
		</div>
		</c:if>
	</div>
	<%-- 테이블 시작 --%>
	<div class="container">
			<table id="boardTbl" class="table table-hover text-center">
				<thead>
					<tr>
						<th scope="col" class="text-center">글번호</th>
						<th scope="col" class="text-center">제목</th>
						<th scope="col" class="text-center">작성자</th>
						<th scope="col" class="text-center">작성일</th>
						<th scope="col" class="text-center">조회수</th>
					</tr>
				</thead>			
			  	<!-- 게시물 리스트가 출력될 영역 -->
				<tbody>				
					<c:if test="${not empty requestScope.qnaList}">
						<c:forEach var="bvo" items="${requestScope.qnaList}">
							<tr class="qnaDetail">
								<td style="width: 10%">${bvo.qna_num}</td>
								<td style="width: 40%"> <%-- 여기서 getParameter 로 값을 넘겨줄 때, qna_writer 가 아니라 writer 의 id 값을 넘겨주도록 하자. --%>
									<a href="<%=ctxPath%>/qnaContent.shoes?qna_num=${bvo.qna_num}&qna_writer=${bvo.qna_writer}">${bvo.qna_subject}</a>
								</td>	<!-- 글제목 클릭 시 내용보기 -->
								<td style="width: 20%">${bvo.qna_writer}</td>
								<td style="width: 20%">${bvo.qna_regDate}</td>						
								<td style="width: 10%">${bvo.qna_viewCnt}</td>						
							</tr> 
						</c:forEach>
					</c:if>
					<c:if test="${empty requestScope.qnaList}">
						<tr>
							<td colspan="5" style="text-align: center;">검색된 글이 존재하지 않습니다.</td>
						</tr>	
					</c:if>	
				</tbody>
			</table>
		</div>  
	<%-- 검색 부분 --%>
	    <br>
	    <div style="text-align: left;">
	        <form name="qnaSearchFrm" action="qnaList.shoes" method="get">
	            <select id="searchType" name="searchType">
	                <option value="">검색대상</option>
	                <option value="qna_subject">제목</option>
	                <option value="qna_content">내용</option>
	                <option value="qna_writer">작성자</option>
	            </select>				
	            <input type="text" id="searchWord" name="searchWord" />&nbsp;
	            <input type="submit" value="검색" />

			<%-- 페이지당 글수를 보여준다. --%>
<%--				<span style="color: black; font-size: 8pt; text-align: right;">페이지당 글수</span>
			      <select id="sizePerPage" name="sizePerPage">
			         <option value="10">10</option>
			         <option value="5">5</option>
			         <option value="3">3</option>
			      </select>  --%> 
	        </form>    
	    </div>  	
	<%-- 검색하기 부분 끝 --%>

		
	<%-- 게시판 페이징 목록 --%>
	<nav class="col-md-12">
		<div style="display: flex ; text-align: center; width: 100%">
		   <ul class="pagination my" style="margin: auto;">${requestScope.pageBar}</ul>
		</div>
	</nav>
	<%-- 게시판 페이징 끝 --%>
				
<jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/footer_startingPage.jsp" />