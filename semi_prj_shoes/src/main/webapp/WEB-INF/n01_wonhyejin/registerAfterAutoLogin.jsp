<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
  String ctxPath = request.getContextPath();
//    /semi_prj_shoes
%>    
   
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 후 자동로그인</title>

<script type="text/javascript">

   window.onload = function(){   //문서가 로딩되어지면  이 메소드가 자동적으로 실행 포스트방식으로 
	   
	   alert("회원가입을 축하드립니다!!!");
	   
	   const frm = document.loginFrm;
	   frm.action = "<%= ctxPath%>/n01_wonhyejin/login.shoes";
	   frm.method = "post";
	   frm.submit();
	   
   }// end of window.onload = function()------------  

</script>

</head>
<body>

    <form name="loginFrm">
      <input type="hidden" name="userid" value="${requestScope.userid}"/>
      <input type="hidden" name="pwd" value="${requestScope.pwd}"/>
    </form>
   
</body>
</html>