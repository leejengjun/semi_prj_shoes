<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 
<%
    String ctxPath = request.getContextPath();
    //    /semi_prj_shoes
%>
<jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/header_startingPage.jsp" />

<!DOCTYPE html>

<html lang="ko">
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
 
//로그인처리
   $(document).ready(function(){   
	
	   $("button#btnSubmit").click(function(){ 
		   goLogin();  
       });
	   $("input#loginpw").bind("keydown",function(event){
		   if(event.keyCode == 13) { 
			   goLogin(); 
		   }
	   });
	
//  == localStorage에 저장된 key가 "saveid"인 userid값을 불러와서 input태그 userid에 넣어주기 ==//
	   const loginid = localStorage.getItem('saveid');
	   
	   if(loginid != null) {
		   $("input#loginid").val(loginid);
		   $("input:checkbox[id='saveid']").prop("checked",true);
	   }
	 
   }); // end of $(document).ready(function(){})---------------------------------
	   
	  
//로그인 처리
    function goLogin() {
	   
	  const loginid = $("input#loginid").val().trim();
	  const loginpw = $("input#loginpw").val().trim();
	  
	  if(loginid == "") {
		  alert("아이디를 입력하세요");
		  $("input#loginid").val("");
		  $("input#loginid").focus();
		  return; 
	  }
	  
      if(loginpw == "") {
    	  alert("비밀번호를 입력하세요");
		  $("input#loginpw").val("");
		  $("input#loginpw").focus();
		  return; 
	  }
      
 //아이디 저장   
      if( $("input:checkbox[id='saveid']").prop("checked") ) {
    	 localStorage.setItem('saveid', $("input#loginid").val());
      }
      else {
    	  localStorage.removeItem('saveid');
      }
   
      const frm = document.loginFrm;
      frm.action = "<%= request.getContextPath()%>/n01_wonhyejin/login.shoes";
      frm.method = "post";
      frm.submit();
 
   }// end of function goLogin()------------------------------------------------ 
	   
 
   
</script>
	   
<head>
<meta charset="UTF-8">
<title>로그인창</title>
    
    <link rel="stylesheet" href="<%= ctxPath%>/css/wonhyejin/style23.css">
   
</head>
    <body>
       
     <div id="body-wrapper"> 
     <div id="body-content">
          <div class="memberbox">
            <h2>로그인</h2>
 
            <form name="loginFrm">
             
                <fieldset>
                    <label for="loginid">아이디</label>
                    <input type="text" id="loginid" name="userid" placeholder="아이디를 입력하세요">
                    <label for="loginpw">비밀번호</label>
                    <input type="password" id="loginpw" name="pwd" placeholder="비밀번호를 입력하세요">
	            	 <ul>
                       <li style="float:left;"><a href="<%= ctxPath%>/idfind.shoes">아이디/비밀번호찾기</a></li>
                       <li><a href="<%= ctxPath%>/n01_wonhyejin/memberRegister.shoes">회원가입</a></li>
                     </ul>
                     <div style="text-align:left; position: relative; top:-60px;">
                       <input type="checkbox" id="saveid" name="saveid" style="width:15px; height: 15px; "/><label for="saveid" style="font-size: 14px;">아이디저장</label>
                     </div>
                 
                    <div class="text-center">
	            	<button type="button" id="btnSubmit" class="btn btn-primary btn-sm" style="position: relative; top: 40px;">로그인</button>
                    </div>
                    <div class="member_box_gift" style="line-height:400%; position: relative; top: 150px;">로그인 관련하여 궁금한 사항이 있으신가요?
                    <a href="<%= ctxPath%>/faqList.shoes" style="color:#3366ff">[자주 묻는 질문 바로가기]</a>
			        </div>
                    
				</fieldset>
            </form>

		</div>
	</div>
	 
  </div> 
 </body>
</html>

 <jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/footer_startingPage.jsp" />

