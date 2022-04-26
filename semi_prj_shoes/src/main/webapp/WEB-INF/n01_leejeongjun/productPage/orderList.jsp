<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<%
 	String ctxPath = request.getContextPath();
%>
<jsp:include page="../starting_page/header_startingPage.jsp"/>  

<style type="text/css" >
   table#tblOrderList {width: 95%;
                    /* border: solid gray 1px; */
                       margin-top: 20px;
                       margin-left: 10px;
                       margin-bottom: 20px;}
                      
   table#tblOrderList th {border: solid gray 1px;}
   table#tblOrderList td {border: dotted gray 1px;} 
   
   #sideinfo{   
      border-right: 1px solid #dee2e6;
   }
   
   #sideinfo > div{
       text-align: center;
       line-height: 3;
       padding-top: 50px !important;
   }
   #sideinfo > div > p > a   {
       color: black;
       text-decoration: none;
       font-size: 14pt;
       font-weight: bold;
   }   
   
   #sideinfo > div > h3 {
       font-weight: bold;
   }
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("#btnDeliverStart").click(function(){
			// 배송하기 버튼 클릭시
			
			const chkDeliverStart_length = $("input:checkbox[class='chkDeliverStart custom_input']:checked").length;
			// 배송하기 체크박스에 체크가 되어진 개수
			// class 가 복합으로 이루어진 경우 class='chkDeliverStart custom_input' 와 같이 해야하지 class=chkDeliverStart 으로 하면 안된다.
			
			const chkDeliverEnd_length = $("input:checkbox[class='chkDeliverEnd custom_input']:checked").length;
			// 배송완료 체크박스에 체크가 되어진 개수
			// class 가 복합으로 이루어진 경우 class='chkDeliverEnd custom_input' 와 같이 해야하지 class=chkDeliverStart 으로 하면 안된다.
		
			
			if(chkDeliverStart_length == 0) {
				alert("먼저 하나이상의 배송을 시작할 제품을 선택하셔야 합니다.");
				return; // 종료 
			}
			
			if(chkDeliverEnd_length > 0) {
				alert("배송하기만 선택하셔야 합니다.");
				return; // 종료 
			}
			
			$("input.custom_input").prop("disabled", true); 
			// 배송하기 및 배송완료 관련 모든 input 태그 비활성화 시키기
			
			$("input:checkbox[class='chkDeliverStart custom_input']:checked").prop("disabled", false);
			// 체크되어진 배송하기 체크박스(제품번호값을 가지고 있음)만 활성화 시키기
			
			$("input:checkbox[class='chkDeliverStart custom_input']:checked").next().next().prop("disabled", false);
			// 체크되어진 배송하기의 주문코드(전표)만 활성화 시키기
			
			const frm = document.frmDeliver;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/admin/deliverStart.shoes";
			frm.submit();

		});// end of $("#btnDeliverStart").click()------------------
		
		
		$("#btnDeliverEnd").click(function(){
			// 배송완료 버튼 클릭시
			
			const chkDeliverStart_length = $("input:checkbox[class='chkDeliverStart custom_input']:checked").length;
			// 배송하기 체크박스에 체크가 되어진 개수
			// class 가 복합으로 이루어진 경우 class='chkDeliverStart custom_input' 와 같이 해야하지 class=chkDeliverStart 으로 하면 안된다.
			
			const chkDeliverEnd_length = $("input:checkbox[class='chkDeliverEnd custom_input']:checked").length;
			// 배송완료 체크박스에 체크가 되어진 개수
			// class 가 복합으로 이루어진 경우 class='chkDeliverEnd custom_input' 와 같이 해야하지 class=chkDeliverStart 으로 하면 안된다.
		
			
			if(chkDeliverEnd_length == 0) {
				alert("먼저 하나이상의 배송을 완료할 제품을 선택하셔야 합니다.");
				return; // 종료 
			}
			
			if(chkDeliverStart_length > 0) {
				alert("배송완료만 선택하셔야 합니다.");
				return; // 종료 
			}
			
			$("input.custom_input").prop("disabled", true); 
			// 배송하기 및 배송완료 관련 모든 input 태그 비활성화 시키기
			
			$("input:checkbox[class='chkDeliverEnd custom_input']:checked").prop("disabled", false);
			// 체크되어진 배송완료 체크박스(제품번호값을 가지고 있음)만 활성화 시키기
			
			$("input:checkbox[class='chkDeliverEnd custom_input']:checked").next().next().prop("disabled", false);
			// 체크되어진 배송완료의 주문코드(전표)만 활성화 시키기
			
			const frm = document.frmDeliver;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/admin/deliverEnd.shoes";
			frm.submit();	
			
		});// end of $("#btnDeliverEnd").click()------------------
		
		
	}); // end of $(document).ready()--------------------------
	
	
	// Function Declartion
	
	function allCheckStart() {
		$(".odrcode").prop("disabled", false); // 모든 배송하기 및 배송완료 input 태그 활성화 시키기
		
		const bool = $("#allCheckDeliverStart").is(':checked');
		$(".chkDeliverStart").prop('checked', bool);
	}// end of function allCheckBoxStart()------------
	
	
	function allCheckEnd() {
		$(".odrcode").prop("disabled", false); // 모든 배송하기 및 배송완료 input 태그 활성화 시키기
		
		const bool = $("#allCheckDeliverEnd").is(':checked');
		$(".chkDeliverEnd").prop('checked', bool);
	}// end of function allCheckBoxEnd()-----------
	
	
	function openMember(odrcode){ 
		const url = "<%= ctxPath%>/product/odrcodeOwnerMemberInfo.shoes?odrcode="+odrcode;
		
		// 팝업창 띄우기
		window.open(url, "memberInfo",
				    "width=800px, height=500px, top=50px, left=100px");
	}// end of function openMember(odrcode)-------------
	
</script>

<c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.userid eq 'admin'  }"> <%-- admin 으로 로그인 했으면 --%>
<div class="row mx-auto" style="position: relative; margin-top: 100px;">

	<div class="col-md-3" id="sideinfo" style="position:sticky; height: 400px;  top:200px;">
		<div style= "text-align: center; padding: 20px; ">
		 <h3>관리자 전용</h3>
		 <p><a href="<%= ctxPath%>/admin/productList.shoes">상품관리</a></p>
		 <p><a href="<%= ctxPath%>/orderList.shoes">주문관리</a></p>
		 <p><a href="<%= ctxPath%>/admin/memberList.shoes">회원관리</a></p>
		</div>
		 
	 </div>

	<div class="col-md-9" id="maininfo" align="center">
</c:if>
		
		<div class="container-fluid" style="border: solid 0px red">
			<div class="my-3">
				<c:set var="userid" value="${(sessionScope.loginuser).userid}" />
				
				<c:if test='${userid eq "admin"}'>
					<p class="h4 text-center">&raquo;&nbsp;&nbsp;주문내역 전체목록&nbsp;&nbsp;&laquo;</p>
				</c:if>
				
				<c:if test='${userid ne "admin"}'>
					<p class="h4 text-center">&raquo;&nbsp;&nbsp;${(sessionScope.loginuser).name} 님[ ${userid} ] 주문내역 목록&nbsp;&nbsp;&laquo;</p>	
				</c:if>
			</div>
			
			<div>
				<form name="frmDeliver">
				
					<c:if test='${userid eq "admin"}'>
					<div style="text-align: right; margin-right: 40px;">				
						<input type="checkbox" id="allCheckDeliverStart" onClick="allCheckStart();">&nbsp;<label for="allCheckDeliverStart"><span style="color: green; font-weight: bold; font-size: 9pt;">전체선택(배송하기)</span></label>&nbsp;
						<input type="button" name="btnDeliverStart" id="btnDeliverStart" value="배송하기" class="btn btn-outline-success btn-sm mr-3" />
						
						<input type="checkbox" id="allCheckDeliverEnd" onClick="allCheckEnd();">&nbsp;<label for="allCheckDeliverEnd"><span style="color: red; font-weight: bold; font-size: 9pt;">전체선택(배송완료)</span></label>&nbsp;
						<input type="button" name="btnDeliverEnd" id="btnDeliverEnd" value="배송완료" class="btn btn-outline-primary btn-sm" />
					</div>	
					</c:if>
				
					<table id="tblOrderList" class="table">
							
						<thead class="thead-light">	
						    <tr>
								<th width="13%" style="text-align: center;">주문코드(전표)</th>
								<th width="11%" style="text-align: center;">주문일자</th>
								<th width="40%" style="text-align: center;">제품정보</th> <%-- 제품번호,제품명,제품이미지,판매정가,판매세일가,사이즈,포인트 --%> 
								<th width="8%"  style="text-align: center;">주문수량</th>
								<th width="10%" style="text-align: center;">주문총액</th>   
								<th width="8%"  style="text-align: center;">총포인트</th>
								<th width="10%" style="text-align: center;">배송상태</th>
						    </tr>
					    </thead>
						<c:if test="${empty requestScope.orderList}" > 
						  <tr>
							  <td colspan="7" align="center">
							  <span style="color: red; font-weight: bold;">주문내역이 없습니다.</span>
						  </tr>
						</c:if>
					
						<%-- ============================================ --%>
						<c:if test="${not empty requestScope.orderList}">
							<c:forEach var="odrmap" items="${requestScope.orderList}" varStatus="status">
								<%--
									 varStatus 는 반복문의 상태정보를 알려주는 애트리뷰트이다.
									 status.index : 0 부터 시작한다.
									 status.count : 반복문 횟수를 알려주는 것이다.
								 --%>
								<tr>
									<td align="center"> <%-- 주문코드(전표) 출력하기. 
									      만약에 관리자로 들어와서 주문내역을 볼 경우 해당 주문코드(전표)를 클릭하면 
									      주문코드(전표)를 소유한 회원정보를 조회하도록 한다.  --%>
										<c:if test='${userid eq "admin"}'>
											<a href="#" onClick="javascript:openMember('${odrmap.ODRCODE}');">${odrmap.ODRCODE}</a>
										</c:if>
										
										<c:if test='${userid ne "admin"}'>
											${odrmap.ODRCODE}
										</c:if>
									</td>
									
									<td align="center"> <%-- 주문일자 --%>
										${odrmap.ODRDATE}
									</td>
									
									<td style="cursor:pointer;" onclick="javascript:location.href='<%= ctxPath%>/productDetail.shoes?pnum=${odrmap.FK_PNUM}'">  <%-- === 제품정보 넣기 === --%>
										
										<div style="display: flex; padding-top: 10px; justify-content: space-between;">
										    <%-- flex 아이템들은 width의 기본값은 내용물 만큼 잡히고 height 값들은 동일하게 설정되어 inline 형태로 보여진다.
										         justify-content: space-between; 은 flex 아이템들 사이에 간격을 균일하게 만들어 주는 것이다.
										                 이것이 없으면  flex 아이템들은 간격없이 죽~~붙어서 나오게 된다. 
										    --%>
											<div style="width: 44%;">
											    <img src="<%= ctxPath%>/images/kimjieun/product_img/${odrmap.PIMAGE}" width="100%" />  <%-- 제품이미지1 --%>
											</div>
											<div style="width: 54%;">
											    <ul class="list-unstyled">
											       <li>제품번호 : ${odrmap.FK_PNUM}</li> <%-- 제품번호 --%>
											       <li>제품명 : ${odrmap.PNAME}</li>    <%-- 제품명 --%> 
											       <li>정&nbsp;가 : <span style="text-decoration: line-through;"><fmt:formatNumber value="${odrmap.PRICE}" pattern="###,###" /></span> 원</li>   <%-- 제품개당 판매정가 --%> 
											       <li>판매가 : <span class="text-danger font-weight-bold"><fmt:formatNumber value="${odrmap.SALEPRICE}" pattern="###,###" /></span> 원</li> <%-- 제품개당 판매세일가 --%>
											       <li>사이즈 : ${odrmap.PSIZE}</li>    <%-- 제품사이즈 --%>
											       <li>포인트 : <span class="text-danger font-weight-bold"><fmt:formatNumber value="${odrmap.POINT}" pattern="###,###" /></span> POINT</li>  <%-- 제품개당 포인트 --%>
											    </ul>
										    </div>
									    </div> 
									</td>
									
									<td align="center">    <%-- 수량 --%>
										 ${odrmap.OQTY} 개
									</td>
									
									<td align="center">    <%-- 금액 --%>
									     <c:set var="su" value="${odrmap.OQTY}" />
									     <c:set var="danga" value="${odrmap.SALEPRICE}" />
									     <c:set var="totalmoney" value="${su * danga}" />
									     
										 <fmt:formatNumber value="${totalmoney}" pattern="###,###" /> 원
									</td>
									
									<td align="center">    <%-- 포인트 --%>
									     <c:set var="point" value="${odrmap.POINT}" />
									     <c:set var="totalpoint" value="${su * point}" />
										 <fmt:formatNumber value="${totalpoint}" pattern="###,###" /> P
									</td>
									
									<td align="center"> <%-- 배송상태 --%>
										<c:if test='${userid ne "admin"}'>
											<c:choose>
												<c:when test="${odrmap.DELIVERSTATUS == '주문완료'}">
													주문완료<br/>
												</c:when>
												<c:when test="${odrmap.DELIVERSTATUS == '배송중'}">
													<span style="color: green; font-weight: bold; font-size: 12pt;">배송중</span><br/>
												</c:when>
												<c:when test="${odrmap.DELIVERSTATUS == '배송완료'}">
													<span style="color: red; font-weight: bold; font-size: 12pt;">배송완료</span><br/>
												</c:when>
											</c:choose>
										</c:if>
						
										<c:if test='${userid eq "admin"}'>
											<c:if test="${odrmap.DELIVERSTATUS == '주문완료'}">
												<input type="checkbox" class="chkDeliverStart custom_input" name="pnum" id="chkDeliverStart${status.index}" value="${odrmap.FK_PNUM}">&nbsp;
												<label for="chkDeliverStart${status.index}">배송하기</label> 
										  <%--	<input type="text"   class="odrcodeDeliverStart custom_input" name="odrcode" value="${odrmap.ODRCODE}" /> --%>
											    <input type="hidden" class="odrcodeDeliverStart custom_input" name="odrcode" value="${odrmap.ODRCODE}" />  
											</c:if>
											<br/>
											<c:if test="${odrmap.DELIVERSTATUS == '주문완료' or odrmap.DELIVERSTATUS == '배송중'}">
												<input type="checkbox" class="chkDeliverEnd custom_input" name="pnum" id="chkDeliverEnd${status.index}" value="${odrmap.FK_PNUM}">&nbsp;
												<label for="chkDeliverEnd${status.index}">배송완료</label>
										  <%--  <input type="text"   class="odrcodeDeliverEnd custom_input" name="odrcode" value="${odrmap.ODRCODE}" /> --%> 
											    <input type="hidden" class="odrcodeDeliverEnd custom_input" name="odrcode" value="${odrmap.ODRCODE}" /> 
											</c:if>
										</c:if>
									</td>
								</tr>
							</c:forEach>
							</c:if>
							<%-- ============================================================================ --%>
							
					</table>
				</form>  
			</div> 
			 
			<%-- === 페이지바 === --%>
			<nav class="my-5">
		        <div style='display:flex; width:80%;'>
		    	   <ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
		    	</div>
		    </nav>
		</div>
<c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.userid eq 'admin'  }"> <%-- admin 으로 로그인 했으면 --%>		 
	</div>
 </div>
</c:if> 
<jsp:include page="../starting_page/footer_startingPage.jsp"/>
    