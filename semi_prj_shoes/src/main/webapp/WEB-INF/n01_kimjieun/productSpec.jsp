<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
	//     /semi_prj_shoes
%>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/kimjieun/allProduct.css" />
<jsp:include page="../n01_leejeongjun/starting_page/header_startingPage.jsp" />
<jsp:include page="./sidebar.jsp" />



<script type="text/javascript">

	const len = 8;
	// HIT 상품 "스크롤" 할때 보여줄 상품의 개수(단위)크기
	
	let start = 1;
	
	$(document).ready(function(){
		
		$("span#totalHITCount").hide();
		$("span#countHIT").hide();
	
	    // HIT상품 게시물을 더보기 위하여 "스크롤" 이벤트에 대한 초기값 호출하기 
		// 즉, 맨처음에는 "스크롤" 을 하지 않더라도 한 것 처럼 8개의 HIT상품을 게시해주어야 한다는 말이다.
	    displayHIT(start);
	    
	    const web_browser_height = $(window).height();
	
	    // ==== 스크롤 이벤트 발생시키기 시작 ==== //
	    $(window).scroll(function(){
	    	
	    	
	    	// 스크롤탑의 위치값
	   // 	console.log("$(window).scrollTop() => "+ $(window).scrollTop());
	    	
	    	// 보여주어야 할 문서의 높이값 (더보기를 해주므로 append 되어져서 높이가 계속 증가될 것이다.)
	   // 	console.log("$(document).height() => "+ $(document).height());

	    	// 웹브라우저창의 높이값()
	   // 	console.log("$(window).height() => "+ $(window).height());
	    	// 또는
	   // 	console.log("web_browser_height => "+ web_browser_height);

	    	// 아래는 이벤트가 발생되는 숫자를 만들기 위해서 스크롤탑의 위치값에 +1을 더해서 보정해준 것이다.
	    //	console.log("$(window).scrollTop() +1 => "+ ( $(window).scrollTop() + 1 ));
	    //	console.log("$(document).height() -  $(window).height() => "+ ( $(document).height() -  $(window).height()) );
	    	// 또는
	    //	console.log("$(document).height() -  web_browser_height => "+ ( $(document).height() -  web_browser_height) );
	    	
	    //	if($(window).scrollTop() + 1 >= $(document).height() - $(window).height()) {}
	    	// 또는
	    	if($(window).scrollTop() + 1 >= $(document).height() - web_browser_height) {
	    		
		    	//	alert("확인용 : 새로이 8개 제품을 더 보여줌");
		    		const totalHITCount = $("span#totalHITCount").text();
		    		const countHIT = $("span#countHIT").text();
		    		
		    		if(totalHITCount != countHIT){
		    			start = start + len;
		    			displayHIT(start);
		    		}	
		    	}
		    	
		    	if($(window).scrollTop() == 0){
		    		// 다시 처음부터 시작하도록 한다.
		    		$("div#displayHIT").empty();
		    		$("span#end").empty();
		    		$("span#countHIT").text("0");
		    		
		    		start = 1;
	    			displayHIT(start);
		    	}
		    	
		    });
		    
	    
	    
	    // ==== 스크롤 이벤트 발생시키기 끝 ==== //
	    
	});// end of $(document).ready(function(){})------------------------

	
// Function Declaration
	
	
	// 해당 카테고리 상품 보여주기 (Ajax 로 처리)
	function displayHIT(start){
		$.ajax({
			url:request.getContextPath()+"/AllSpecViewJSON.shoes",
			//	type:"GET",
				data:{"sname":"${requestScope.paraMap.sname}"
					 ,"start":start   // "1"  "9"  "17"  "25"  "33"
					 ,"len":len},  //  8    8    8     8     8
				dataType:"JSON",
				success:function(json) {
					let html ="";
					
					if(start == "1" && json.length == 0) {
				    	// 처음부터 데이터가 존재하지 않는 경우  
				    	html += "현재 상품 준비중....";
				    	
				    	// 상품 결과를 출력하기
				    	$("div#displayHIT").html(html);
				     }
				     
				     else if(json.length > 0) {
				    	// 데이터가 존재하는 경우
				    	
				    	$.each(json, function(index, item){
				    		
				    		html += 

					      	 " <div class='productlist'> "+
							    "<div>"+
							    	"<img src='./images/kimjieun/product_img/${pvo.pimage}' class='card-img-top' id='prddetailgo' alt='신발' style='width: 100%; cursor: pointer; ' />"+
							   " </div>"+
							    "<div class='card-body' id='prdcard'>"+
								    "<input type='text' class='pnum' id='pnum' name='pnum' value='${pvo.pnum}' />"+
								    "<p class='card-text' id='prddetailgo' style='cursor: pointer;'>${pvo.pname}</p>"+
								   " <p class='card-text'>${pvo.price}</p>"+
							    "</div>"+
							  "</div>"+
							"</div> ";
				    	
				    		});
				    	
				    	
				    	$("div#displayHIT").append(html);
				    	
				    	$("span#countHIT").text( Number($("span#countHIT").text()) + json.length );
				    	
				    	// 스크롤을 계속해서 클릭하여 countHIT 값과 totalHITCount 값이 일치하는 경우 
				    	if( $("span#countHIT").text() == $("span#totalHITCount").text() ) {
				    		$("span#end").html("더이상 조회할 제품이 없습니다.");
				    	}
				    }
				    	
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}		
				}
		})
	}// end of function displayHIT(start)-------------------------------
	
</script>

	<%-- === HIT 상품을 모두 가져와서 디스플레이(마우스 스크롤 방식으로 페이징 처리한 것) === --%>
	<div>
		<div class="container col-md-9">	
		  <form name="productFrm" action="allproduct.shoes" method="get"> 
			<div style="width: 100%; margin: 0 auto;">
			   <div class="row justify-content-end prdcheck">
					<div class = "col-md-2" id="soldoutcheck" align="right" style="padding: 10px">
						<span class="buttons">
							<input type="checkbox" name="soldout" id="soldout" value="">
							<label for="soldout" id="soldout">품절 상품 제외&nbsp;&nbsp;</label>
						</span>
					</div>
					<div class="col-md-2">
						<select id="optionType" name="optionType" style="margin: 4px; padding: 4px;">
								<option value="none" selected="selected">선택</option>
								<option value="lowprice">낮은가격순</option>
								<option value="highprice">높은가격가격순</option>
						</select>
					</div>
				</div>
			<div class="row" style="margin-top: 20px; margin-bottom: 100px;">  	
		      <div class="col-sm-6 col-lg-3 mb-3">	
	    
	   				 <div class="row" id="displayHIT"></div> 
			     </div>
		  	  </div>
		 	</form>   
		</div>  
	    
	    <div>
	        <p class="text-center">
	           <span id="end" style="font-size: 14pt; font-weight: bold; color: red;"></span> 
	           <span id="totalCount">${requestScope.totalCount}</span>
	           <span id="count">0</span>
	        </p>
	    </div>
	</div>

<jsp:include page="../n01_leejeongjun/starting_page/footer_startingPage.jsp"/>







    