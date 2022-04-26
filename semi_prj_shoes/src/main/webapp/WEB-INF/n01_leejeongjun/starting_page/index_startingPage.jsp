<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="member.model.wonhyejin.MemberVO" %>

<%
	String ctxPath = request.getContextPath();
%>    

<style type="text/css">

</style>

<jsp:include page="header_startingPage.jsp"/>
 
<script type="text/javascript">
	
	$(document).ready(function(){
		$("#myModal").modal('show');	//페이지 열자마자 모달창 띄우기
		
<%
   String login_success = (String) session.getAttribute("login_ok");

   
   if(login_success != null) {
%>
      alert("<%= login_success%>");
<%
   session.removeAttribute("login_ok");  
   }
   
%>
		
	});
	
</script>

		  
			<div id="carouselExampleIndicators" class="carousel slide carousel-fade" data-ride="carousel">
			  <ol class="carousel-indicators">
			  <!-- forEach로 캐러셀 이미지 수 확보하는 것. -->
			    <c:forEach items="${requestScope.imgList}" varStatus="status">
			    	<c:if test="${status.index == 0}">
			  			<li data-target="#carouselExampleIndicators" data-slide-to="${status.index}" class="active"></li>
			    	</c:if>
			    	<c:if test="${status.index > 0}">
			    		<li data-target="#carouselExampleIndicators" data-slide-to="${status.index}"></li>
					</c:if>		    
			    </c:forEach>
			  </ol>
			  
			  <div class="carousel-inner">
			  <c:forEach var="imgvo" items="${requestScope.imgList}" varStatus="status">
			    	<c:if test="${status.index == 0}">
			  			<div class="carousel-item active">
					      <img src="<%= ctxPath%>/images/leejeongjun/${imgvo.imgfilename}" class="d-block w-100"> <!-- d-block 은 display: block; 이고  w-100 은 width 의 크기는 <div class="carousel-item active">의 width 100% 로 잡으라는 것이다. -->  
					    </div>
			    	</c:if>
			    	<c:if test="${status.index > 0}">
			    		<div class="carousel-item">
					      <img src="<%= ctxPath%>/images/leejeongjun/${imgvo.imgfilename}" class="d-block w-100">  	      
					    </div>
					</c:if>
			    </c:forEach>
			  </div>
			
			  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
			    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    <span class="sr-only">Previous</span>
			  </a>
			  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
			    <span class="carousel-control-next-icon" aria-hidden="true"></span>
			    <span class="sr-only">Next</span>
			  </a>
			</div>
			
			
			
			<div>
				<h3 style="margin-top: 50px;">Shop By Style</h3>
				<a id="new_product_go" href="<%= ctxPath%>/allproduct.shoes">
				<span><i class="fas fa-arrow-right"></i></span>
				<span>상품 보러 가기</span>
				</a>
			</div>
			
			<div id="new_item">
				<div class="row" style="margin-top: -20px;  margin-bottom: 100px;">
					
					<c:forEach var="imgshows" items="${requestScope.imgshow}" varStatus="status">
				    	<c:if test="${status.index >= 0}">
				  			<div class="col-sm-6 col-lg-3 mb-3">	
				  				<div class="card"> 
							  		<img src="<%= ctxPath%>/images/leejeongjun/${imgshows.imgfilename}" class="card-img-top"/>
								</div>
							</div>
				    	</c:if>
				    </c:forEach>
		
				</div>
			</div>
			
			
			
			<!-- 이미지에 .mx-auto (margin:auto) and .d-block (display:block) utility 클래스를 주면 된다. -->
			<img src="<%= ctxPath%>/images/leejeongjun/show4.jpg" class="img-fluid mx-auto d-block mt-5" alt="center">
			
			
			<div class="row figure-caption text-center mt-5">
			    <div class="col">
			      <i class="fas fa-check fa-3x"></i>
			      <p style="font-size: 17pt; font-weight: bolder;">무료배송</p>
			      <P>5만원 이상 구매 시 무료배송</P>
			    </div>
			    <div class="col">
			      <i class="fas fa-check fa-3x"></i>
			      <p style="font-size: 17pt; font-weight: bolder;">교환/반품 서비스</p>
			      <p>사이즈를 잘못 선택하셨나요?</p>
			      <p>교환/반품 서비스에 대해</p>
			      <p>더 알아보세요.</p>
			      <p></p>
			    </div>
			    <div class="col">
			      <i class="fas fa-check fa-3x"></i>
			      <p style="font-size: 17pt; font-weight: bolder;">회원 전용 혜택</p>
			      <p>신규 가입 축하 쿠폰, 드로우 응모 등</p>
			      <p>지금 회원 가입 하시고</p>
			      <p>더욱 특별한 혜택을 누려보세요</p>
			      <p></p>
			      <a href="<%= ctxPath%>/n01_wonhyejin/memberRegister.shoes">회원 가입 하기</a>
			    </div>
			    <div class="col">
			      <i class="fas fa-check fa-3x"></i>
			      <p style="font-size: 17pt; font-weight: bolder;">Follow Us</p>
			      <p>컨버스의 SNS 채널을 통해</p>
			      <p>신상품 정보 및 이벤트 등</p>
			      <p> 새로운 소식을 확인하세요</p>
			      <a class="bady-brand" href="https://www.instagram.com/converse_kr/?hl=ko" target="_blank"><i class="fab fa-instagram fa-2x"></i></a>
			      <a class="bady-brand" href="https://ko-kr.facebook.com/converse.kr/" target="_blank"><i class="fab fa-facebook-f fa-2x"></i></a>
			    </div>
			 </div>
		
					
		

<jsp:include page="footer_startingPage.jsp"/>