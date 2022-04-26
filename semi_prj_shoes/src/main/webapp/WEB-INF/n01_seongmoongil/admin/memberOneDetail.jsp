<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>


<style type="text/css">

	tr.memberInfo:hover {
		background-color: #e5e5e5;
		cursor: pointer;
		
	}
	
	#sideinfo{	
		border-right: 1px solid #dee2e6;
	}
	
	#sideinfo > div{
	    text-align: center;
	    padding: 20px;
	    -webkit-user-modify: read-write-plaintext-only;
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

	div#mvoInfo {
		text-align: left;
		margin-top: 30px; 
		font-size: 13pt;
		line-height: 200%;
	}
	
	#maincontent > div:nth-child(5) > button{
	margin-top: 30px;
    background-color: #f1f1f1;
    border-radius: 5px;
    border: 1px solid #cccccc;
	}
	
	button:hover{ 
		box-shadow: 200px 0 0 0 rgba(0,0,0,0.25) inset, -200px 0 0 0 rgba(0,0,0,0.25) inset; 
		color: white;
	}
	
	span.myli {
		display: inline-block;
		width: 90px;
		}
	}
	
	

</style>

<jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/header_startingPage.jsp" />


<script type="text/javascript">

	$(document).ready(function(){
		
		$("div#smsResult").hide();
		
		$("button#btnSend").click( ()=>{
			
		//	console.log( $("input#reservedate").val() + " " + $("input#reservetime").val() );
		//  2022-04-05 11:20
		
		    let reservedate = $("input#reservedate").val();
		    reservedate = reservedate.split("-").join("");
		    
		    let reservetime = $("input#reservetime").val();
		    reservetime = reservetime.split(":").join("");
		    
		    const datetime = reservedate + reservetime;
		    
		 // console.log(datetime);
		 // 202204051120
		    
		    let dataObj;
		 
		    if( reservedate == "" || reservetime == "" ) {
		    	dataObj = {"mobile":"${requestScope.mvo.mobile}", 
		    			   "smsContent":$("textarea#smsContent").val()};
		    }
		    else {
		    	dataObj = {"mobile":"${requestScope.mvo.mobile}", 
		    			   "smsContent":$("textarea#smsContent").val(),
		    			   "datetime":datetime};
		    }
		    
			
		});
		
		///////////////////////////////////////////////////////
		
		
		
	});// end of $(document).ready(function(){})---------------------

	
	// Function Declaration
	function goMemberList() {
		let goBackURL = "${requestScope.goBackURL}";
	
      	goBackURL = goBackURL.replace(/ /gi, "&");
      	
		location.href = "/semi_prj_shoes"+goBackURL;	
	}
	
</script>

<div class="row mx-auto" style="position: relative; margin-top: 100px;">
	 <div class="col-md-3" id="sideinfo" >
		<div style= "text-align: center; padding: 20px; ">
		 <h3>관리자 전용</h3>
		 <p><a href="">상품관리</a></p>
		 <p><a href="">주문관리</a></p>
		 <p><a href="">게시판관리</a></p>
		 <p><a href="">회원관리</a></p>
		</div>
		 
	 </div>
	 
	 <div class="col-md-9" id="maininfo">
		<div id="maincontent" style="padding: 20px; ">

<c:if test="${empty requestScope.mvo}">
	존재하지 않는 회원입니다.<br>
</c:if>

<c:if test="${not empty requestScope.mvo}">
	<c:set var="mobile" value="${requestScope.mvo.mobile}" />
	<c:set var="birthday" value="${requestScope.mvo.birthday}" />
	
	<h3 style="text-align: center; font-weight: bold;"> ${requestScope.mvo.name} 님의 회원정보 </h3>
	<hr style="solid 1px; margin-bottom: 20px;">
	<div id="mvoInfo">
	   <ol>
	   	  <li><span class="myli">아이디 : </span>${requestScope.mvo.userid}</li>
		  <li><span class="myli">회원명 : </span>${requestScope.mvo.name}</li>
		  <li><span class="myli">이메일 : </span>${requestScope.mvo.email}</li>
		  <li><span class="myli">휴대폰 : </span>${fn:substring(mobile, 0, 3)}-${fn:substring(mobile, 3, 7)}-${fn:substring(mobile, 7, 11)}</li>
		  <li><span class="myli">우편번호 : </span>${requestScope.mvo.postcode}</li>
		  <li><span class="myli">주소 : </span>${requestScope.mvo.address}&nbsp;${requestScope.mvo.detailaddress}&nbsp;${requestScope.mvo.extraaddress}</li>
		  <li><span class="myli">성별 : </span><c:choose><c:when test="${requestScope.mvo.gender eq '1'}">남</c:when><c:otherwise>여</c:otherwise></c:choose></li>   
		  <li><span class="myli">생년월일 : </span>${fn:substring(birthday, 0, 4)}.${fn:substring(birthday, 4, 6)}.${fn:substring(birthday, 6, 8)}</li>
		  <li><span class="myli">나이 : </span>${requestScope.mvo.age}세</li>	
		  <li><span class="myli">포인트 : </span><fmt:formatNumber value="${requestScope.mvo.point}" pattern="###,###" /> POINT</li> 
		  <li><span class="myli">가입일자 : </span>${requestScope.mvo.registerday}</li>
	   </ol>
	</div>
	
	
</c:if>

	<hr style="solid 1px; margin-bottom: 20px;">

<div align="right">
	<button style="margin-top: 30px;" type="button" onclick="goMemberList()">회원목록</button>
	&nbsp;&nbsp;
	<button style="margin-top: 30px;" type="button" onclick="javascript:location.href='memberList.shoes'">처음으로</button> 
</div>
</div>
</div>
</div>

 <jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/footer_startingPage.jsp" />
    