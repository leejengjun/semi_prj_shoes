<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
	//     /semi_prj_shoes
%>

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

	$(document).ready(function(){
		
		
		$("li#cnum").click(function (){
			const frm = document.cateFrm;
			frm.action = "allproduct.shoes";
			frm.method = "get";
			frm.submit();
		});
		
		$("li#category").val("${requestscope.cateList}");


		
	});
	
	
	
</script>

</head>

<body>
<div class="row justify-content-around" id="containerA" style="width: 90%; margin: 50px auto;"> 

	<div class="col-md-2 my-5 pt-3 bar">
		<button class="sideaccordion">카테고리</button>
		<div class="sidepanel">
		 <form name = "cateFrm">
		 	<ul style="list-style-type: none">
		 		<c:if test="${not empty requestScope.categoryList}">
		 				<li id="all"><a href="<%= request.getContextPath()%>/allproduct.shoes">전체보기</a></li>
			  		<c:forEach var="map" items="${requestScope.categoryList}">
						<li id="cnum" value="${map.cnum}" style="cursor: pointer;">${map.cname}</li>
					</c:forEach>
			    </c:if>
			</ul> 
		 </form>
		</div>
	</div>


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

