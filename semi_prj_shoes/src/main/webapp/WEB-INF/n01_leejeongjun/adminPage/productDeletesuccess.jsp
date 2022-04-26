<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script type="text/javascript">

	window.onload = function(){
		 
		alert("제품 삭제 성공!");
		
		location.href="<%= ctxPath%>/adminproduct.shoes";
		
	};// end of window.onload = function()-----------------------------

</script>

</body>
</html>