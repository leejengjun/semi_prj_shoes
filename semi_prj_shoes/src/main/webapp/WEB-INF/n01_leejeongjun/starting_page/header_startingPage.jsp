<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
    String ctxPath = request.getContextPath();
    //    /semi_prj_shoes
%>
<!DOCTYPE html>
<html>
<head>

<title>:::HOMEPAGE:::</title>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/leejeongjun/index_startingPage.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.css" > 
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.js"></script>



<!-- 구글 글꼴 임포트 -->
<style>
@import url('https://fonts.googleapis.com/css2?family=Anton&family=Black+Han+Sans&display=swap');
</style>

<script>
function openNav() {
  document.getElementById("mySidebar").style.width = "100%";
}

function closeNav() {
  document.getElementById("mySidebar").style.width = "0";

}

function openNav1() {
  document.getElementById("mySidebar1").style.width = "100%";
}

function closeNav1() {
  document.getElementById("mySidebar1").style.width = "0";
}

function openNav2() {
  document.getElementById("mySidebar2").style.width = "100%";
}

function closeNav2() {
  document.getElementById("mySidebar2").style.width = "0";
}

//=== 로그아웃 처리 함수 === //
function goLogOut() {
	
	// 로그아웃을 처리해주는 페이지로 이동
	location.href="<%= request.getContextPath()%>/mypage/logout.shoes";
	
}// end of function goLogOut()------------------------------------

</script>

</head>


<body>


<%-- 모달창 부분 --%>
<div class="modal" id="myModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content bg-dark">
            <div class="modal-header">
                <h5 class="modal-title text-white" style="font-size: 17pt; font-weight: bold;">배송지연 안내!</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body text-white">
                <p style="font-weight: bold; font-size: 14pt">현재 CJ대한통운 택배사의 단체파업으로 인해</p>
                <p>배송이 지연되거나 배송이 불가한 지역이 발생하는 상황입니다.</p>
                <p>아래에 명시된 지역은 배송이 지연되거나 불가한 지역이니</p>
                <p>양해부탁드립니다.</p>
                <p class="bg-danger text-white figure-caption text-center" style="font-weight: bold; font-size: 15pt;">배송 지연 및 불가 지역</p>
                <p></p>
                <p class="figure-caption text-center" style="font-size: 12pt; font-weight: bold;">충청북도: 청주시, 충주시</p>
                <p class="figure-caption text-center" style="font-size: 12pt; font-weight: bold;">부산광역시 전지역</p>
                <p class="figure-caption text-center" style="font-size: 12pt; font-weight: bold;">강원도 전지역</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal" style="font-weight: bold; ">확인</button>
            </div>
        </div>
    </div>
</div>
<%-- 모달창 부분 끝--%>


<%-- 상단 네비게이션 시작 --%>
<nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top mx-auto py-3" style="width: 80%;">
	<!-- Brand/logo --> <!-- Font Awesome 5 Icons -->
	<a class="navbar-brand" href="<%= ctxPath%>/index.shoes" ><img style="width: 50px;" src="<%= ctxPath %>/images/leejeongjun/logo.png" /></a>
	
	<!-- 아코디언 같은 Navigation Bar 만들기 -->
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
      <span class="navbar-toggler-icon"></span>
    </button>
	
	<%-- 사이드바 시작 --%>
	<div id="mySidebar" class="sidebar">
	    <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
	  	<div class="overlay-content">
		  <a href="<%= ctxPath%>/allproduct.shoes">상품전체보기</a>
		  <a href="<%= ctxPath%>/allproduct.shoes?cnum=1">남성</a>
		  <a href="<%= ctxPath%>/allproduct.shoes?cnum=2">여성</a>
		  <a href="<%= ctxPath%>/allproduct.shoes?cnum=3">유아</a>
		</div>
	</div>
	
	<div id="mySidebar1" class="sidebar">
	    <a href="javascript:void(0)" class="closebtn" onclick="closeNav1()">×</a>
	  	<div class="overlay-content">
		  <a href="<%= ctxPath%>/notice.shoes">공지사항</a>
		  <a href="<%= ctxPath%>/event.shoes">이벤트</a>
		  <a href="<%= ctxPath%>/qnaList.shoes">1대1 문의</a>
		  <a href="<%= ctxPath%>/faqList.shoes">자주하는질문</a>
		  <a href="<%= ctxPath%>/location.shoes">매장찾기</a>
		</div>
	</div>
	
	<div id="mySidebar2" class="sidebar">
	  <a href="javascript:void(0)" class="closebtn" onclick="closeNav2()">×</a>
	  <div class="overlay-content">
		  <a href="<%= ctxPath%>/admin/productList.shoes">상품관리</a>
		  <a href="<%= ctxPath%>/orderList.shoes">주문관리</a>
		  <a href="<%= ctxPath%>/admin/memberList.shoes">회원관리</a>
	  </div>	
	</div>
	<%-- 사이드바 끝 --%>	
	
	<div class="collapse navbar-collapse" id="collapsibleNavbar">
	  <ul class="navbar-nav mr-auto" style="font-size: 16pt;">
	     <li class="nav-item active">
	        <a id="menulist" class="nav-link menufont_size" href="#">
	        	<span id="main">
				  <button class="openbtn" onclick="openNav()">신발</button>  
				</span>
	        </a>
	     </li>
	     <li class="nav-item">
	     	<a id="menulist" class="nav-link menufont_size" href="#">
	     		<span id="main1">
				  <button class="openbtn" onclick="openNav1()">게시판</button>  
				</span>
	     	</a>
	     </li>
	     
	     <c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.userid eq 'admin'  }"> <%-- admin 으로 로그인 했으면 --%>
	     <li class="nav-item">
	     	<a id="menulist" class="nav-link menufont_size" href="#">
	     		<span id="main2">
				  <button class="openbtn" onclick="openNav2()" style="color: red;">관리자</button>  
				</span>
	     	</a>
	     </li>
	     </c:if>
	     
	     <c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.userid ne 'admin'}">
	     <li class="nav-item">
	     	<a id="menulist" class="nav-link menufont_size" href="#">
	     		<span id="main3">
				  <button class="openbtn" onclick="javascript:location.href='orderList.shoes'" style="color: blue;">주문내역</button>  
				</span>
	     	</a>
	     </li>
		 </c:if>

         </ul>
         
         <figcaption class="figure-caption text-right">
          <c:if test="${empty sessionScope.loginuser}">
	        <a class="navbar-brand" href="<%= ctxPath%>/n01_wonhyejin/login.shoes"><i class="far fa-user fa-2x"></i></a>
	      </c:if>  
	     <c:if test="${not empty sessionScope.loginuser}"> <%-- 로그인 되어있을 때 아래 아이콘 클릭하면 마이페이지로 이동함. --%>
	     	<a class="navbar-brand" style="font-family: 'Black Han Sans', sans-serif;" href="<%= ctxPath%>/mypage.shoes">${(sessionScope.loginuser).name}님 환영합니다.<i style="margin-left: 5px;" class="far fa-user fa-2x"></i></a>
	     	<a class="navbar-brand" href="javascript:goLogOut('${(sessionScope.loginuser).userid}')"><i class="fas fa-sign-out-alt fa-2x"></i></a>
	     </c:if>
			<a class="navbar-brand" href="<%= ctxPath%>/cart.shoes"><i class="fas fa-cart-plus fa-2x"></i></a>
			<a class="navbar-brand" href="<%= ctxPath%>/faqList.shoes"><i class="fas fa-info-circle fa-2x"></i></a>
	     </figcaption>
	
	</div>
</nav>
<%-- 상단 네비게이션 끝 --%>

<div id="container" class="container-fluid" style="position: relative; top:90px; padding: 0.1% 2.5%;">
	<div class="container" style="width: 70%; margin: auto;">