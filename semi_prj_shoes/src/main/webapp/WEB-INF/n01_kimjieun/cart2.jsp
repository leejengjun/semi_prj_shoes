<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
	//     /semi_prj_shoes
%>
    
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/kimjieun/cart.css" />

<jsp:include page="../n01_leejeongjun/starting_page/header_startingPage.jsp" />
<style type="text/css" >

     
  /* CSS 로딩 구현 시작 (bootstrap 에서 가져옴) */   
   .loader {
	  border: 16px solid #f3f3f3;
	  border-radius: 50%;
	  border-top: 16px solid black;
	  width: 120px;
	  height: 120px;
	  -webkit-animation: spin 2s linear infinite; /* Safari */
	  animation: spin 2s linear infinite;
	}
	
	/* Safari */
	@-webkit-keyframes spin {
	  0% { -webkit-transform: rotate(0deg); }
	  100% { -webkit-transform: rotate(360deg); }
	}
	
	@keyframes spin {
	  0% { transform: rotate(0deg); }
	  100% { transform: rotate(360deg); }
	}
	
	/* CSS 로딩 구현 끝 (bootstrap 에서 가져옴) */  
	
</style>

<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

	$(document).ready(function (){
		
		$(".loader").hide(); // CSS 로딩화면 감추기
		
		$(".spinner").spinner({
			spin: function(event, ui) {
				const $target = $(event.target);
				
				if(ui.value > 100) {
					$target.spinner("value", 100);
					return false;
				}
				else if(ui.value < 0) {
					$target.spinner("value", 0);
					return false;
				}
			}
		});// end of $(".spinner").spinner({});-----------------
		
		// 제품번호의 모든 체크박스가 체크가 되었다가 그 중 하나만 이라도 체크를 해제하면 전체선택 체크박스에도 체크를 해제하도록 한다.
		$(".checkpnum").click( ()=>{
			
			let bFlag = false;
			
			$(".checkpnum").each( (index, item)=>{
				const bChecked = $(item).prop("checked");
				if(!bChecked) {
					$("#allCheckYN").prop("checked",false);
					bFlag = true;
					return false;
				}
			});
			
			if(!bFlag) {
				$("#allCheckYN").prop("checked",true);
			}
			
		});
	
		/////////////////////////////////////////////////////
		
		// 장바구니 비우기
		
		$("span#goCartDelete").click(function(){
			const $target = $(event.target);
			
			const cartno = $target.next().text(); 
			const pname = $target.next().next().text();
			const userid = $target.next().next().next().text();
		
			const bool = confirm(pname+"을 장바구니에서 제거하시는 것이 맞습니까?");
			
			if(bool) {
			   $.ajax({
					   url:"<%= request.getContextPath()%>/product/cartDelete.shoes",
					   type:"POST",
					   data:{"cartno":cartno,
						     "userid":userid},
					   dataType:"JSON",
					   success:function(json){
						  if(json.n == 1) { 
							  location.href="<%= request.getContextPath()%>/cart.shoes"; 
						  }
					   },
					   error: function(request, status, error){
					      alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					   }
				});
			
			}
			else {
				alert("장바구니에서 "+pname+" 제품 삭제를 취소하셨습니다.");
			}
			
		});

		/////////////////////////////////////////////////////
		
		
	}); // end of $(document).ready()--------------------------
		
		
		
		

	// Function Declaration
	
	// == 체크박스 전체선택 / 전체해제 == //
	function allCheckBox(){
		
		const bool = $("#allCheckYN").is(":checked");
		$(".checkpnum").prop("checked", bool);
	}// end of function allCheckBox()-------------------------  
	
	// == 장바구니 수량변경 처리 함수 == //
	function goOqtyEdit(obj, userid) {
		
		const index = $("button.updateBtn").index(obj);
		const cartno = $("input.cartno").eq(index).val();
		const oqty = $("input.oqty").eq(index).val();

		const regExp = /^[0-9]+$/g; // 숫자만 체크하는 정규표현식
		const bool = regExp.test(oqty);
		
		if(!bool) {
			alert("수정하시려는 수량은 0개 이상이어야 합니다.");
			location.href="javascript:history.go(0);";
			return;
		}
	 
		if(oqty == "0") {
			goDel(cartno, userid);
		}
		else {
			$.ajax({
					url:"<%= request.getContextPath()%>/product/optionEdit.shoes",
					type:"POST",
					data:{"cartno":cartno,
						  "oqty":oqty,
						  "userid":userid},
					dataType:"JSON",
					success:function(json){
						if(json.n == 1) {
							alert("주문수량이 변경되었습니다.");	
							location.href = "<%= request.getContextPath()%>/cart.shoes"; 
						}
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
		}
	 
	}// end of function goOqtyEdit(obj)-----------------
	
	
	// === 장바구니에서 제품 주문하기 === // 
	function goOrder() {
	    
		///// == 체크박스의 체크된 갯수(checked 속성이용) == /////
	    const checkCnt = $("input:checkbox[name=pnum]:checked").length;
	    
		if(checkCnt < 1) {
	    	alert("주문하실 제품을 선택하세요!!");
	    	return; // 종료 
	    }
	    
	    else {
	   		//// == 체크박스에서 체크된 value값(checked 속성이용) == ////
	   		///  == 체크가 된 것만 값을 읽어와서 배열에 넣어준다. /// 
		        const allCnt = $("input:checkbox[name=pnum]").length;
	   		
	   			const pnumArr = new Array();
				const oqtyArr = new Array();
				const cartnoArr = new Array();
				const totalPriceArr = new Array();
				const totalPointArr = new Array();
			    
		    	for(let i=0; i<allCnt; i++) {
		    		if( $("input:checkbox[name=pnum]").eq(i).is(":checked") ) {
		    	/*	또는
					if( $("input:checkbox[name=pnum]").eq(i).prop(":checked") ) 
		    		
		      */		pnumArr.push( $("input:checkbox[name=pnum]").eq(i).val() );
						oqtyArr.push( $(".oqty").eq(i).val() );
						cartnoArr.push( $(".cartno").eq(i).val() );
						totalPriceArr.push( $(".totalPrice").eq(i).val() );
						totalPointArr.push( $(".totalPoint").eq(i).val() );
					}
				}// end of for---------------------------
					
				for(let i=0; i<checkCnt; i++) {
					console.log("확인용 제품번호: " + pnumArr[i] + ", 주문량: " + oqtyArr[i] + ", 장바구니번호 : " + cartnoArr[i] + ", 주문금액: " + totalPriceArr[i] + ", 포인트: " + totalPointArr[i]);
				/*
				        확인용 제품번호: 3, 주문량: 3, 장바구니번호 : 14, 주문금액: 30000, 포인트: 15
				        확인용 제품번호: 56, 주문량: 2, 장바구니번호: 13, 주문금액: 2000000, 포인트 : 120 
				        확인용 제품번호: 59, 주문량: 3, 장바구니번호: 11, 주문금액: 30000, 포인트 : 300    
				*/
				}// end of for---------------------------
				
				const pnumjoin = pnumArr.join();                  
				const oqtyjoin = oqtyArr.join();                 
				const cartnojoin = cartnoArr.join();             
				const totalPricejoin = totalPriceArr.join();     

				let sumtotalPrice = 0;
				for(let i=0; i<totalPriceArr.length; i++) {
					sumtotalPrice += parseInt(totalPriceArr[i]);
				}

				let sumtotalPoint = 0;
				for(let i=0; i<totalPointArr.length; i++) {
					sumtotalPoint += parseInt(totalPointArr[i]);
				}
				
				console.log("확인용 pnumjoin : " + pnumjoin);             // 확인용 pnumjoin : 3,56,59
				console.log("확인용 oqtyjoin : " + oqtyjoin);             // 확인용 oqtyjoin : 3,2,3
				console.log("확인용 cartnojoin : " + cartnojoin);         // 확인용 cartnojoin : 14,13,11
				console.log("확인용 totalPricejoin : " + totalPricejoin); // 확인용 totalPricejoin : 30000,2000000,30000
				console.log("확인용 sumtotalPrice : " + sumtotalPrice);   // 확인용 sumtotalPrice : 2060000
				console.log("확인용 sumtotalPoint : " + sumtotalPoint);   // 확인용 sumtotalPoint : 435
				
       
                const str_sumtotalPrice = sumtotalPrice.toLocaleString('en'); // 자바스크립트에서 숫자 3자리마다 콤마 찍어주기  

				const bool = confirm("총주문액 : "+str_sumtotalPrice+"원 결제하시겠습니까?");
					
					if(bool) {
						
						$(".base").hide(); // CSS 로딩화면 감추기
						$(".loader").show(); // CSS 로딩화면 보여주기
						
						
						$.ajax({
							url:"<%= request.getContextPath()%>/product/orderAdd.shoes",
							type:"POST",
							data:{"pnumjoin":pnumjoin,
								  "oqtyjoin":oqtyjoin, 
								  "cartnojoin":cartnojoin,
								  "totalPricejoin":totalPricejoin,
								  "sumtotalPrice":sumtotalPrice,
								  "sumtotalPoint":sumtotalPoint},
							dataType:"JSON",	  
							success:function(json){
								if(json.isSuccess == 1) {
									location.href="<%= request.getContextPath()%>/buypage.shoes";
									sessionStorage.setItem('odrcode',json.odrcode);
								}
								else {
									location.href="<%= request.getContextPath()%>/product/orderError.shoes";
								}
							},
							error: function(request, status, error){
								alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
							}
						});
					}
				}	
		    	
	    }// end of function goOrder()----------------------
		
	
	
	
	
</script>


<div id="container">
	<%-- 주문자 정보 폼 --%>
  <form name="cartFrm">
	<div id="carttitle" class="col-md-8" ><h4>장바구니</h4></div>
	<div class="row justify-content-around">
	<div id="orderLeft" class="col-md-8 order_form">
				
		<div class="cartFrmAll">
			<!-- 주문자정보 -->
<div class="base">
	<c:if test="${empty requestScope.cartList}">
		<div class="row justify-content-center">
			<span id="emptycart">장바구니가 비어있습니다.</span>
		</div>
	</c:if>		
			
	<c:if test="${not empty requestScope.cartList}">  	
		<table class="table table-borderless" style="margin: 0;">
		  <tbody>
		   <tr>
		   	<td style="width:5%;">
		   		<input type="checkbox" id="allCheckYN" onClick="allCheckBox();" checked />
		   	</td>
		   </tr>
			
		<c:forEach var="cvo" items="${requestScope.cartList}" varStatus="status">
		    <tr>
		      <th style="width:5%;"><input type="checkbox" name="pnum" class="checkpnum" id="pnum${status.index}" value="${cvo.pnum}" checked></th>
		      <td style="width:28%;"><img src="./images/kimjieun/product_img/${cvo.prod.pimage}" class="card-img-top" alt="신발" style="width: 90%" /></td>
		      <td>
		      	<div class="row pname" style="margin-top: 10px;"> ${cvo.prod.pname}</div>
		      	<div class="row poption" style="margin-top: 10px;"><fmt:formatNumber value="${cvo.prod.price}" pattern="###,###" /> 원</div>
		      </td>
		      <td style="width:25%;">
		      	<div class="row price" style="margin: 10px 3px;"><fmt:formatNumber value="${cvo.prod.totalPrice}" pattern="###,###" /> 원</div>
		      	<input type="hidden" class="totalPrice" value="${cvo.prod.totalPrice}" />
		      	<input type="hidden" class="totalPoint" value="${cvo.prod.totalPoint}" />
			                   
				<input class="spinner oqty" name="oqty" value="${cvo.oqty}" style="width: 30px; height: 20px; ">
			    <button class="btn btn-outline-secondary btn-sm updateBtn" type="button" onclick="goOqtyEdit(this,'${cvo.userid}')">수정</button>
			    
			    <%-- 장바구니 테이블에서 특정제품의 현재주문수량을 변경하여 적용하려면 먼저 장바구니번호(시퀀스)를 알아야 한다 --%>
			    <input type="hidden" class="cartno" value="${cvo.cartno}" /> 
			    
			    <div class="row" style="margin-top: 10px; margin-left: 3px;">
				    <span id="goCartDelete" style="cursor: pointer;">삭제</span>
				    <span style="display: none;">${cvo.cartno}</span>
				    <span style="display: none;">${cvo.prod.pname}</span>
				    <span style="display: none;">${cvo.userid}</span>
			    </div> 
		      </td>
		    </tr>
 		</c:forEach> 
		  </tbody>
		</table>
		<%-- 결제 버튼 --%>
	
			<div class="row justify-content-end" style="margin: 30px">
			
		<%-- 	<button type="button" id="cartDelete" class="btn btn-secondary" Onclick="goCartDelete();"> 장바구니 비우기 </button>--%>
			</div>
	</c:if>
				
	
	<div style="display: flex">
      <div class="loader" style="margin: auto"></div>
    </div>
	
	
		
	</div>
	</div>
</div>
	
	<%-- 주문상품 요약창 --%>
	<div id="orderRight" class="col-md-3 order_form">
		<div id="title" class="row justify-content-center" style="padding:30px;">주문금액</div>
		<div class="contents row">
			<div id="prd" class="prdDescription" style="width:100%;">
 				<table style="margin: auto;">
				<colgroup>
					<col style="width:50%"/>
					<col style="width:50%"/>
				</colgroup>
				<tbody id="tprice">
					<tr>
						<th>상품금액</th>
						<td><span style="margin-left: 20px;"><fmt:formatNumber value="${requestScope.resultMap.SUMTOTALPRICE}" pattern="###,###" /></span> 원  </td>
					</tr>
					<tr>
						<th>배송비</th>
						<td><span style="margin-left: 20px;"><fmt:formatNumber value="${requestScope.resultMap.DELIVERYPRICE}" pattern="###,###" /></span> 원  </td>
					</tr>
					<tr class="totalprdprice">
						<th>총 결제금액</th>
						<fmt:parseNumber var="SUMTOTALPRICE" value="${requestScope.resultMap.SUMTOTALPRICE}" />
						<fmt:parseNumber var="DELIVERYPRICE" value="${requestScope.resultMap.DELIVERYPRICE}" />
    					<td><span style="margin-left: 20px;"><fmt:formatNumber value="${SUMTOTALPRICE + DELIVERYPRICE}" pattern="###,###" /></span> 원  </td>
					</tr>
				</tbody>
			</table>
				<hr style="width:98%; align: center; color: gray ">					
			<div class="row justify-content-center"><button type="button" class="btn1 btn-dark btn-lg" onclick="goOrder();">주문하기</button></div>
			</div>
		</div>
		<div class="totalPrice">
			
		</div>
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
</div>









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

