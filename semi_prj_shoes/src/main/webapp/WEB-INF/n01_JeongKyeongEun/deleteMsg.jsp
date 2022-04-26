<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	alert("${requestScope.message}");
	
	opener.location.href = "${requestScope.loc}";
	
	self.close();	// 메세지 삭제 후 팝업창 닫기
</script>
</html>