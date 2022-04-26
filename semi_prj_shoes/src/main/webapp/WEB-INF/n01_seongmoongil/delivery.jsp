<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
    String ctxPath = request.getContextPath();
    //    /semi_prj_shoes
%>
<script src="https://kit.fontawesome.com/2467f0d6d5.js"></script>


<jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/header_startingPage.jsp" />

<style type="text/css">

p#notice{
	color:red;
}

div.stateSelect{
	    padding: 10px;
    padding-left: 20;
}

a.btnNormal {
	border: solid 1px #f2f2f2;
	color: black;
	font-size: 9pt;
}

span.period {
	margin-right: 10px;
}

span#showOrderList{
    background-color: black;
    color: white;
    padding: 9px;
    margin-left: 5px;
    cursor: pointer;
    border-radius: 5px;
}


button.dateType{
	background-color: #ffffff;
    border: 1px solid #cccccc !important;
    width: 18.6% ;
    height: 34px;
    margin-right: 3px;

}

button.dateType:hover{ 
	box-shadow: 200px 0 0 0 rgba(0,0,0,0.25) inset, -200px 0 0 0 rgba(0,0,0,0.25) inset;
	color:white; 
	}

input.datepicker{
    margin-top: 15;
    width: 43%;
    text-align: center;
    border: 1px solid #cccccc;
    height: 35;
}
#container > div > div > div:nth-child(5) {
    height: 155px;
    margin-top: 25px;
    border: 1px solid #cccccc;
    background-color: #f1f1f1;
    padding-top: 30;
    padding-left: 40;
}

label{
	cursor: pointer;
	font-weight: normal;
}

table.odr_list {

	margin-top: 15;
    border-top: solid 2px #ddd !important;
    border-bottom: solid 1px #ddd !important;	
	
}

table.odr_list > thead {
	background-color: #f2f2f2;
}

img.odr_img {
	width: 100px;
	height: 100px;
}
</style>

<script type="text/javascript">
$(document).ready(function(){
	
	
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear();

	if(dd<10) {
	    dd='0'+dd
	} 

	if(mm<10) {
	    mm='0'+mm
	} 

	today = yyyy+'-'+mm+'-'+dd;
	//console.log(today);
	
	// === 전체 datepicker 옵션 일괄 설정하기 ===  
    //     한번의 설정으로 $("input#fromDate"), $('input#toDate')의 옵션을 모두 설정할 수 있다.
	$(function() {
		// 모든 datepicker에 대한 공통 옵션 설정
		$.datepicker.setDefaults({
			dateFormat: 'yy-mm-dd'		// Input Display Format 변경
			,showOtherMonths: true		// 빈 공간에 현재월의 앞뒤월의 날짜를 표시
			,showMonthAfterYear:true	// 년도 먼저 나오고, 뒤에 월 표시
			,changeYear: true			// 콤보박스에서 년 선택 가능
			,changeMonth: true			// 콤보박스에서 월 선택 가능                
			,showOn: "both"				// button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
			,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" // 버튼 이미지 경로
			,buttonImageOnly: true		// 기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
		//	,buttonText: "선택"			// 버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
			,yearSuffix: "년"			// 달력의 년도 부분 뒤에 붙는 텍스트
			,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] // 달력의 월 부분 텍스트
			,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 달력의 월 부분 Tooltip 텍스트
			,dayNamesMin: ['일','월','화','수','목','금','토'] // 달력의 요일 부분 텍스트
			,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] // 달력의 요일 부분 Tooltip 텍스트
		//	,minDate: "-1M"				// 최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
		//	,maxDate: "+1M"				// 최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
		});

		// input을 datepicker로 선언
		$("input#fromDate").datepicker();                    
		$("input#toDate").datepicker();		
		
		if($('input#hiddendate').val() == today || $('input#hiddendate').val() == ""){
			// From의 초기값을 3개월 전으로 설정
			$('input#fromDate').datepicker('setDate', '-3M'); // (-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
			// To의 초기값을 오늘로 설정
			$('input#toDate').datepicker('setDate', 'today'); // (-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)		
			}
		else{
			// From의 초기값을 3개월 전으로 설정
			$('input#fromDate').datepicker('setDate', $('input#hiddendate').val()); 
			// To의 초기값을 오늘로 설정
			$('input#toDate').datepicker('setDate', $('input#hiddendate2').val()); 
		}
		
	});
	

	
});
	
	// Function Declaration
	function setSearchDate(start){
		var num = start.substring(0,1);
		var str = start.substring(1,2);

		var today = new Date();

		var endDate = $.datepicker.formatDate('yy-mm-dd', today);
		$('#toDate').val(endDate);
		
		if(str == 'd'){
			today.setDate(today.getDate() - num);
		} else if (str == 'w'){
			today.setDate(today.getDate() - (num*7));
		} else if (str == 'm'){
			today.setMonth(today.getMonth() - num);
			today.setDate(today.getDate() + 1);
		}
		
		var startDate = $.datepicker.formatDate('yy-mm-dd', today);
		$('#fromDate').val(startDate);
		
		// 종료일은 시작일 이전 날짜 선택하지 못하도록 비활성화
		$("#toDate").datepicker( "option", "minDate", startDate );
		
		// 시작일은 종료일 이후 날짜 선택하지 못하도록 비활성화
		$("#fromDate").datepicker( "option", "maxDate", endDate );	
	
		
	}

	
	// 날짜별 주문조회하기
	function showOrderListByDate(){
		var frm = document.orderListFrm;
		frm.action = "<%= ctxPath%>/order/orderList.up";
		frm.method = "GET";
		frm.submit();		

	}
</script>


	
	
	<div style="margin-top: 50;">
		<h2 style=" text-align: center; margin-bottom: 50; font-weight: bold;">주문/배송 조회</h2>  
	<p>교환을 원하실 경우 고객센터 또는 1:1문의를 통해 접수해 주세요</p>
	
	<p id="notice">
		* 주문 전 꼭 확인해세요! *
	</p>
	<p id="notice">
		주문 후 빠른 작업 진행으로 직접 주문 취소가 불가한 경우<br>1:1문의 남겨주시면 출고 전 상태의 경우에는 취소처리가 가능합니다.
	</p>
	
	<div class="container">
	

		
	<div class="stateSelect">
		<%-- 조회기간 --%>
		<form name="orderListFrm">			
			<span class="period">

					<button type="button" class="dateType" id="dateType1" onclick="setSearchDate('0d')">오늘</button>	

					<button type="button" class="dateType" id="dateType2" onclick="setSearchDate('1w')">1주일</button>	

					<button type="button" class="dateType" id="dateType3" onclick="setSearchDate('1m')">1개월</button>	

					<button type="button" class="dateType" id="dateType4" onclick="setSearchDate('3m')">3개월</button>	

					<button type="button" class="dateType" id="dateType5" onclick="setSearchDate('6m')">6개월</button>	

			</span>
			<input type="hidden" value="${fromDate}" id="hiddendate"/>
			<input type="hidden" value="${toDate}" id="hiddendate2"/>
			<input type="text" class="datepicker" id="fromDate" name="fromDate" autocomplete="off" > - <input type="text" class="datepicker" id="toDate" name="toDate" autocomplete="off">
			<span id="showOrderList" onclick="showOrderListByDate()">조회</span>
		</form>
	</div>
		
		
		
	</div>
	

	<table class="table odr_list">
		<thead>
			<tr style="text-align: center;">
				<th>주문일자</th>
				<th>이미지</th>
				<th>상품정보</th>
				<th>수량</th>
				<th>상품구매금액</th>
				<th>포인트</th>
				<th>배송상태</th>				
			</tr>
		</thead>
		
		<tbody>		
			<c:if test="${empty requestScope.orderList}">
				<tr>
					<td colspan="8" align="center" class="ordertext">
						주문한 상품이 없습니다.
					</td>
				</tr>
			</c:if>
			
			<c:if test="${not empty requestScope.orderList}">
			
				<c:forEach var="ordervo" items="${requestScope.orderList}" varStatus="status">
				<tr>
					<td> <%-- 주문일자 --%>
						
						<span>${ordervo.ord.orderDate}</span>
					</td>
					<td> <%-- 이미지 --%>
					<a href="<%= ctxPath%>/detailMenu/productDetailPage.up?pnum=${ordervo.fk_pnum}">
						<img src="<%= ctxPath%>/image/product/${ordervo.prod.fk_decode}/${ordervo.prod.pimage1}" width="130px" title="상품 이미지를 클릭하시면 해당상품페이지로 넘어갑니다."/>
					</a>	
					</td>
					<td> <%-- 상품정보 --%>
						<span style="font-weight: bold;">${ordervo.prod.pname}</span><br><br>
						<span>${ordervo.optionContents}</span>
					</td>
					<td> <%-- 수량 --%>
						<span>${ordervo.odAmount}</span>개
					</td>
					<td> <%-- 상품구매금액 --%>	
						<span>
							<fmt:formatNumber value="${ordervo.odPrice}" pattern="###,###" />
							<input class="orderPrice" type="hidden" value="${ordervo.odPrice}" />
						</span> 원
					</td>
					<td> <%-- 포인트 --%>
						<span>
							<fmt:formatNumber value="${ordervo.prod.point}" pattern="###,###" /> 
							</span> POINT
						<input class="orderPoint" type="hidden" value="${ordervo.prod.point}" />
					</td>
					<td> <%-- 배송상태 --%>
						<c:choose>
							<c:when test="${ordervo.deliveryCon eq null}">
								입금확인
							</c:when>
							<c:when test="${ordervo.deliveryCon eq '1'}">
								배송준비중
							</c:when>
							<c:when test="${ordervo.deliveryCon eq '2'}">
								배송중
							</c:when>
							<c:when test="${ordervo.deliveryCon eq '3'}">
								배송완료
							</c:when>						
						</c:choose>
					</td>
				</tr>				
				</c:forEach>
							
			</c:if>
		</tbody>
	</table>
	


	<h2 style="font-weight: bold; margin-top: 50px; margin-bottom: 30px;">주문/배송 진행단계 안내</h2>  

	<div class="container" id="del_notice" style="border: 1px solid #cccccc; padding: 30px;">
		<div id="step">
			<h4>Step 1.입금확인중</h4>
			<p>입금미완료 ~2일 이내에 미입금시, 주문이 취소됩니다.</p>
			<br>
			<h4>Step 2.결제완료</h4>
			<p>입금이 확인되었습니다.</p>
			<br>
			<h4>Step 3.배송준비중</h4>
			<p>업체/택배사에 주문이 전달되었습니다.(2~3일내 도착)</p>
			<br>
			<h4>Step 4.상품배송중</h4>
			<p>상품이 고객님께 배송중입니다.(1~2일내 도착)</p>
			<br>
			<h4>Step 5.배송완료</h4>
			<p>상품이 고객님께 배송 완료되었습니다.</p>
		</div>
	</div>

	<div style="border:none; background-color: white;"></div>
	</div>
		


 <jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/footer_startingPage.jsp" />
