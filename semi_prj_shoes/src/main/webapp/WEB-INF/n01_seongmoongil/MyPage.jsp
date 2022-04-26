<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
    
<%
    String ctxPath = request.getContextPath();

%>
   
   
<jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/header_startingPage.jsp" />
    

<style type="text/css">
 
.button_base {
	margin-right: 13px;
    border: 0;
    font-size: 18px;
    position: relative;
    width: 200px;
    height: 45px;
    text-align: center;
    box-sizing: border-box;
    display: inline-block;
    left: 21%;
    margin-bottom: 40px;
}


.button_base:hover {
    cursor: pointer;
}

.b01 {
    border: #CBCBCB solid 2px;
    padding: 8px;
    background-color: #ffffff;
}

.b01:hover {
    color: #ffffff;
    background-color: #CBCBCB;
}

div.personalInfo{
	padding: 30px;
	width: 650px;
	position: relative;
    left: 21%;
     background-color: #F1F3F4; 
     margin-bottom: 150px;
    

	
}

span.input{
	font-weight: bold;
}

dfn {
  border-bottom: dashed 1px rgba(0,0,0,0.8);
  padding: 0 0.4em;
  position: relative;
  
}
dfn::after {
  content: attr(data-info);
  display: inline;
  position: absolute;
  top: 22px; left: 0;
  opacity: 0;
  width: 230px;
  font-size: 13px;
  font-weight: 700;
  line-height: 1.5em;
  padding: 0.5em 0.8em;
  background: rgba(0,0,0,0.8);
  color: #fff;
  pointer-events: none; 
  transition: opacity 250ms, top 250ms;
}
dfn::before {
  content: '';
  display: block;
  position: absolute;
  top: 12px; left: 20px;
  opacity: 0;
  width: 0; height: 0;
  border: solid transparent 5px;
  border-bottom-color: rgba(0,0,0,0.8);
  transition: opacity 250ms, top 250ms;
}
dfn:hover {z-index: 2;} 
dfn:hover::after,
dfn:hover::before {opacity: 1;}
dfn:hover::after {top: 30px;}
dfn:hover::before {top: 20px;}

 
 </style>   
 <script type="text/javascript">
 $(function(){
	 
	 $("button#orderList").bind("click", function(){
		 location.href= "<%= ctxPath%>/orderList.shoes";
	 });

	 $("button#qna").bind("click", function(){
		 location.href= "<%= ctxPath%>/qnaList.shoes";
	 });
	 
	 
	 
 });

	function goEditPersonal(userid) {
		
		
		
		// 나의정보 수정하기
		const url = "<%= request.getContextPath()%>/edit.shoes?userid="+userid;
		
		const pop_width = 800;
		const pop_height = 900;
		const pop_left = Math.ceil( (window.screen.width - pop_width)/2 );	<%-- 정수로 만듦 --%>
		const pop_top = Math.ceil( (window.screen.height - pop_height)/2 );
		
		window.open(url, "memberEdit",
				    "left="+pop_left+", top="+pop_top+", width="+pop_width+", height="+pop_height);
		
	}
 
 </script>
 


<div class="container" style="margin-top: 100px; ">
	<h2 style="text-align: center; font-weight: bold; margin-bottom: 20px;">MY PAGE</h2>
	<p style="text-align: center; margin-bottom: 30px;"><span style="font-weight: bold; color: black;">${(sessionScope.loginuser).name}</span>님의 마이페이지 입니다.</p>
	     <button class="button_base b01" id="orderList">
	     	주문내역
	     </button>
	     <button class="button_base b01" id="qna">
	     	문의내역
	     </button>
	     <button onclick="javascript:goEditPersonal('${(sessionScope.loginuser).userid}')" class="button_base b01" id="myInfo">
	     	정보수정
	     </button>
	     
	     
	     <div class="personalInfo">
	     	<div><span class="input">${(sessionScope.loginuser).name}</span>님의 정보</div>
	     	<br>
	     	<div>POINT :&nbsp;&nbsp;&nbsp;&nbsp;<span class="input" id="point"><fmt:formatNumber value="${(sessionScope.loginuser).point}" pattern="###,###" /></span></div>
	     	<div>회원님의 &nbsp;<a href="<%= ctxPath%>/cart.shoes" style="color: black; font-weight: bold;">장바구니</a> 안에는&nbsp;<span class="input" id="point">${requestScope.cartCount}</span>&nbsp;개의 상품이 있습니다.</div>
	     </div> 
		       
		
</div>
 <jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/footer_startingPage.jsp" />