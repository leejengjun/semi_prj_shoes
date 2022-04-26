<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
    String ctxPath = request.getContextPath();
    //    /semi_prj_shoes
%>
<jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/header_startingPage.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
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
		$("div#div_findResult").show();
		
		$("input#userid").val("${requestScope.userid}"); 
		$("input#email").val("${requestScope.email}");
		
		if(${requestScope.sendMailSuccess == true}) {
		$("div#div_btnFind").hide();  //메일이 정상적으로 왔다면 찾기버튼을 숨긴다. 
		}
		
	}
		
	
// 찾기 
	$("button#btnFind").click(function(){	
		goFind();
		
	});
	
	$("input#email").bind("keydown", function(event){
		if(event.keyCode == 13) {
		goFind();
		
		}
	});
	
	
// 인증하기
	$("button#btnConfirmCode").click(function(){  //인증키는 포스트 방식

		const frm = document.verifyCertificationFrm; 
		frm.userCertificationCode.value = $("input#input_confirmCode").val();   // 사용자가 입력한 값을 넣어준다.
		frm.userid.value = $("input#userid").val();		
		
		frm.action = "<%= ctxPath%>/verifyCertification.shoes";
		frm.method = "post";
		frm.submit();  
	});
	
	
});// end of $(document).ready(function()--------------------
		
  function goFind() {

	  const frm = document.pwdFindFrm;
		frm.action = "<%= ctxPath%>/pwdFind.shoes";
		frm.method = "post";
		frm.submit();
}

//인증코드 발생 후 제한시간안에 인증(연장 가능)
    counter_init();
	var tid;
	var cnt = parseInt(300);  //초기값(초단위)  5분
	
	function counter_init() {   //카운트 실행
		tid = setInterval("counter_run()", 1000);
	}
	
	function counter_reset() {
		clearInterval(tid);
		cnt = parseInt(300);
		counter_init();
	}
	
	function counter_run() { //카운트
	    document.getElementById("counter").innerText = time_format(cnt);
		cnt--;
		if(cnt < 0) {
			alert("인증 요청을 다시 하세요")
			clearInterval(tid);
			location.replace(location.href);   //비밀번호 찾기 화면으로 이동.
	
		}
	}
	
	function time_format(s) {
		var nHour=0;
		var nMin=0;
		var nSec=0;
		if(s>0) {
			nMin = parseInt(s/60);
			nSec = s%60;
	
			if(nMin>60) {
				nHour = parseInt(nMin/60);
				nMin = nMin%60;
			}
		} 
		if(nSec<10) nSec = "0"+nSec;
		if(nMin<10) nMin = "0"+nMin;
	
		return ""+nHour+":"+nMin+":"+nSec;
	}

</script>

	

 </head>
    <body>
     <div id="body-wrapper"> 
     <div id="body-content">
     
       <div class="memberbox">
         <h2>비밀번호 찾기</h2>
            
     <form name="pwdFindFrm"> 
   
    <p style="padding:40px 0 40px 0; font-size: 1.3em;">계정에 연결된 정보를 입력하시면<br>
          비밀번호 찾기가 가능합니다.</p><br>
                     
     <ul style="list-style-type: none">
         <li style="text-align:left;">
            <label for="userid">아이디</label>
            <input type="text" name="userid" id="userid" size="50" placeholder="아이디를 입력해 주세요" autocomplete="off" required />
         </li>
         <li style="text-align:left; margin: 25px 0">
            <label for="email">이메일</label>
            <input type="text" name="email" id="email" size="50" placeholder="이메일을 입력해 주세요" autocomplete="off" required />
         </li>
     </ul>
   <ul>
        <li><a href="<%= ctxPath%>/idfind.shoes">아이디 찾기</a></li>
    </ul>
    
   
   <div class="my-3" id="div_btnFind">
    <p class="text-center">
       <button type="button" class="btn btn-primary btn-sm" id="btnFind" style="position: relative; top: 20px;">찾기</button>
    </p>
   </div>
   
   <div class="my-3" id="div_findResult">   
        <p class="text-center">     
           <c:if test="${requestScope.isUserExist == false}"> 
              <span style="color:red;"> 사용자 정보가 없습니다.</span>
           </c:if>
           
           <c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == true}">
          
              <span style="font-size: 12pt;">이메일 ${requestScope.email}로 인증코드가 발송되었습니다.</span><br>
              <span style="font-size: 12pt;">인증코드를 입력해주세요.</span>&nbsp;&nbsp;
              <span id="counter" style="color: red;"></span>
              <input type="button" value="연장" class="btn-outline-dark" style="width: 18%; height:25px; text-align: center; float: right; border-radius: 8px;" onclick="counter_reset()">
              <input type="text" name="input_confirmCode" id="input_confirmCode" required />
              <br><br>
              <button type="button" class="btn btn-info" id="btnConfirmCode" style="border: solid 1px;">인증하기</button>
            
           </c:if>
           
            <c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == false}"> 
              <span style="color:red;">메일 발송이 실패했습니다. 잠시후 다시 시도해주세요.</span>
           </c:if>
      </p>
   </div>
     <div class="login_return"><a style="font-size: 1.3em; color:#000066;" href="<%= ctxPath%>/n01_wonhyejin/login.shoes">로그인으로 돌아가기</a></div>
     </form> 
   

   </div>
  
   <form name="verifyCertificationFrm">
		   <input type="hidden" name="userCertificationCode">
		   <input type="hidden" name="userid">
   </form> 
  
  
  </div>
	   
</div>

</body>
</html> 

     <jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/footer_startingPage.jsp" />
     



