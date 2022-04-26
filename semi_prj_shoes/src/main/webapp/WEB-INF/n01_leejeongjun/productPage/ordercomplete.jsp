<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
	//     /semi_prj_shoes
%>    

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/leejeongjun/ordercomplete.css" />

<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">


</script>

<jsp:include page="../starting_page/header_startingPage.jsp"/>

<%-- 내용물 시작 --%>

<div align="center" style="margin-top: 200px; height: 500px;">

	<i class="far fa-check-circle fa-10x"></i>
	<h2>주문이 성공적으로 완료되었습니다!</h2>
	<h3 style="color: blue; font-weight: bold;">" ${(sessionScope.loginuser).name } "</h3>
	<h4>님의 주문 결제가 완료되었습니다.</h4>
	<h4>이용해주셔서 감사합니다.</h4>
	
	<button type="button" class="btn btn-outline-primary" onclick="location.href='<%= ctxPath%>/orderList.shoes';">주문내역보기</button>
	<button type="button" class="btn btn-outline-success" onclick="location.href='<%= ctxPath%>/index.shoes';">홈으로 이동</button>



</div>



<%-- 내용물 끝 --%>

<jsp:include page="../starting_page/footer_startingPage.jsp"/>