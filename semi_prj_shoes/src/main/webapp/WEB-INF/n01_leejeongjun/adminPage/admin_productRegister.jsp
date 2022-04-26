<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>    

<jsp:include page="../starting_page/header_startingPage.jsp"/>

<style type="text/css">
   table#tblProdInput {border: solid gray 1px; 
                       border-collapse: collapse; }
                       
    table#tblProdInput td {border: solid gray 1px; 
                          padding-left: 10px;
                          height: 50px; }
                          
    .prodInputName {background-color: white; 
                    font-weight: bold; }                                                 
   
   .error {color: red; font-weight: bold; font-size: 9pt;}
   
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("span.error").hide();
		
		// 제품수량에 스피너 달아주기
		$("input#spinnerPqty").spinner({
			spin:function(event,ui){
	            if(ui.value > 100) {
	               $(this).spinner("value", 100);
	               return false;
	            }
	            else if(ui.value < 1) {
	               $(this).spinner("value", 1);
	               return false;
	            }
	         }
		});	// end of $("input#spinnerPqty").spinner(--------------
		
		
		//추가이미지파일에 스피너 달아주기 
		$("input#spinnerImgQty").spinner({
			spin:function(event,ui){
	            if(ui.value > 10) {
	               $(this).spinner("value", 10);
	               return false;
	            }
	            else if(ui.value < 0) {
	               $(this).spinner("value", 0);
	               return false;
	            }
	         }
		});	// end of $("input#spinnerImgQty").spinner(----------
		
		
		// #### 스피너의 이벤트는 click 도 아니고, change 도 아니고, "spinstop" 이다. #### //
		$("input#spinnerImgQty").bind("spinstop", function(){	// 화살표 함수는 $(this) 먹지 않는다.(오류발생)
			
			let html = "";
			const cnt = $(this).val();
		/*	
			console.log("확인용 cnt : "+cnt);
			console.log("확인용 typeof cnt : "+typeof cnt);
			// 확인용 typeof cnt : string
		*/
			for(let i=0; i<parseInt(cnt); i++){
				html += "<br>";
				html += "<input type='file' name='attach"+i+"' class='btn btn-default' />";
			}// end of for------------------------------------------------------------------
			
			$("div#divfileattach").html(html);
			$("input#attachCount").val(cnt);
		});//end of $("input#spinnerImgQty").bind("spinstop", function()----------
		
				
		// 제품등록하기
		$("input#btnRegister").click(function(){
			
			let flag = false;
			
			$(".infoData").each(function(index, item){
				const val = $(item).val().trim();
				if(val == ""){
					$(item).next().show();
					flag = true;
					return false;
				}
			});// end of $(".infoData").each(function(index, item)-----------------
			
			if(!flag) {
				var frm = document.prodInputFrm;
				frm.submit();
			}		
					
		});// end of $("input#btnRegister").click(function()--------------------
				
				
		// 제품등록취소하기
		$("input[type='reset']").click(function(){
			$("span.error").hide();
			$("div#divfileattach").empty();
		});//end of $("input[type='reset']").click(function()--------------
				
	});// end of $(document).ready(function()-----------------------

</script>

<div align="center" style="margin-bottom: 20px;">

<div style="border: solid gray 2px; width: 250px; margin-top: 20px; padding-top: 10px; padding-bottom: 10px; border-left: hidden; border-right: hidden;">       
   <span style="font-size: 15pt; font-weight: bold;">제품등록&nbsp;[관리자전용]</span>   
</div>
<br/>

<%-- !!!!! ==== 중요 ==== !!!!! --%>
<%-- 폼에서 파일을 업로드 하려면 반드시 method 는 POST 이어야 하고 
     enctype="multipart/form-data" 으로 지정해주어야 한다.!! --%>
<form name="prodInputFrm"
	  action="<%= request.getContextPath()%>/admin/productRegister.shoes"
	  method="POST"
	  enctype="multipart/form-data" > 
      
	<table id="tblProdInput" style="">
	<tbody>
	   <tr>
	      <td width="25%" class="prodInputName" style="padding-top: 10px;">카테고리</td>
	      <td width="75%" align="left" style="padding-top: 10px;" >
	         <select name="fk_cnum" class="infoData">
	            <option value="">:::선택하세요:::</option>
	            <c:forEach var="map" items="${requestScope.categoryList }">
	            	<option value="${map.cnum}">${map.cname}</option>
	            </c:forEach>
	         </select>
	         <span class="error">필수입력</span>
	      </td>   
	   </tr>
	   <tr>
	      <td width="25%" class="prodInputName">제품명</td>
	      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;" >
	         <input type="text" style="width: 300px;" name="pname" class="box infoData" />
	         <span class="error">필수입력</span>
	      </td>
	   </tr>
	   <tr>
	      <td width="25%" class="prodInputName">제조사</td>
	      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
	         <input type="text" style="width: 300px;" name="pcompany" class="box infoData" />
	         <span class="error">필수입력</span>
	      </td>
	   </tr>
	   <tr>
	      <td width="25%" class="prodInputName">제품대표이미지</td>
	      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
	         <input type="file" name="pimage" class="infoData" /><span class="error">필수입력</span>
	      </td>
	   </tr>
	   <tr>
	      <td width="25%" class="prodInputName">제품설명서 파일첨부(선택)</td>
	      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
	         <input type="file" name="prdmanualFile" />
	      </td>
	   </tr>
	   <tr>
	      <td width="25%" class="prodInputName">제품수량</td>
	      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
	              <input id="spinnerPqty" name="pqty" value="1" style="width: 30px; height: 20px;"> 개
	         <span class="error">필수입력</span>
	      </td>
	   </tr>
	   <tr>
	      <td width="25%" class="prodInputName">제품정가</td>
	      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
	         <input type="text" style="width: 100px;" name="price" class="box infoData" /> 원
	         <span class="error">필수입력</span>
	      </td>
	   </tr>
	   <tr>
	      <td width="25%" class="prodInputName">제품판매가</td>
	      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
	         <input type="text" style="width: 100px;" name="saleprice" class="box infoData" /> 원
	         <span class="error">필수입력</span>
	      </td>
	   </tr>
	   <tr>
	      <td width="25%" class="prodInputName">제품스펙</td>
	      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
	         <select name="fk_snum" class="infoData">
	            <option value="">:::선택하세요:::</option>
	            <%-- 
	               <option value="1">HIT</option>
	               <option value="2">NEW</option>
	               <option value="3">BEST</option>
	            --%>
	            <c:forEach var="spvo" items="${requestScope.specList}">
	            	<option value="${spvo.snum}">${spvo.sname}</option>
	            </c:forEach>
	         </select>
	         <span class="error">필수입력</span>
	      </td>
	   </tr>
	   <tr>
	      <td width="25%" class="prodInputName">제품상세설명</td>
	      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
	         <textarea name="pcontent" rows="5" cols="60"></textarea>
	      </td>
	   </tr>
	   <tr>
	      <td width="25%" class="prodInputName">제품요약설명</td>
	      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
	          <textarea name="summary_pcontent" rows="3" cols="60"></textarea>
	      </td>
	   </tr>
	   <tr>
	      <td width="25%" class="prodInputName">제품사이즈</td>
	      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
	         <input type="text" style="width: 100px;" name="psize" class="box infoData" /> 예시 : 280
	         <span class="error">필수입력</span>
	      </td>
	   </tr>
	   <tr>
	      <td width="25%" class="prodInputName" style="padding-bottom: 10px;">제품포인트</td>
	      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden; padding-bottom: 10px;">
	         <input type="text" style="width: 100px;" name="point" class="box infoData" /> POINT
	         <span class="error">필수입력</span>
	      </td>
	   </tr>
	   
	   <%-- ==== 첨부파일 타입 추가하기 ==== --%>
	    <tr>
	          <td width="25%" class="prodInputName" style="padding-bottom: 10px;">추가이미지파일(선택)</td>
	          <td>
	             <label for="spinnerImgQty">파일갯수 : </label>
	          <input id="spinnerImgQty" value="0" style="width: 30px; height: 20px;">
	             <div id="divfileattach"></div>
	              
	             <input type="hidden" name="attachCount" id="attachCount" />
	          </td>
	    </tr>
	   
	   <tr style="height: 70px;">
	      <td colspan="2" align="center" style="border-left: hidden; border-bottom: hidden; border-right: hidden;">
	          <input type="button" class="btn btn-outline-primary" value="제품등록" id="btnRegister" /> 
	          &nbsp;
	          <input type="reset" class="btn btn-outline-danger" value="취소"  style="width: 80px;" />   
	          <button style="margin-left: 10px;" type="button" class="btn btn-outline-success" onclick="javascript:location.href='<%= ctxPath%>/admin/productList.shoes'">제품목록[처음으로]</button> 
	      </td>
	   </tr>
	</tbody>
	</table>
</form>
</div>

<jsp:include page="../starting_page/footer_startingPage.jsp"/>