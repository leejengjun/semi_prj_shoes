<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
	//     /semi_prj_shoes
%>
    
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/kimjieun/buyPage.css" />

<jsp:include page="../n01_leejeongjun/starting_page/header_startingPage.jsp" />
<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">



	$(document).ready(function(){

		 $("span.b_error").hide();
		 $("#direct_hide").hide();
		 $("#direct_hide1").hide();
		
		
		//const odrcode = sessionStorage.getItem("odrcode");

		//console.log(odrcode);

		const odrcode = sessionStorage.getItem("odrcode");
	  //  alert("주문코드 확인용 : " + odrcode); 
	    
		$.ajax({
				url:"<%= request.getContextPath()%>/buypageJSON.shoes",
				type:"POST",
				data:{"odrcode":odrcode},
				dataType:"JSON",	  
				success:function(json){
					console.log(json);
					
					let html = "";
				     
				     if(json.length > 0) {
				    	// 데이터가 존재하는 경우 
						$.each(json, function(index, item){ 
							html += "<div id='title'>주문상품</div>"
										+"<div class='contents row my-auto'>"
										+"<div id='thumbnail' class='prdDescription col-md-4 my-auto' ><img src='./images/kimjieun/product_img/"+item.pimage+"' style='width: 100%'/></div>"
										+"<div id='prd' class='prdDescription col-md-8 my-auto'>"
										+"<a href='<%= ctxPath%>/productDetail.shoes?pnum="+item.pimage+"' class='prdName' style='color:black; margin-left: -1px; margin-right: -5px;'>"+item.pname+"</a>"
										+"<ul style='list-style-type: none'>"
										+"<li class='option' style='list-style-type: none; float:left; margin-left: 3px;'>"+item.psize+"mm</li>"
										+"<li style='list-style-type: none; float:left; margin-left: 5px; margin-right: 5px;'>"+item.oqty+"개</li>"
										+ "<li class='price'>"+(item.saleprice).toLocaleString('en')+" 원</span>"
										+"</ul>"
										+"<input type='hidden' class='odrcode' value='"+item.odrcode+"' />"
										+"</div>"
										+"</div>"
										+"</div>"
									+"<div class='totalPrice'>"
										+"<table>"
										+"<colgroup>"
										+"<col style='width:60%'/>"
										+"<col style='width:40%'/>"
										+"</colgroup>"
										+"<tbody id='tprice'>"
										+"<tr class='totalprdprice'>"
										+"<th>결제금액</th>"
										+"<td><li class='price' style='list-style-type: none;'>"+(item.odrtotalprice).toLocaleString('en')+" 원</span></td>"
										+"</tr>"
										+"</tbody>"
										+"</table>"
									+"</div>";
						});// end of $.each(json, function(index, item){})-------------------
				    	
						
						$("div#summ").append(html);
				     
			     }
			  
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});           
		
		if(odrcode != null){
			$("input#odrcode").val(odrcode);
		}
		if(odrcode != ""){
			$("input#odrcode").val(odrcode);
		}
		 
		 
		 // blur 처리 및 오류 메시지 
		 $("input#bname").blur(()=>{
			 
			 const $target = $(event.target);
			 
			 const name = $target.val().trim();
			 
			 if(name == ""){
				// 입력하지 않거나 공백만 입력했을 경우
				  $("table#customer_form :input").prop("disabled", true);
				  $target.prop("disabled", false);
				  $target.parent().find(".b_error").show();
				  $target.focus();
			 }
			 else{
				  $("table#customer_form :input").prop("disabled", false);
				  $target.parent().find(".b_error").hide();
			 }
		 });
		 
		 
		// 휴대번호 정규화 및 blur, 오류처리 
		$("input#bphone2").blur(()=>{
			 
			 const $target = $(event.target);
			 
			 const regExp = new RegExp(/^[1-9][0-9]{3}$/g);
			 const bool = regExp.test($target.val());
			 
			 if(!bool){
				  // 국번이 정규표현식에 위배된 경우 
				  $("table#customer_form :input").prop("disabled", true);
				  $target.prop("disabled", false);
				  $target.parent().find(".b_error").show();
				  $target.focus();
			 }
			 else{
				  $("table#customer_form :input").prop("disabled", false);
				  $target.parent().find(".b_error").hide();
			 }
		 });
		
		$("input#bphone").blur(()=>{
			 
			 const $target = $(event.target);
			 
			 const regExp = new RegExp(/^\d{4}$/g);
			 const bool = regExp.test($target.val());
			 
			 if(!bool){
				  // 국번이 정규표현식에 위배된 경우 
				  $("table#customer_form :input").prop("disabled", true);
				  $target.prop("disabled", false);
				  $target.parent().find(".b_error").show();
				  $target.focus();
			 }
			 else{
				  $("table#customer_form :input").prop("disabled", false);
				  $target.parent().find(".b_error").hide();
			 }
		 });
		
		
			
		$("input#bmail2").blur(()=>{
			 
			 const $target = $(event.target);
			 
			 const email = $target.val().trim();
			 
			 if(email == ""){
				// 입력하지 않거나 공백만 입력했을 경우
				  $("table#customer_form :input").prop("disabled", true);
				  $target.prop("disabled", false);
				  $target.parent().find(".b_error").show();
				  $target.focus();
			 }
			 else{
				  $("table#customer_form :input").prop("disabled", false);
				  $target.parent().find(".b_error").hide();
			 }
		 });
		
		// 직접 입력란 나타내기. 
		
		$("select#bmail2").bind("change", function(){
			if($("#bmail2").val() == "direct"){
				$("#direct_hide").show();
			}
			else{
				$("#direct_hide").hide();
			}
		});
		
		$("select#msg").bind("change", function(){
			if($("#msg").val() == "direct"){
				$("#direct_hide1").show();
			}
			else{
				$("#direct_hide1").hide();
			}
		});
		
		
		// 로그인한 회원 기존 주소 기입 
		
		$("input#sameaddr").click(function(){
			// 체크여부
			var bool = $(this).is(":checked");
			
			if(bool){
				$("input#gname").val("${sessionScope.loginuser.name}");
				$("input#postcode").val("${sessionScope.loginuser.postcode}");
				$("input#address").val("${sessionScope.loginuser.address}");
				$("input#bdetailaddr").val("${sessionScope.loginuser.detailaddress}");
				$("input#extraAddress").val("${sessionScope.loginuser.extraaddress}");	
			}
		});
		
		$("input#newaddr").click(function(){
			// 체크여부
			var bool = $(this).is(":checked");
			
			if(bool){
				$("input#gname").val("");
				$("input#postcode").val("");
				$("input#address").val("");
				$("input#bdetailaddr").val("");
				$("input#extraAddress").val("");	
			}
		});
		
		
		// 우편번호 팝업
		$("img#zipcodeSearch").click(function(){
			  new daum.Postcode({
		            oncomplete: function(data) {
		                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

		                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                let addr = ''; // 주소 변수
		                let extraAddr = ''; // 참고항목 변수

		                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                    addr = data.roadAddress;
		                } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                    addr = data.jibunAddress;
		                }

		                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		                if(data.userSelectedType === 'R'){
		                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있고, 공동주택일 경우 추가한다.
		                    if(data.buildingName !== '' && data.apartment === 'Y'){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                    if(extraAddr !== ''){
		                        extraAddr = ' (' + extraAddr + ')';
		                    }
		                    // 조합된 참고항목을 해당 필드에 넣는다.
		                    document.getElementById("extraAddress").value = extraAddr;
		                
		                } else {
		                    document.getElementById("extraAddress").value = '';
		                }

		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('postcode').value = data.zonecode;
		                document.getElementById("address").value = addr;
		                // 커서를 상세주소 필드로 이동한다.
		                document.getElementById("bdetailaddr").focus();
		            }
		        }).open();
		  });
		
		             
	
		
		
	}); // end of $(document).ready(function(){})-----------------------------------

	
	
	
	// 결제하기
	  function goPay(coinmoney) {
		  
		  // *** 필수입력 사항에 모두 입력이 되었는지 검사한다. *** //
		  let b_FlagRequiredInfo = false;
		  
		  $("input.requiredInfo").each(function(index, item){
			  const data = $(item).val().trim();
			  if(data == "") {
				  alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
				  b_FlagRequiredInfo = true;
				  return false;  // for 문에서 break; 와 같은 기능이다.
			  }
		  });
		  
		  if(b_FlagRequiredInfo) {
			  return; // 종료 
		  } 
		  
		  
		  // *** 이용약관에 동의했는지 검사한다. *** //
		  const agreeCheckedLength = $("input:checkbox[id='agree']:checked").length;
		  
		  if(agreeCheckedLength == 0) {
			  alert("이용약관에 동의하셔야 합니다.");
			  return; // 종료
		  }
		  
		  
		<%--  
		  $.ajax({
				url:"<%= request.getContextPath()%>/orderupdate.shoes",
				type:"POST",
				data:{"odrcode":odrcode},
				dataType:"JSON",
				success:function(json){
					if(json.n == 1) { 
					   location.href = "paysucess.shoes"; 
					}
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
		  --%>
		  
		  const userid = "${sessionScope.loginuser.userid}";
			
		  const url = "<%= request.getContextPath()%>/product/productPay.shoes?userid="+userid+"&coinmoney="+coinmoney;
			
			window.open(url,"coinPurchaseEnd",
						"left=350px, top=100px, width=1000px, height=600px;");
			
			const frm = document.orderFrm;
			  frm.action = "orderupdate.shoes";
			  frm.method = "post";
			  frm.submit();
		  
	}
	
	
	
</script>



<form name="orderFrm">
	<%-- 주문자 정보 폼 --%>
	<div id="ordertitle" class="col-md-8" style="margin-top:80px;">주문결제</div>
	<div class="row justify-content-around">
	<div id="orderLeft" class="col-md-7 order_form">
				
		<div class="orderFrmAll">
			<!-- 주문자정보 -->
			<div class="base">
				<div>
					<div id="title">주문고객</div>
					<span id="pm-icon" style="display:none;"></span>
				</div>
				<div class="customerInfo">
					<table id="customer_form">
						<colgroup>
							<col style="width:24%;">
							<col style="width:76%;">
						</colgroup>
					<tbody>
						<tr>
							<th>주문자 <span class="star">*</span></th>
							<td>
								<input id="bname" name="bname" class="requiredInfo" placeholder="" size="15" value="${sessionScope.loginuser.name}" type="text"><br/>
								<span class="b_error">성명은 필수입력 사항입니다.</span>
							</td>
						</tr>
		
						<tr>
							<th>휴대전화 <span class="star">*</span></th>
							<td class="cellInfo">
								<select id="bphone1" name="bphone1" class="requiredInfo" style="padding: 4px;">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select>
								-<input type="text" id="bphone2" name="bphone2" class="requiredInfo" value="${ fn:substring(sessionScope.loginuser.mobile, 3, 7) }" maxlength="4" size="4"/>
								-<input type="text" id="bphone3" name="bphone3" class="requiredInfo" value="${ fn:substring(sessionScope.loginuser.mobile, 7, 11) }" maxlength="4" size="4"/><br/>
								<span class="b_error">휴대폰은 필수입력 사항입니다.</span>
							</td>
						</tr>
						<tr>
							<th>이메일 <span class="star">*</span></th>
							<td>
								<div class="emailInfo">
									<input type="text" id="bemail1" name="bmail1" class="requiredInfo" value="${ fn:substringBefore(sessionScope.loginuser.email, '@') }"/>
									@
									<span class="mailAdress">
										<select id="bmail2" name="bmail2">
											<option value="" selected="selected"  class="requiredInfo" style="margin: 4px; padding: 4px;"> 이메일 선택 </option>
											<option value="naver.com">naver.com</option>
											<option value="daum.net">daum.net</option>
											<option value="nate.com">nate.com</option>
											<option value="yahoo.com">yahoo.com</option>
											<option value="gmail.com">gmail.com</option>
											<option value="direct">직접입력</option>
										</select>
										<span><input type="text" id="direct_hide" name="bmail2" value="" style="margin: 4px 0; padding: 4px;" placeholder="직접입력"/></span><br/>
										<span class="b_error">이메일은 필수입력 사항입니다.</span>
									</span>
								</div>
								<p class="emailmsg">이메일로 주문 처리 과정을 보내드립니다. <br> 수신 가능한 이메일 주소를 입력해 주세요.</p>
							</td>
						</tr>
						</tbody>
					</table>
				
				</div>
	
	
	
	
	<hr style="width:98%; align: center; color: gray ">					
	
	
	<%-- 배송지 정보 --%>				
	<div>
		<div id="title">배송지 정보</div>
	</div>
	<div class="row">
		<div id="newsamecheck">
			<input type="radio" id="sameaddr" name="addr" value="" />
			<label for="sameaddr">주문자 정보와 동일</label>
		</div>
		<div id="newsamecheck">
			<input type="radio" checked="checked" id="newaddr" name="addr" value="" />
			<label for="newaddr">새로운 배송지</label>
		</div>
	</div>
	<div class="deliveryInfo">
		<table id="delivery_form">
			<colgroup>
				<col style="width:24%;">
				<col style="width:76%;">
			</colgroup>
		<tbody>
			<tr>
				<th>받는사람 <span class="star">*</span></th>
				<td><input id="gname" name="gname" class="requiredInfo" placeholder="" size="15" value="" type="text"><br/>
					<span class="b_error">필수입력 사항입니다.</span></td>
			</tr>	
			<tr>
				<th>주소 <span class="star">*</span></th>
				<td>
					<ul>
						<li class="displaynone">
							<input type="text" id="postcode" class="requiredInfo" size="5" placeholder="우편번호" />
							&nbsp;&nbsp;
				   			<img id="zipcodeSearch" src="./images/kimjieun/b_zipcode.gif" style="vertical-align: middle;" />
						</li>
						<li id="buy_addr" class="displaynone">
							<input type="text" id="address" name="address" class="requiredInfo" size="40" placeholder="주소" />
						</li>
						<li id="buy_detailAddr" class="displaynone">
							<input type="text" id="bdetailaddr" name="bdetailaddr" class="requiredInfo" size="40" placeholder="상세주소" />
							&nbsp;<input type="text" id="extraAddress" name="extraAddress" class="requiredInfo" style="margin: 4px 0;" size="40" placeholder="참고항목" /> 
						</li>
						
					</ul>
					<span class="b_error" style="margin: 0px; padding: 0px;">필수입력 사항입니다.</span>
				</td>
			</tr>
			<tr>
				<th>휴대전화 <span class="star">*</span></th>
				<td class="cellInfo">
					<select id="bphone21" name="bphone21" class="requiredInfo" style="margin: 4px; padding: 4px;">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
						<option value="018">018</option>
						<option value="019">019</option>
					</select>
					-<input type="text" id="bphone22" name="bphone22" class="requiredInfo" maxlength="4" size="4"/>
					-<input type="text" id="bphone23" name="bphone23" class="requiredInfo" maxlength="4" size="4"/><br>
					 <select id="msg2" name="msg2" style="margin: 4px; padding: 4px;">
					    <option value="m0" selected="selected">메시지 선택(선택사항)</option>
					    <option value="m1">부재시 경비실에 맡겨주세요.</option>
					    <option value="m2">부재시 전화 주시거나 문자 남겨 주세요.</option>
					    <option value="m3">부재 시 문 앞에 놓아주세요.</option>
					    <option value="direct">직접입력</option>
	    			</select>
					<span><input type="text" id="direct_hide1" name="msg2" value="" style="margin: 4px; padding: 4px;" placeholder="직접입력"/></span>
					<br/>
					<span class="b_error">필수입력 사항입니다.</span>
				</td>
			</tr>
		</tbody>	
		</table>
	</div>			
		
	
	
	<hr style="width:98%; align: center; color: black ">					
	<%-- 약관 동의 --%>
	<table>
		<tr>
			<td colspan="2">
				<label for="agree">이용약관에 동의합니다</label>&nbsp;&nbsp;<input type="checkbox" id="agree" />
			</td>
		</tr>
	</table>
	<table>
		<tr>
			<td colspan="4" style="text-align: center; vertical-align: middle; width: 1500px;">
				<iframe src="../iframeAgree/buyagree.html" width="100%" height="150px" class="box" ></iframe>
			</td>
		</tr>
	</table>
	<table style="margin: auto;">
		<tr>
			<td colspan="3" style="line-height: 90px;" class="text-center">
				<%-- 
				<button type="button" id="btnRegister" style="background-image:url('/MyMVC/images/join.png'); border:none; width: 135px; height: 34px; margin-left: 30%;" onClick="goRegister();"></button> 
				--%>
				<button type="button" style="align:center;" id="btnRegister" class="btn btn-secondary btn-lg btn-block" onclick="goPay()">결제하기</button> 
			</td>
		</tr>
	</table>
		
		
	</div>
	</div>
</div>
	<div id="orderRight" class="col-md-4 order_form">
	<div id="summ"></div>
	
	<%--	<div id="title">주문상품</div>
		<div class="contents row my-auto">
	 	<c:if test="${not empty requestScope.odrList}">
			<c:forEach var="ovo" items="${requestScope.odrList}" varStatus="status">
				<div id="thumbnail" class="prdDescription col-md-4 my-auto" ><img src="./images/kimjieun/product_img/${ovo.prod.pimage}" style="width: 100%"/></div>
					<div id="prd" class="prdDescription col-md-8 my-auto">
						<a href="<%= ctxPath%>/productDetail.shoes?pnum=${ovo.prod.pnum}" class="prdName" style="color:black; margin-left: -1px; margin-right: -5px;">${ovo.prod.pname}</a>
		 				<ul style="list-style-type: none">
							<li class="option" style="list-style-type: none; float:left; margin-left: 3px;">${ovo.prod.psize}mm</li>
							<li style="list-style-type: none; float:left; margin-left: 5px; margin-right: 5px;">${ovo.cart.oqty}개</li>
							<li class="price"><fmt:formatNumber value="${ovo.prod.saleprice}" pattern="###,###" />원</li>
						</ul>
						<input type="text" class="odrcode" id="odrcode" value="" />
					</div>
				
					
				</c:forEach>
			</c:if>
			
		
		<div class="totalPrice">
			<table>
				<colgroup>
					<col style="width:50%"/>
					<col style="width:50%"/>
				</colgroup>
				<tbody id="tprice">
					<tr class="totalprdprice">
						<th>결제금액</th>
						<td><span style="margin-left: 20px;"><fmt:formatNumber value="${requestScope.resultMap.odrtotalprice}" pattern="###,###" /></span> 원  </td> 
					</tr>
				</tbody>
			</table>
		</div>--%>
		<div class="infobox">
			<button class="sideaccordion" id="title">이용안내</button>
				<div id="b_box">
		 			<ul style="list-style-type: none">
						<li>실 결제 금액은 주문서 내 고객님의 쿠폰/할인 적용에 따라 달라집니다.</li>
						<li>실제 쿠폰코드의 적용여부는 금액에서 확인하여 주세요.</li>
						<li>적용되지 않는 쿠폰은 등록은 되나 금액은 변동되지 않습니다.</li>
						<li>프로모션 제품은 중복할인 또는 쿠폰 사용이 불가합니다.</li>
					</ul>
				</div>
		</div>
		<div class="infobox">
			<button class="sideaccordion" id="title">배송비 안내</button>
				<div id="b_box">
		 			<ul style="list-style-type: none">
						<li>총 구매금액이 5만원 이상인 경우,배송비는 무료입니다. (5만원 미만인 경우,배송비 2,500원이 별도 부가됩니다.)</li>
						<li>장기간 장바구니에 보관하신 상품은 시간이 지남에 따라 가격과 혜택이 변동 될 수 있으며, 최대 30일 동안 보관됩니다.</li>
					</ul>
				</div>
		</div>
	
	</div>
</div>
</form>






<jsp:include page="../n01_leejeongjun/starting_page/footer_startingPage.jsp"/>



<script>

var acc = document.getElementsByClassName("sideaccordion");
var i;

for (i = 0; i < acc.length; i++) {
  acc[i].addEventListener("click", function() {
    this.classList.toggle("sideactive");
    var panel = this.nextElementSibling;
    if (panel.style.maxHeight) {
      panel.style.maxHeight = null;
    } else {
      panel.style.maxHeight = panel.scrollHeight + "px";
    } 
  });
}

</script>

