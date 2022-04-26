<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
	//     /semi_prj_shoes
%>
    

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/kimjieun/allProduct.css" />

<jsp:include page="../n01_leejeongjun/starting_page/header_startingPage.jsp" />

<style>
.sideaccordion {
  background-color: #fff;
  color: #444;
  cursor: pointer;
  padding: 18px;
  width: 100%;
  border: none;
  text-align: left;
  outline: none;
  font-size: 15px;
  transition: 0.4s;
}

.sideactive, .sideaccordion:hover {
  background-color: #fff;
}

.sideaccordion:after {
  content: '\002B';
  color: #777;
  font-weight: bold;
  float: right;
  margin-left: 5px;
}

.sideactive:after {
  content: "\2212";
}

.sidepanel {
  padding: 0 18px;
  background-color: white;
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.2s ease-out;
}

ul> li {
	padding: 5px;
}

table > tbody > tr > td {
	text-align: center;
}


div.bar{
	margin: 48px 0 49px 30px;
}

table#size > tbody > tr > td:hover {
      cursor: pointer;
   }
   
div.sidepanel > ul > li:hover{
	  cursor: pointer;
}

</style>

<script type="text/javascript">

/*	const lenHIT = 8;
	// HIT 상품 "스크롤" 할때 보여줄 상품의 개수(단위)크기
	
	let start = 1;
*/

	$(document).ready(function(){
		
/*		$("span#totalHITCount").hide();
		$("span#countHIT").hide();
	
	    // HIT상품 게시물을 더보기 위하여 "스크롤" 이벤트에 대한 초기값 호출하기 
		// 즉, 맨처음에는 "스크롤" 을 하지 않더라도 한 것 처럼 8개의 HIT상품을 게시해주어야 한다는 말이다.
//	    displayHIT("1");
	    
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
	    		
	    		const totalHITCount = $("span#totalHITCount").text();
	    		const countHIT = $("span#countHIT").text();
	    		
	    		if(totalHITCount != countHIT){
	    			start = start + lenHIT;
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
	    
*/	    
	    // ==== 스크롤 이벤트 발생시키기 끝 ==== //
	    
		
		
		
	
		// 옵션 선택시 변화
		$("select#optionType").bind("change", function(){
			const frm = document.productFrm;
			frm.action = "allproduct.shoes";
			frm.method = "get";
			frm.submit();
		});
		
		
	   // 선택옵션 보이기	
		if("${requestScope.optionType}" != "") { 
			$("select#optionType").val("${requestScope.optionType}");
	    }
		

		// 특정 상품 클릭시 해당 상품 상세정보 보여주기
		$("div.productlist").click(function(){
			const $target = $(event.target);
			const pnum = $target.parent().parent().find(".pnum").val();
		//	alert("확인용 : "+ pnum);
			
		 	location.href="<%= ctxPath%>/productDetail.shoes?pnum="+pnum;
			
		});
		
		// 재고 품절 체크시 상품 변화
		$("input:checkbox[name='soldout']").click(function(){
			const $target = $(event.target);
			
		    const bool = $target.prop("checked");
			// 체크박스에서 체크가 되어진 경우라면 true
			// 체크박스에서 체크가 해제 되어진 경우라면 false
			
			if($("input:checkbox[name='soldout']").prop("checked")){
				$("input:checkbox[name='soldout']").val(1);
			}else{
				$("input:checkbox[name='soldout']").val(0);
			}
			
			
			
		});
		
	});// end of $(document).ready(function()---------------------------
	
			

</script>
<div class="row justify-content-around" id="containerA" style="width: 90%; margin: 50px auto;"> 

	<div class="col-md-2 my-5 pt-3 bar">
		<button class="sideaccordion">카테고리</button>
		<div class="sidepanel">
		 <form name = "cateFrm">
		 	<ul style="list-style-type: none">
		 		<c:if test="${not empty requestScope.categoryList}">
		 				<li id="all"><a href="<%= request.getContextPath()%>/allproduct.shoes" style="color:black;">전체보기</a></li>
			  		<c:forEach var="map" items="${requestScope.categoryList}">
			  			<input type="hidden" value="${map.cnum}" id="cnum">
						<li id="cnum" value="${map.cnum}" ><a href="<%= ctxPath%>/allproduct.shoes?cnum=${map.cnum}" style="color:black;">${map.cname}</a></li>
					</c:forEach>
			    </c:if>
			</ul> 
		 </form>
		</div>
	</div>

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
      	
      	<c:if test="${not empty requestScope.productList}">
      		<c:forEach var="pvo" items="${requestScope.productList}">
      		    <div class="col-sm-6 col-lg-3 mb-3">
		      	  <div class="productlist"> 
				    <div>
				    	<img src="./images/kimjieun/product_img/${pvo.pimage}" class="card-img-top" id="prddetailgo" alt="신발" style="width: 100%; cursor: pointer; " />
				    </div>
				    <div class="card-body" id="prdcard">
					    <input type="hidden" class="pnum" id="pnum" name="pnum" value="${pvo.pnum}" />
					    <p class="card-text" id="prddetailgo" style="cursor: pointer;">${pvo.pname}</p>
					    <p class="card-text">${pvo.price}</p>
				    </div>
				  </div>
				</div> 
      		</c:forEach>
      	</c:if>
      	
      	<c:if test="${empty requestScope.productList}">
      		<span>제품이 없습니다.</span>
      	</c:if>

     </div>
   </div>
 </form>   
</div>  
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
