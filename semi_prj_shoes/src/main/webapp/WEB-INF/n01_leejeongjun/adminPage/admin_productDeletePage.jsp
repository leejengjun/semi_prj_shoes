<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>    

<jsp:include page="../starting_page/header_startingPage.jsp"/>

<script type="text/javascript">
	
	$(document).ready(function(){
	
	})
	
	
	function goDelete(){

		const bool = window.confirm("정말로 삭제하시겠습니까?");
		
		if(bool){
			const frm = document.delFrm;
		//	console.log("확인용 삭제할 제품번호 => " + frm.pnum.value);
		
			frm.action = "productDelete.shoes";
			frm.method = "POST";
			frm.submit();
		}
		
	}

</script>

<form name="delFrm">
	<div style="height: 500px; text-align: center; margin-top: 300px;" align="center;" >
	<p style="color: red; font-size: 25pt; font-weight: bold;">삭제할 상품의 '제품번호'를 입력하세요!(정확하게 입력하셔야 합니다.)</p>		
	<input style="margin-bottom: 30px;" type="text" id="pnum" name="pnum" value=""/><br>
	<p style="color: red; font-size: 15pt; font-weight: bold;" >예) 제품번호 : 23 이라면 '23' 만 입력하세요!</p>
	<button type="button" class="btn btn-outline-danger" onclick="goDelete();">삭제</button>
	<button type="button" class="btn btn-outline-success" onclick="javascript:location.href='<%= ctxPath%>/admin/productList.shoes'">제품목록[처음으로]</button> 
	
	
	</div>

</form>


<jsp:include page="../starting_page/footer_startingPage.jsp"/>