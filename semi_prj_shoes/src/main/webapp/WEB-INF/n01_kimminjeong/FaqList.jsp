<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
    String ctxPath = request.getContextPath();
    //    /semi_prj_shoes
%>

<!-- CSS -->

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/kimminjeong/board.css" />

<jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/header_startingPage.jsp" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<script type="text/javascript">
jQuery(function($){
    // 자주묻는질문(FAQs)
    var article = $('.faq>.faqBody>.article');
    article.addClass('hide');
    article.find('.a').hide();
    article.eq(0).removeClass('hide');
    article.eq(0).find('.a').show();
    $('.faq>.faqBody>.article>.q>a').click(function(){
        var myArticle = $(this).parents('.article:first');
        if(myArticle.hasClass('hide')){
            article.addClass('hide').removeClass('show');
            article.find('.a').slideUp(100);
            myArticle.removeClass('hide').addClass('show');
            myArticle.find('.a').slideDown(100);
        } else {
            myArticle.removeClass('show').addClass('hide');
            myArticle.find('.a').slideUp(100);
        }
        return false;
    });
    
/*     $('.faq>.faqHeader>.showAll').click(function(){
        var hidden = $('.faq>.faqBody>.article.hide').length;
        if(hidden > 0){
            article.removeClass('hide').addClass('show');
            article.find('.a').slideDown(100);
        } else {
            article.removeClass('show').addClass('hide');
            article.find('.a').slideUp(100);
        }
    }); */

    $(document).on("load")
    $('#tab1').on("click", e => {
    	$('#website').show();
    	$('#product').hide();
    	$('#personal').hide();
    	$('#order').hide();			
    });
    $('#tab2').on("click", e => {			
    	$('#website').hide();
    	$('#product').show();
    	$('#personal').hide();
    	$('#order').hide();
    });
    $('#tab3').on("click", e => {
    	$('#website').hide();
    	$('#product').hide();
    	$('#personal').show();
    	$('#order').hide();
    });
    $('#tab4').on("click", e => {
    	$('#website').hide();
    	$('#product').hide();
    	$('#personal').hide();
    	$('#order').show();
    });	

});

</script>
   <div class="container col-md-12">
   <h2 style="text-align: center; margin-top: 50px"><font size="5" color="gray">자주묻는질문(FAQs)</font></h2>
	<div class="terms">
		<div class="tabArea" style="margin-top: 50px;">
			<div class="tabBtn clearfix">
				<div class="tab" id="tab1">
						<p class="tab-link">웹사이트</p>
				</div>
				<div class="tab" id="tab2">
						<p class="tab-link">주문/결제</p>
				</div>
				<div class="tab" id="tab3">
					<p class="tab-link">취소/교환/반품</p>
				</div>
				<div class="tab" id="tab4">
					<p class="tab-link">상품/배송</p>
				</div>
			</div>		

				<hr />
				<%-- 게시글 리스트 출력부분 시작 --%>
						<%-- 웹사이트 --%>				
						<div class="tabCont" id="website">
							<div class="faq">
							    <div class="faqHeader"></div>
							    <ul class="faqBody">
							    <c:forEach var="fvo" items="${requestScope.fvoList}">
							        <li class="article" id="a1">
							            <p class="q"><a href="#a1">${fvo.faq_question}</a></p>
							            <p class="a">${fvo.faq_answer}</p><br />
							        </li>
							    </c:forEach>    
							    </ul>
							</div>							
						</div><!-- tabContent -->
						<%-- 주문/결제 --%>
						<div class="tabContent" id="product" style="display:none;">
							<div class="faq">
							    <div class="faqHeader"></div>
							    <ul class="faqBody">
							        <li class="article" id="a1">
							            <p class="q"><a href="#a1">Q. 주문 내역은 어디서 확인하나요? </a></p>
							            <p class="a">  주문 내역은 "주문내역 확인"페이지에서 확인하실 수 있습니다.<br>
										주문 번호, 주문시 기재한 이메일, 주소 등의 정보를 입력하세요.<br>
										주문이 되면 송장 번호와 주문 내역서가 이메일로 발송됩니다.<br>
										CJ 대한통운 택배 사이트 내 배송조회 사이트(https://www.doortodoor.co.kr/parcel/pa_004.jsp) 에서 송장번호를 기입하시면 더욱 자세한 확인이 가능합니다.<br></p>
							        <br>
							        </li>
							        <li class="article" id="a2">
							            <p class="q"><a href="#a2">Q. 해외 계좌로 지불해도 되나요?</a></p>
							            <p class="a">  해외카드나 해외 결제 서비스가 제공되지 않습니다. 번거로우시겠지만 국내 결제수단을 통해 구매 바랍니다.<br></p>
							        <br>
							        </li>
							         <li class="article" id="a3">
							            <p class="q"><a href="#a3">Q. 가능한 결제 방식에는 어떤 것이 있나요?</a></p>
							            <p class="a"> 간편 결제는 네이버페이, 카카오페이, 스마일페이, 케이페이, 토스, 페이코 서비스가 제공되며
										신용카드, 실시간 계좌이체도 가능합니다.<br> 
										단, 실시간 계좌이체는 PC로만 가능하며 현재 무통장 입금 서비스는 제공되지 않습니다.<br></p>
							        <br>
							        </li>   
							     </ul>   
							</div>
						</div>
						<%-- 취소/교환/반품 --%>
						<div class="tabContent" id="personal" style="display:none;">
							<div class="faq">
							    <div class="faqHeader"></div>
							    <ul class="faqBody">
						        <li class="article" id="a1">
							            <p class="q"><a href="#a1">Q. 환불 시 배송비는 어떻게 되나요?</a></p>
							            <p class="a">상품의 불량 또는 오배송의 사유로 반품 시 배송비는 무료 입니다.<br>
										그러나 단순 변심의 사유로 반품 시 배송비는 총결제금액에서 5,000원 자동 차감 됩니다.<br>
										단, 부분 반품의 경우 환불금액을 차감 후 남아았는 결제금액이 5만원 이상인 경우 배송비는 2,500원 차감 됩니다.<br></p>
							        <br>
							        </li>
							        <li class="article" id="a2">
							            <p class="q"><a href="#a2">Q. 교환 받은 상품이 불량, 오배송 되었을 경우 어떻게 하나요?</a></p>
							            <p class="a">  불량, 오배송의 경우 컨버스에서 배송비를 부담하여 교환 처리를 해드립니다.<br> 
										기존에 교환 신청을 했던 상품도 배송 완료 후 7일 이내에 다시 교환 신청이 가능하니, 동일한 절차로 진행 부탁드립니다.<br></p>
							        <br>
							        </li>
							        <li class="article" id="a3">
							            <p class="q"><a href="#a3">Q. 교환 발송은 언제 되나요?</a></p>
							            <p class="a">  반품 제품이 컨버스 입고 후 검수 완료 시 교환요청 제품 품절이 아닐 경우 출고 가능하며 기간은 영업일 기준 4~7일 정도 소요될 수 있습니다.<br> 
										출고 시 카카오톡 알림톡으로 안내될 예정입니다.<br></p>
							        <br>
							        </li>
							     </ul>   								        
							</div>						
						 </div>
						<%-- 상품/배송 --%>
						<div class="tabContent" id="order" style="display:none;">
							<div class="faq">
							    <div class="faqHeader"></div>
							    <ul class="faqBody">
							        <li class="article" id="a1">
							            <p class="q"><a href="#a1">Q. 배송은 보통 얼마나 걸리나요?</a></p>
							            <p class="a">  주문 후 입금 완료되는 시점부터 상품 준비에 들어가게 되며, 공휴일 및 주말은 상품 출고 준비일에서 제외됩니다.<br>
										보통의 경우 결제 완료일 기준 3일 내 배송 완료되나 주문 폭주 등으로 인해 출고가 지연되는 경우가 있으며 이 경우 공지를 통해 고객님께 안내드립니다.<br></p>										
							        <br>
							        </li>
							        <li class="article" id="a2">
							            <p class="q"><a href="#a2">Q. 국제 배송도 되나요?</a></p>
							            <p class="a">  국제 배송은 지원되지 않습니다. 컨버스가 진출한 국가의 해당 온라인 몰이나 컨버스와 파트너십을 맺은 해외 업체를 통해 구매하실 수 있습니다.<br>
										지원 가능한 국가가 한정적인 점 양해 부탁드립니다.<br></p>										
						    	    <br>
						    	    </li>
							        <li class="article" id="a3">
							            <p class="q"><a href="#a3">Q. 배송 내역은 어떻게 확인하나요?</a></p>
							            <p class="a">  5만원 이상 구매 시 무료배송됩니다. (단, 프로모션 기간 중에는 구매고객 상관없이 무료배송이 진행되니 회원가입하셔서 가장 빠르게 이벤트 소식을 만나보세요.)<br></p>										
							        <br>
							        </li>
							        <li class="article" id="a4">
							            <p class="q"><a href="#a4">Q. 왜 저에게 맞는 사이즈가 없나요?</a></p>
							            <p class="a"> 고객님의 사이즈에 맞는 스니커즈가 모두 판매되어 재고가 없을 경우 사이즈가 표기되지 않을 수 있습니다.<br></p>										
						    	    <br>
						    	    </li>						    	    
					    	    </ul> 
							</div>
						</div>
					</div>
				</div>
			</div><!-- div.container  끝 -->

		<%-- 게시글 리스트 출력부분 끝 --%>

	
<jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/footer_startingPage.jsp" />