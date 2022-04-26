<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    String ctxPath = request.getContextPath();
    //    /semi_prj_shoes
%>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/leejeongjun/admin_productPage.css" />

<jsp:include page="../starting_page/header_startingPage.jsp"/>

<style type="text/css">
	tr.productInfo:hover{
		background-color: gray;
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
   #sideinfo > div > p > a   {
       color: black;
       text-decoration: none;
       font-size: 14pt;
       font-weight: bold;
   }   
   
   #sideinfo > div > h3 {
       font-weight: bold;
   }
	
</style>

<script type="text/javascript">

	$(document).ready(function(){

		// **** select 태그에 대한 이벤트는 click 이 아니라 change 이다. **** //
		$("select#sizePerPage").bind("change", function(){
			const frm = document.productFrm;
			frm.action = "productList.shoes";
			frm.method = "get";
			frm.submit();
		});	// end of $("select#sizePerPage").bind("change", function()-----------
		
		$("select#sizePerPage").val("${requestScope.sizePerPage}");
		
		
		
		$("form[name='productFrm']").submit(function(){
			if( $("select#searchType").val() == "" ){
				alert("검색대상을 올바르게 선택하세요!!");
				return false; // return false; 는 submit을 하지말라는 것이다.
			}
			
			if( $("input#searchWord").val().trim() == "" ){
				alert("검색어는 공백만으로는 되지 않습니다. \n검색어를 올바르게 입력하세요!!");
				return false; // return false; 는 submit을 하지말라는 것이다.
			}
		});// end of $("form[name='memberFrm']").submit(function()-----------
		
		$("input#searchWord").bind("keyup", function(event){
			if(event.keyCode == 13){
				// 검색어에서 엔터를 치면 검색하러 가도록 한다.
				goSearch();
			}
		});// end of $("input#searchWord").bind("keyup", function(event)----------------	
				
				
	//	alert("확인용 ${requestScope.searchType}");
	//		확인용 ""	
	//		확인용 name
				
		if( "${requestScope.searchType}" != "" ) {	// "" 은 null이 아니다.
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}");
		}		
				
	
	
	
	});// end of $(document).ready(function()-------------------------------

			
	// Function Declaration		
	function goSearch(){
		
		if( $("select#searchType").val() == "" ){
			alert("검색대상을 올바르게 선택하세요!!");
			return; // return; 는 goSearch() 함수 종료이다.
		}
		
		if( $("input#searchWord").val().trim() == "" ){
			alert("검색어는 공백만으로는 되지 않습니다. \n검색어를 올바르게 입력하세요!!");
			return; // return; 는 goSearch() 함수 종료이다.
		}
		
		const frm = document.productFrm;
		frm.action = "productList.shoes";
		frm.method = "get";
		frm.submit();
	}// end of function goSearch()------------
			
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
	 
	 <div class="col-md-9" id="maininfo" align="center">
		<div id="maincontent" style=" text-align: center; padding: 20px; ">
			<h4>::상품관리::</h4>
	
			<%--	<form name="productFrm">  --%>
			<form name="productFrm" action="productList.shoes" method="get"> 
				<select id="searchType" name="searchType" style="margin-top: 20px;">
					<option value="">검색대상</option>
					<option value="pname">제품명</option>
					<option value="pnum">제품번호</option>
				</select>
				<input type="text" id="searchWord" name="searchWord">
				
				<%-- form 태그내에서 전송해야할 input 태그가 만약에 1개 밖에 없을 경우에는 유효성검사가 있더라도 
		               유효성 검사를 거치지 않고 막바로 submit()을 하는 경우가 발생한다.
		               이것을 막아주는 방법은 input 태그를 하나 더 만들어 주면 된다. 
		               그래서 아래와 같이 style="display: none;" 해서 1개 더 만든 것이다. 
				--%>
				<input type="text" style="display: none;" /> <%-- 조심할 것은 type="hidden" 이 아니다. --%>
				
			<%--	<button type="button" onclick="goSearch();" style="margin-right: 30px">검색</button> --%>
				<input type="submit" value="검색" style="margin-right: 30px"/> 
			
				<span style="color: red; font-weight: bold; font-size: 12pt;">페이지당 제품 수</span>
		        <select id="sizePerPage" name="sizePerPage">
					<option value="10">10</option>
					<option value="5">5</option>
					<option value="3">3</option>
				</select>	
			</form>
			
			<div align="right">
				<button type="button" class="btn btn-outline-primary" onclick="javascript:location.href='productRegister.shoes'"> 상품 등록하기</button>
				<button type="button" class="btn btn-outline-danger" onclick="javascript:location.href='productDelete.shoes'"> 상품 삭제하기 </button>
				<button type="button" class="btn btn-outline-success" onclick="javascript:location.href='productList.shoes'">제품목록[처음으로]</button> 
			</div>
			
			<table id="productTbl" class="table table-bordered" style="text-align:center; font-weight:bold; font-size: 13pt;  margin-top: 20px;">
		        <thead>
		            <tr>
						<th>제품번호</th>
						<th>제품명 / 제품이미지</th>
						<th>카테고리</th>
						<th>상품스펙</th>
		            </tr>
		        </thead>
		      
		        <tbody>
		        	<c:if test="${not empty requestScope.productList}">
		        		<c:forEach var="pvo" items="${requestScope.productList}">
			        		<tr class="productInfo">
			        			<td class="pnum">${pvo.pnum}</td>
			        			<td>
			        			<a>${pvo.pname}</a>
			        			<img style="width: 100px;" src="<%= ctxPath%>/images/kimjieun/product_img/${pvo.pimage}" >
			        			</td>
			        			<td>
			        				<c:choose>
			        					<c:when test="${pvo.fk_cnum eq '1'}">
			        						남성
			        					</c:when>
			        					<c:when test="${pvo.fk_cnum eq '2'}">
			        						여성
			        					</c:when>
			        					<c:otherwise>
			        						유아
			        					</c:otherwise>
			        				</c:choose>
			        			</td>
			        			<td>
			        				<c:choose>
			        					<c:when test="${pvo.fk_snum eq '1'}">
			        						HIT상품
			        					</c:when>
			        					<c:when test="${pvo.fk_snum eq '2'}">
			        						신상품
			        					</c:when>
			        					<c:otherwise>
			        						베스트상품
			        					</c:otherwise>
			        				</c:choose>
			        			</td>
			        		</tr>
			        	</c:forEach>
		        	</c:if>
		        	<c:if test="${empty requestScope.productList}">
		        		<tr>
		        			<td colspan="4" style="text-align: center;">검색된 데이터가 존재하지 않습니다.</td>
		        		</tr>
		        	</c:if>
		        </tbody>
			</table>
		
			<nav class="my-5">
				<div style="display: flex; width: 80%;">	<%-- 가운데 오게 하기 --%>
					<ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
				</div>
			</nav>
			
			
			
			
		</div>
	 </div>
</div>	


<jsp:include page="../starting_page/footer_startingPage.jsp"/>