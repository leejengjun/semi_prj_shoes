<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%
    String ctxPath = request.getContextPath();
    //    /semi_prj_shoes
%>

<jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/header_startingPage.jsp" />
     
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
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

<link rel="stylesheet" href="<%= ctxPath%>/css/wonhyejin/style23.css">

<script type="text/javascript"> 
	
	$(document).ready(function(){ 
		
		const method = "${requestScope.method}";  //POST 또는 GET 이므로 "${requestScope.method}"
		
		if( method == "GET") {  // GET이면 폼태그만 보여준다
		     $("div#div_findResult").hide();
		} 
		else if(method == "POST") {
			$("input#name").val("${requestScope.name}");
			$("input#email").val("${requestScope.email}");
		}
		
//찾기		
		$("button#btnFind").click(function(){
			goFind();
		});
		
		$("input#email").bind("keydown", function(event){
			
			if(event.keyCode == 13) {
				goFind();
			}
		});
		
	});// end of $(document).ready(function()--------------------
			
	
    // Function Declration 
      function goFind() {
    	  const frm = document.idFindFrm;
			frm.action = "<%= ctxPath%>/idfind.shoes";
			frm.method = "post";
			frm.submit();
	}
	
</script>
</head>
    <body>
     <div id="body-wrapper"> 
     <div id="body-content">
     
       <div class="memberbox">
            <h2>아이디 찾기</h2>
     
	   <form name="idFindFrm">
   
         <p style="padding:40px 0 40px 0; font-size: 1.3em;">계정에 연결된 정보를 입력하시면<br>
          아이디 찾기가 가능합니다.</p><br>
                     
	     <ul style="list-style-type: none">
	         <li style="text-align:left;">
	            <label for="name">이름</label>
	            <input type="text" name="name" id="name" size="50" placeholder="이름을 입력해 주세요" autocomplete="off" required />
	         </li>
	         <li style="text-align:left; margin: 25px 0">
	            <label for="email">이메일</label>
	            <input type="text" name="email" id="email" size="50" placeholder="이메일을 입력해 주세요" autocomplete="off" required />
	         </li>
	     </ul>
		 <ul>
		    <li><a href="<%= ctxPath%>/pwdFind.shoes">비밀번호 찾기</a></li>
		 </ul>
	    
	     <div class="my-3">
	     <p class="text-center">
	       <button type="button" class="btn btn-primary btn-sm" id="btnFind" style="position: relative; top: 20px;">찾기</button>
	     </p>
	     </div>
	   
	     <div class="my-3" id="div_findResult"> 
	        <p class="text-center">     
	           <span style="color: #006666; font-size: 16pt; font-weight: bold; position: relative; top: 60px;">회원 ID: ${requestScope.userid} </span> 
	      </p>
	     </div>
	   
	     <div class="login_return"><a style="font-size: 1.3em; color:#000066;" href="<%= ctxPath%>/n01_wonhyejin/login.shoes">로그인으로 돌아가기</a></div>
	                    
	   </form>
	
	  </div>
	 </div>	   
    </div>
   </body>
 </html>

 <jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/footer_startingPage.jsp" />

