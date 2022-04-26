<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
    String ctxPath = request.getContextPath();
    //    /semi_prj_shoes
%>

<jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/header_startingPage.jsp" />

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

 <link rel="stylesheet" href="<%= ctxPath%>/css/wonhyejin/style23.css">

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 

<style type="text/css">

  <style type="text/css">
   
	html, body {
	    margin: 0;
	    padding: 0;
	    height: 100%;
	    
	}
	
	#body-wrapper {
	    min-height: 100%;
	    position: relative;
	}
	
	#body-content {
	    margin-top: 100px;
	    padding-bottom: 800.590px; /* footer의 높이 */
	}
	
	footer {
	    width: 100%;
	    height: 800.590px; /* footer의 높이 */
	    position: absolute;  
	    bottom: 0;
	    left: 0;
	}
	/* footer 하단 고정  */
	
  

</style>
<script type="text/javascript"> 
	
	$(document).ready(function(){ 
	
		$("button#btnUpdate").click(function(){
			const pwd = $("input#pwd").val();
			const pwd2 = $("input#pwd2").val();
			
			// const regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;     //정규표현식//
    	    // 또는
			const regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
    	         // 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 비밀번호 정규표현식 객체 생성
    	         
    		const bool = regExp.test(pwd);       ///리턴타입 불린값
    	 
    		   if(!bool) {
    			  // 비밀번호가 정규표현식에 위배된 경우
    			 alert("비밀번호는 8글자 이상 15글자 이하에 영문자,숫자,특수기호만 가능합니다.");
    			  
    			 $("input#pwd").val("");
    			 $("input#pwd2").val("");
    			 return; //종료
    			  
    		    }
    		    else if(bool && pwd != pwd2) {
	    		  	  // 비밀번호가 정규표현식에 위배된 경우
	       			 alert("비밀번호가 일치하지 않습니다.");
	       			  
	       			 $("input#pwd").val("");
	       			 $("input#pwd2").val("");
	       			 return; //종료 
    		   }
    		    else {
    		    	const frm = document.pwdUpdateFrm;
    		    	frm.action = "<%= ctxPath%>/pwdUpdate.shoes";
    		    	frm.method = "post";
    		    	frm.submit();
    		    	
    		    }	   
    	 
		});
		
	});// end of $(document).ready(function()--------------------
			
</script>

  </head>
	<body>
	 <div id="body-wrapper"> 
	 <div id="body-content">
	
	  <div class="memberbox">
         <h2>비밀번호 변경</h2>
            
	   <form name="pwdUpdateFrm">
	
	   <p style="padding:40px 0 40px 0; font-size: 1.3em;">다른 사이트에서 사용하지 않는 보안 수준이<br>
            높은 비밀번호를 설정하는 것이 좋습니다.</p><br>
	
		<div id="div_pwd" align="left">
	      <span style="color: black; font-size: 12pt;">새 비밀번호</span><br/> 
	      <input type="password" name="pwd" id="pwd" placeholder="새 비밀번호를 입력하세요." required />
	   </div>
	   
	   <div id="div_pwd2" align="left">
	      <span style="color: black; font-size: 12pt;">새 비밀번호 확인</span><br/>
	      <input type="password" id="pwd2" placeholder="새 비밀번호를 한번 더 입력하세요." required />
	   </div>
	   
	   <input type="hidden" name="userid" value="${requestScope.userid}">   
	   
	   <c:if test="${requestScope.method == 'GET'}">
	      <div id="div_btnUpdate" align="center" style="position: relative; top: 50px;">
	        <button type="button" class="btn btn-primary btn-sm" id="btnUpdate" >비밀번호 변경</button>
	      </div>
	   </c:if> 
      
       <c:if test="${requestScope.method == 'POST' && requestScope.n == 1}"> 
        <div id="div_updateResult" align="center" style="color:red;">
            ${requestScope.userid}님의 비밀번호가 변경되었습니다.<br/>
       </div>
      </c:if> 
   
     <div class="login_return"><a style="font-size: 1.3em; color:#000066;" href="<%= ctxPath%>/n01_wonhyejin/login.shoes">로그인으로 돌아가기</a></div>
	 </form>
	
    </div>
	   
   </div>

  </div>		
 </body>
</html> 
	
 <jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/footer_startingPage.jsp" />	
	