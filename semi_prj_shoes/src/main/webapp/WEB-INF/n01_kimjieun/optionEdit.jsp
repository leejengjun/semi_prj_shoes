<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%
	String ctxPath = request.getContextPath();
    //     /MyMVC
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>:::옵션수정:::</title>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>

<style type="text/css">
</style>

<script type="text/javascript">

	//수정하기
	function goOptionEdit() {
	   
	   const frm = document.optionFrm;
	   frm.method = "POST";
	   frm.action = "<%= ctxPath%>/product/optionEditEnd.shoes";
	   frm.submit();

</script>

</head>
<body>

<div align="center">
	
	<form name="optionFrm">
	<div id="head" align="center">
			::: 옵션수정 (<span style="font-size: 10pt; font-style: italic;"><span class="star">*</span>표시는 필수입력사항</span>) :::
		</div>
		<table id="tblMemberUpdate">
			<tr>
				<td>
					<select id="color" name="color" style="margin: 4px; padding: 4px;">
						<option value="red">red</option>
						<option value="navy">navy</option>
						<option value="black">black</option>
						<option value="white">white</option>
						<option value="green">green</option>
						<option value="brown">brown</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					<select id="size" name="size" style="margin: 4px; padding: 4px;">
						<option value="230">230</option>
						<option value="240">240</option>
						<option value="250">250</option>
						<option value="260">260</option>
						<option value="270">270</option>
						<option value="280">280</option>
						<option value="290">290</option>
						<option value="300">300</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<button type="button" class="btn btn-secondary btn-sm mt-3" id="btnUpdate"  onClick="goOptionEdit();"><span style="font-size: 15pt;">확인</span></button>
					<button type="button" class="btn btn-secondary btn-sm mt-3 ml-5" onClick="self.close()"><span style="font-size: 15pt;">취소</span></button>
				</td>
			</tr>
		</table>
		</form>

</div>

</body>
</html>