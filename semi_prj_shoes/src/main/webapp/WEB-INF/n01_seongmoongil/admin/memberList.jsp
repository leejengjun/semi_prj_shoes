<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<%
	String ctxPath = request.getContextPath();
    //     /MyMVC
%>   

<jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/header_startingPage.jsp" />

<style type="text/css">
	tr.memberInfo:hover {
		background-color: #f1f1f1;
		cursor: pointer;
		
	}
	
	
	#sideinfo{	
		border-right: 1px solid #dee2e6;
	}
	
	#sideinfo > div{
	    text-align: center;
	    line-height: 3;
	    padding-top: 50px !important;
	}
	#sideinfo > div > p > a	{
	    color: black;
	    text-decoration: none;
	    font-size: 14pt;
	    font-weight: bold;
	}	
	
	#sideinfo > div > h3 {
	    font-weight: bold;
	}
	
	#maincontent > nav > div > ul > li > a {
		
	    background-color: gray;
	    border-color: gray;
	
	}
</style>



<script type="text/javascript">

	$(document).ready(function(){
		
		$("select#sizePerPage").bind("change", function(){
			const frm = document.memberFrm;
			frm.action = "memberList.shoes";
			frm.method = "get";
			frm.submit();
		});
		
		$("select#sizePerPage").val("${requestScope.sizePerPage}");
		
		
		$("form[name='memberFrm']").submit(function(){
			if($("select#searchType").val() == "") {
				alert("검색대상을 올바르게 선택하세요!!");
				return false; 
			}
			
			if($("input#searchWord").val().trim() == "") {
				alert("검색어는 공백만으로는 되지 않습니다.\n검색어를 올바르게 입력하세요!!");
				return false; 
			}
		});
		
		
		$("input#searchWord").bind("keyup", function(event){
			if(event.keyCode == 13) {
				goSearch();
			}
		});
		
		
		
	    if("${requestScope.searchType}" != "") { 
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}");
	    }
		

	    $("tr.memberInfo").click( ()=>{
	    	
	    	const $target = $(event.target);
      
	        const userid = $target.parent().children(".userid").text();

	     
	        location.href="<%= ctxPath%>/admin/memberOneDetail.shoes?userid="+userid+"&goBackURL=${requestScope.goBackURL}";
	    //                                                                          &goBackURL=/member/memberList.up?currentShowPageNo=5 sizePerPage=10 searchType=name searchWord=%EC%9C%A0  
	    	
	    });
	 
	});// end of $(document).ready(function(){})-----------------------------

	
	// Function Declaration
	function goSearch() {
		
		if($("select#searchType").val() == "") {
			alert("검색대상을 올바르게 선택하세요!!");
			return; 
		}
		
		if($("input#searchWord").val().trim() == "") {
			alert("검색어는 공백만으로는 되지 않습니다.\n검색어를 올바르게 입력하세요!!");
			return; 
		}
		
		const frm = document.memberFrm;
		frm.action = "memberList.shoes";
		frm.method = "get";
		frm.submit();
	}
	
</script>

<div class="row mx-auto" style="position: relative; margin-top: 100px;">
	 <div class="col-md-3" id="sideinfo" style="position:sticky; height: 400px;  top:200px;">
		<div style= "text-align: center; padding: 20px; ">
		 <h3>관리자 전용</h3>
		 <p><a href="<%= ctxPath%>/admin/productList.shoes">상품관리</a></p>
		 <p><a href="<%= ctxPath%>/orderList.shoes">주문관리</a></p>
		 <p><a href="<%= ctxPath%>/admin/memberList.shoes">회원관리</a></p>
		</div>
		 
	 </div>
	 
	 <div class="col-md-9" id="maininfo">
		<div id="maincontent" style="padding: 20px; ">

<h2 style="margin: 20px; text-align: center; font-weight: bold;">회원전체 목록</h2>

<hr style="solid 1px; margin-bottom: 20px;">

     <form name="memberFrm" action="memberList.shoes" method="get"> 
    	 <div style="text-align: left;">
	    	<select id="searchType" name="searchType">
	    		<option value="">검색대상</option>
	    		<option value="name">회원명</option>
	    		<option value="userid">아이디</option>
	    		<option value="email">이메일</option>
	    	</select>
	    	<input type="text" id="searchWord" name="searchWord">	
			<input type="text" style="display: none;" /> 	
	        <input type="submit" value="검색" style="margin-right: 30px" /> 
    	</div>
    	
    	<div style="text-align: right;">
	    	<span style="color: gray; font-weight: bold; font-size: 12pt;">페이지당 회원명수-</span>
			<select id="sizePerPage" name="sizePerPage">
				<option value="10">10</option>
				<option value="5">5</option>
				<option value="3">3</option>
			</select>
		</div>
     </form>
    
     <table id="memberTbl" class="table table-bordered" style="width: 100%; margin-top: 20px; text-align: center;">
        <thead>
        	<tr style="background-color: gainsboro; font-weight: bold;">
        		<th>아이디</th>
        		<th>회원명</th>
        		<th>이메일</th>
        		<th>성별</th>
        	</tr>
        </thead>
        
        <tbody>
            <c:if test="${not empty requestScope.memberList}">
	            <c:forEach var="mvo" items="${requestScope.memberList}">
	            	<tr class="memberInfo">
	            		<td class="userid">${mvo.userid}</td>
	            		<td>${mvo.name}</td>
	            		<td>${mvo.email}</td>
	            		<td>
	            		    <c:choose>
	            		    	<c:when test="${mvo.gender eq '1'}">
	            		    	   남
	            		    	</c:when>
	            		    	<c:otherwise>
	            		    	   여
	            		    	</c:otherwise>
	            		    </c:choose>
	            		</td>
	            	</tr>
	            </c:forEach>
            </c:if>
            <c:if test="${empty requestScope.memberList}">
            	<tr>
            		<td colspan="4" style="text-align: center;">검색된 데이터가 존재하지 않습니다</td>
            	</tr>
            </c:if>
        </tbody>
     </table>    

     <nav class="my-5">
        <div style="display: flex; width: 80%;">
       	    <ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
        </div>
     </nav>
</div>
</div>
</div>

 <jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/footer_startingPage.jsp" />

    