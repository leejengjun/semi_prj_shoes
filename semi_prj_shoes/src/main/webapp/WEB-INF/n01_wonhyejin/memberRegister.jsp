<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
    String ctxPath = request.getContextPath();
      //    /semi_prj_shoes
%>
<jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/header_startingPage.jsp" />
     
   <style type="text/css">
   
	html, body {
	    margin: 0;
	    padding: 0;
	    height: 100%;
	    
	}
	
	#body-wrapper {
	    min-height: 100%;
	    position: relative;
	}
	
	#body-content {
	    margin-top: 100px;
	    padding-bottom: 800.590px; /* footer의 높이 */
	}
	
	footer {
	    width: 100%;
	    height: 800.590px; /* footer의 높이 */
	    position: absolute;  
	    bottom: 0;
	    left: 0;
	}
	/* footer 하단 고정  */
	
	table#tblMemberRegister {   
	    border: hidden;
	    margin: 10px;         
	}  
	   
	table#tblMemberRegister #th {
	    height: 40px;
	    text-align: center;
	    background-color: silver;
	    font-size: 14pt;      
	}
	   
	table#tblMemberRegister td {
	    line-height: 30px;
	    padding-top: 8px;
	    padding-bottom: 8px;      
	}
	   
	.star { 
		color: red;
	    font-weight: bold;
	    font-size: 13pt;
	}
	   
	body {     
		font-family: Arial, "MS Trebuchet", sans-serif; 
	    border: solid 0px gray;
	    margin: 10;                 
	    padding: 0;             
	}
	   
	div#container {
		border: solid 0px navy;
		width: 100%;
	}
	
	div#header_1 {
		height: 300px;  
		width: 100%;
	    margin: 30px 0 30px 0; 
	    background-image: url(../images/wonhyejin/jointop.jpg);
	    padding: 20px;
	}
	
	.join_top_txt{
	    color: #fff;
	    text-align: right;
	    width: 80%;
	    height: 260px;
	    margin-top: 50px;
	    font-size: 20px;
	    line-height: 1.6;
	    font-weight: 400;
	    display: block;
	    padding:5px;
	    font-weight: bolder;
	}
	
	.btnSubmit {
	    background: #fff;
	    color: #000;
	    width: 230px;
	    height: 40px;
	    line-height: 40px;
	    font-size: 14px;
	    font-weight: 600;
	    border-radius: 0;
	    padding: 40;
	    cursor: pointer;
	    border: 2px solid #000;
	 } 
 
   </style>
   
   <script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
   <script type="text/javascript">
   
    let b_flagIdDuplicatClick = false;
    //가입하기 버튼 클릭시 '아이디중복확인' 클릭 여부 확인
    
    let b_flagEmailDuplicatClick = false;
    //가입하기 버튼 클릭시 '이메일중복확인' 클릭 여부  확인
 
     $(document).ready(function(){
    	   
    	   $("span.error").hide();
    
    	   
////### 아이디 ###////  	  
    	  
    	  $("input#userid").blur( ()=>{
    		  
       		const $target = $(event.target);
       		const userid = $target.val().trim();
       		if(userid == "") {    
       		      // 입력하지 않거나 공백일 경우
       			  $("table#tblMemberRegister :input").prop("disabled", true);     
       			  $target.prop("disabled", false);
       			
       			  $target.parent().find(".error").show();
       			  
       			  $target.focus();
       		 }
       		 else {
       			  
       			  $("table#tblMemberRegister :input").prop("disabled", false); 
         	      $target.parent().find(".error").hide();
       		  }    		   
       	   }); 
       	    	
       	
////### 비밀번호 ###////  

       	   $("input#pwd").blur( ()=>{
       		  
   		     const $target = $(event.target);
   	         const regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
   	         // 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
   	         
   		     const bool = regExp.test($target.val());   
       	 
       		 if(!bool) {
       			 //정규표현식에 위배된 경우
       			  $("table#tblMemberRegister :input").prop("disabled", true);    
       			  $target.prop("disabled", false);
       			  $target.parent().find(".error").show();
       			  $target.focus();
       		 }
       		 else {
   			      $("table#tblMemberRegister :input").prop("disabled", false); 
       			  $target.parent().find(".error").hide();
       		 }   		   
       	   }); 
        	
           	
////### 비밀번호 확인 ###////

       	   $("input#pwdcheck").blur( ()=>{
       		  
   		     const $target = $(event.target);
   		     const pwd = $("input#pwd").val();
   		     const pwdcheck = $target.val();
       	  
       		 if(pwd != pwdcheck ) {
       			  //비밀번호가 일치 하지 않은 경우
       			  $("table#tblMemberRegister :input").prop("disabled", true);     
       			  $target.prop("disabled", false);    
       			  $("input#pwd").prop("disabled", false);
       		
       			  $target.parent().find(".error").show();
       			  
       		      $("input#pwd").focus();    //비밀번호확인에서 일치하지 않는다면 비밀번호설정으로 돌아간다.
       		 }
       		 else {
       			 
       			  $("table#tblMemberRegister :input").prop("disabled", false); 
       			
         		  $target.parent().find(".error").hide();
       		 }    		   
       	   }); 
        

////### 이름 ###////
   
    	   $("input#name").blur( ()=>{
    		  
    		 const $target = $(event.target);
    		 const name = $target.val().trim();
    		 if(name == "") {
    			  //입력하지 않거나 공백일 경우
    			  $("table#tblMemberRegister :input").prop("disabled", true);  //쓰지 못하도록 함   
    			  $target.prop("disabled", false);
    		
    			  $target.parent().find(".error").show();
    			  
    			  $target.focus();
    		 }
    		 else {
    			    
    			  $("table#tblMemberRegister :input").prop("disabled", false); 
    			
      			  $target.parent().find(".error").hide();
    		 }
    	}); 
    	
   
////### 주소 ###////
    	
      		$("img#zipcodeSearch").click(function(){
      		   new daum.Postcode({
      	            oncomplete: function(data) {
      	               
      	                let addr = ''; // 주소 변수
      	                let extraAddr = ''; // 참고항목 변수

      	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
      	                    addr = data.roadAddress;
      	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
      	                    addr = data.jibunAddress;
      	                }

      	               // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
      	                if(data.userSelectedType === 'R'){
      	                   
      	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
      	                        extraAddr += data.bname;
      	                    }
      	                   // 건물명이 있고, 공동주택일 경우 
      	                    if(data.buildingName !== '' && data.apartment === 'Y'){
      	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
      	                    }
      	                   // 표시할 참고항목이 있을 경우, 괄호까지 추가한다.
      	                    if(extraAddr !== ''){
      	                        extraAddr = ' (' + extraAddr + ')';
      	                    }
      	                  
      	                    document.getElementById("extraAddress").value = extraAddr;
      	                
      	                } else {
      	                    document.getElementById("extraAddress").value = '';
      	                }
      	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
      	                document.getElementById('postcode').value = data.zonecode;
      	                document.getElementById("address").value = addr;
      	              
      	                document.getElementById("detailAddress").focus();
      	            }
      	        }).open();
      		})
      	

////### 연락처 ###////
 
    	
      	   $("input#hp2").blur( ()=>{
      		  
      	    const $target = $(event.target);
      
  	        const regExp = new RegExp(/^[1-9][0-9]{3}$/g);  // 숫자 4자리만 올 수 있도록 검사해주는 정규표현식 객체 생성(첫번째는 숫자 1~9 까지만 가능)
  	     
      		const bool = regExp.test($target.val());       
      	 
      		if(!bool) {  // 국번이 정규표현식에 위배된 경우
      			
      			 $("table#tblMemberRegister :input").prop("disabled", true);     
      			 $target.prop("disabled", false);
      		
      			 $target.parent().find(".error").show();
      			  
      			 $target.focus();
      		}
      		else {
      			 
      			 $("table#tblMemberRegister :input").prop("disabled", false); 
      			 
        		 $target.parent().find(".error").hide();
      		}
      		    		   
      	  }); 
      		
     
      	   $("input#hp3").blur( ()=>{
      		  
      		const $target = $(event.target);
      		
  	        const regExp = new RegExp(/^\d{4}$/g);   
  	       
      		const bool = regExp.test($target.val());    
      	 
      		if(!bool) { //정규표현식에 위배된 경우
      			
      			$("table#tblMemberRegister :input").prop("disabled", true);    
      			$target.prop("disabled", false);
      			  
      			$target.parent().find(".error").show();
      			  
      			$target.focus();
      		}
      		else {
      			
      			$("table#tblMemberRegister :input").prop("disabled", false); 
      			    
        		$target.parent().find(".error").hide();
      	   }
      		    		   
      	  }); 
     
 	
////### 생년월일 ###////  		
	      let mm_html = "";
	    	  for(let i=1; i<=12; i++) {
	    		  if(i<10) {
	    		     mm_html += "<option value ='0"+i+"'>0"+i+"</option>";
	    		  }
	    		  else {
	    			  mm_html += "<option value ='"+i+"'>"+i+"</option>";
	    		  }
	    	  }
	    	  
	    	  $("select#birthmm").html(mm_html);
	    	  
	      let dd_html = "";
	    	  for(let i=1; i<=31; i++) {
	    		  if(i<10) {
	    		     dd_html += "<option value ='0"+i+"'>0"+i+"</option>";
	    		  }
	    		  else {
	    			  dd_html += "<option value ='"+i+"'>"+i+"</option>";
	    		  }
	    	  }
	    	  
	    	  $("select#birthdd").html(dd_html);
      	
	    	  
////### 이메일 ###////
  
      	   $("input#email").blur( ()=>{
      		  
      		 const $target = $(event.target);
      		    
      		 // 이메일 정규표현식 
  	         const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i); 
  	   
      	 	 const bool = regExp.test($target.val());      
      	 
      		 if(!bool) {   // 이메일이 정규표현식에 위배된 경우
      			 
   			   $("table#tblMemberRegister :input").prop("disabled", true);     
   			   $target.prop("disabled", false);
   		
   			   $target.parent().find(".error").show();
   			   $target.parent().find(".emailCheckimg").hide();
   		  	   $target.focus();
      		  }
      		  else {
      			
      		   $("table#tblMemberRegister :input").prop("disabled", false); 
      			
   			   $target.parent().find(".error").hide();
   			   $target.parent().find(".emailCheckimg").show();
      		  }
      		    		   
      	   }); 
        
       
////### 체크박스 전체선택,전체해제 ###////
           const allCheck = document.getElementById("allCheck");
       	   const agree_checkBox_List = document.getElementsByName("agree_box");
       	   
       	   allCheck.addEventListener('click', ()=>{
       		    const bool = allCheck.checked;  // true OR false; 
       		    
       		    for(let agree_checkBox of agree_checkBox_List) {
       		    	agree_checkBox.checked = bool;
       		    }
       	   });
 
     
           for(let agree_checkBox of agree_checkBox_List) {

        	   agree_checkBox.addEventListener('click', ()=>{
                   const bool = agree_checkBox.checked;

                   if(!bool) {  
                         allCheck.checked = false; 
                     }
                   else {
                         let bFlag = false;
                         for(let chkbox of agree_checkBox_List) {
                             if(chkbox.checked) {
                             
                                 bFlag = true;
                             }
                             else {
                               
                                 bFlag = false;
                                 break;
                             }
                         } // end of for--------------------------------
                          
                         if(bFlag) {
                          
                            allCheck.checked = true; 
                         }
                     }
               });
               
           } //end of for--------------------------------------
       
    		 
// ## 아이디중복검사 하기 ## ///
           $("img#idcheck").click( ()=>{
          	 
          	 b_flagIdDuplicatClick = true;
        
             $.ajax({
          		url:"<%= ctxPath%>/member/idDuplicateCheck.shoes",
          		data:{"userid":$("input#userid").val()},  // /member/idDuplicateCheck.shoes 로 데이터 전송
          		type:"post",  
          	    async:true,    // 비동기 처리(기본값)
          	 	success:function(text){
          			
          			const json = JSON.parse(text);
          		
          			if(json.isExist) { 
          			    //입력한 $("input#userid").val() 값이 이미 사용중인 경우
          				$("span#idcheckResult").html($("input#userid").val()+" 은 중복된 ID 이므로 사용불가합니다.").css("color","red");
          				$("input#userid").val("");
          			}
          			else{
          		   	// 입력한 $("input#userid").val() 값이 DB tbl_member 테이블에 존재하지 않는 경우
          				$("span#idcheckResult").html($("input#userid").val()+" 사용가능합니다.").css("color","green");
          			}
          		},
          		 error:function(request, status, error){ // 실패할 경우
          			 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
          		 } 
          		
          	  });
          	
           });  // end of $("img#idcheck").click( ()=>{-----
           
           //아이디값이 변경되면 가입하기 버튼 클릭시 "아이디중복확인"을 클릭 여부 확인을 위한 용도를 초기화 시키기
           $("input#userid").bind("change", ()=>{
          	 b_flagIdDuplicatClick = false;
           });
           
           //이메일값이 변경되면 가입하기 버튼 클릭시 "아이디중복확인"을 클릭 여부 확인을 위한 용도를 초기화 시키기
           $("input#email").bind("change", ()=>{
          	 b_flagEmailDuplicatClick = false;
           });
         
       }); //end of $(document).ready(function() ----------------------------	                     
  
         
       
//## 이메일 중복여부 검사하기 ##//
    function isExistEmailCheck() {
  	  
  	  b_flagEmailDuplicatClick = true;
  	 
    	 $.ajax({
    		url:"<%= ctxPath%>/member/emailDuplicateCheck.shoes",
    		data:{"email":$("input#email").val()},   
    		type:"post",   
    		dataType:"json",   
       
        	async:true,    // 비동기 처리(기본값)            
    		success:function(json){
    			   
    			if(json.isExist) {
    				 //입력한 $("input#email").val() 값이 이미 사용중인 경우
    				$("span#emailCheckResult").html($("input#email").val()+" 은 중복된 email 이므로 사용불가합니다.").css("color","red");
    				$("input#email").val("");
    			}
    			else{
    				// 입력한 $("input#email").val() 값이 DB tbl_member 테이블에 존재하지 않는 경우
    				$("span#emailCheckResult").html($("input#email").val()+" 사용가능합니다.").css("color","green");
    			}
    			
    		},
    		 error:function(request, status, error){  // 실패할 경우
    			 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
    		 } 
    		
    	});
    	
    }
       
       
       
//////////## 가입하기 ##//////////

  function goRegister() {
    	   
    // 필수입력 사항(*) 모두 입력 확인
    	   let b_FlagRequirededInfo = false;
    	   
    	    $("input.requiredInfo").each(function(index, item){
    	    	const data = $(item).val().trim();   
    	    	if(data == "") {
    	    		alert("*표시된 필수입력사항을 모두 입력하세요");
    	    		b_FlagRequirededInfo = true;
    	    		return false;    
    	    	
    	    	}
    	    });
    	   
    	    if(b_FlagRequirededInfo) {
    	    	return;  
    	    }
    	    
    //성별 선택 여부
    	   
    	  const genderCheckedLength = $("input:radio[name='gender']:checked").length;
    	   
    	   if(genderCheckedLength == 0) {
    		   alert("성별을 선택하세요");
    		   return; 
    	   }
    	   
    	   
    //약관 동의 여부
    	   const agreeCheckedLength = $("input:checkbox[id='agree_box1']:checked").length;
    	   
    	   if(agreeCheckedLength == 0) {
    		   alert("필수 이용약관에 동의하세요.");
    		   return; 
    	   }
    	   
    // 아이디 중복확인 여부
    	   
	    	if(!b_flagIdDuplicatClick) {
	    		alert("아이디중복확인 클릭하여 중복 여부를 확인하세요");
	    		return; 
	       }
    	    
    // 이메일 중복확인 했는지
		    if(!b_flagEmailDuplicatClick) {
			   	 alert("이메일중복확인 클릭하여 중복 여부를 확인하세요");
			   	 return; 
		   }
	   	  
   	  const frm = document.registerFrm;
   	  frm.action = "memberRegister.shoes";
   	  frm.method = "post";
   	  frm.submit();
    	   
   } //end of function goRegister()    
         	
   
  </script>
   
  <div id="body-wrapper"> 
     <div id="body-content">
     <div class="row">
		<div id="container">
		   <div id="header_1"> 
		      <div class="join_top_txt"> 
		        <h1>회원가입</h1>
		         <p>지금 회원가입 하시고, 특별한 멤버십 혜택과<br>
		             다양한 회원 전용 상품을 만나보세요.</p>
		      </div>  
		    </div>
		</div>
		   
		    <div class="col-md-7" id="divRegisterFrm"> 
		    
              <form name="registerFrm">
		   
			     <table id="tblMemberRegister">
			       <thead>
			        <tr>
			           <th colspan="2" id="th">회원가입 (<span style="font-size: 10pt; font-style: italic;"><span class="star">*</span>필수입력사항</span>)</th>
			        </tr>
			      </thead>
			      
			      <tbody>
			      <tr>
			         <td style="width: 20%; font-weight: bold;">아이디&nbsp;<span class="star">*</span></td>
			         <td style="width: 80%; text-align: left;">
			             <input type="text" name="userid" id="userid" class="requiredInfo" />&nbsp;&nbsp;
			             <!-- 아이디중복체크 -->
			             <img id="idcheck" src="../images/wonhyejin/hj_id_check.gif" style="vertical-align: middle;" />
			             <span id="idcheckResult"></span>
			             <span class="error"><br>아이디는 필수입력 사항입니다.</span>
			         </td> 
			      </tr>
			       <tr>
			         <td style="width: 20%; font-weight: bold;">비밀번호&nbsp;<span class="star">*</span></td>
			         <td style="width: 80%; text-align: left;"><input type="password" name="pwd" id="pwd" class="requiredInfo" />
			            <span class="error"><br>비밀번호는 8글자 이상 15글자 이하에 영문자,숫자,특수기호만 가능합니다.</span>
			         </td>
			      </tr>
			      <tr>
			         <td style="width: 20%; font-weight: bold;">비밀번호확인&nbsp;<span class="star">*</span></td>
			         <td style="width: 80%; text-align: left;"><input type="password" id="pwdcheck" class="requiredInfo" /> 
			            <span class="error"><br>비밀번호가 일치하지 않습니다.</span>
			         </td>
			      </tr>
			      <tr>
			         <td style="width: 20%; font-weight: bold;">이름&nbsp;<span class="star">*</span></td>
			         <td style="width: 80%; text-align: left;">
			             <input type="text" name="name" id="name" class="requiredInfo" /> 
			            <span class="error"><br>이름은 필수입력 사항입니다.</span>
			         </td>
			      </tr>
			         <tr>
			         <td style="width: 20%; font-weight: bold;">우편번호</td>
			         <td style="width: 80%; text-align: left;">
			            <input type="text" id="postcode" name="postcode" size="6" maxlength="5" />&nbsp;&nbsp;
			            <%-- 우편번호 찾기 --%>
			            <img id="zipcodeSearch" src="../images/wonhyejin/b_zipcode_hj.gif" style="vertical-align: middle;" />
	                 <span class="error"><br>우편번호 형식이 아닙니다.</span>
			         </td>
			      </tr>
			      
			      <tr>
			         <td style="width: 20%; font-weight: bold;">주소</td>
			         <td style="width: 80%; text-align: left;">
			            <input type="text" id="address" name="address" size="40" placeholder="기본주소" /><br/>
			            <input type="text" id="detailAddress" name="detailAddress" size="40" placeholder="기본주소" />&nbsp;<input type="text" id="extraAddress" name="extraAddress" size="40" placeholder="상세주소" /> 
			            <span class="error"><br>주소를 입력하세요</span>
			         </td>
			      </tr>
			      
			     
			      <tr>
			         <td style="width: 20%; font-weight: bold;">연락처</td>
			         <td style="width: 80%; text-align: left;">
			             <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
			             <input type="text" id="hp2" name="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
			             <input type="text" id="hp3" name="hp3" size="6" maxlength="4" />
			             <span class="error"><br>휴대폰 형식이 아닙니다.</span>
			         </td>
			      </tr>
			      <tr>
			         <td style="width: 20%; font-weight: bold;">성별</td>
			         <td style="width: 80%; text-align: left;">
			            <input type="radio" id="male" name="gender" value="1" /><label for="male" style="margin-left: 2%;">남성</label>
			            <input type="radio" id="female" name="gender" value="2" style="margin-left: 10%;" /><label for="female" style="margin-left: 2%;">여성</label>
			         </td>
			      </tr>
			           
			      <tr>
			         <td style="width: 20%; font-weight: bold;">생년월일</td>
			         <td style="width: 80%; text-align: left;">
			            <input type="number" id="birthyyyy" name="birthyyyy" min="1950" max="2050" step="1" value="1995" style="width: 80px;" required />
			            <select id="birthmm" name="birthmm" style="margin-left: 2%; width: 60px; padding: 8px;">
	            </select> 
	            <select id="birthdd" name="birthdd" style="margin-left: 2%; width: 70px; padding: 8px;">
	            </select> 
	         		</td>
	    		  </tr>
			      <tr>
			         <td style="width: 20%; font-weight: bold;">이메일&nbsp;<span class="star">*</span></td>
			         <td style="width: 80%; text-align: left;"><input type="text" name="email" id="email" class="requiredInfo" placeholder="abc@def.com" /> 
			             <span class="error"><br>이메일 형식에 맞지 않습니다.</span>
			             
			             <span class="emailCheckimg" style="display: inline-block; width: 80px; height: 30px; border: solid 1px gray; border-radius: 5px; font-size: 8pt; text-align: center; margin-left: 10px; cursor: pointer;" onclick="isExistEmailCheck();">이메일중복확인</span> 
			             <span id="emailCheckResult"></span>
			           
			         </td>
			      </tr>
			     
			   </tbody>
			  </table>
			 </form>  
		</div>	      
		  
			       <div class="col-md-5" style="padding:60px 0 0 0;"> 
			    	 <table id="tbl2">
			       		<tr>
			       
		                <td class="agree">
		                    <label for="" style="font-weight: bolder;"><input type="checkbox" name="agree_box" id="allCheck" /> 모든 약관 동의</label><br><br>
		                    
		                       아래 모든 약관(필수), 개인정보 수집 및 이용에 대한 동의(필수) 및 광고성 정보수신 동의(선택) 내용을 확인하고 전체 동의합니다.<br><br>
					          - 필수 정보의 수집 및 이용에 관한 동의를 거부하실 수 있으나, <br>다만 이 경우
						        회원 가입 및 관련 서비스 이용은 불가합니다.<br>
						      - 필수 정보의 수집 및 이용에 관한 동의를 거부하실 수 있으나, <br>다만 이 경우 
						        회원 가입 및 관련 서비스 이용은 불가합니다.<br>
						      - 만 14세 미만은 서비스 이용이 불가합니다. <br><br>
		                       
		                     <p style="font-weight: bolder;"> 공식 온라인 스토어 회원 약관에 대한 동의</p>
		                     
		                     <input type="checkbox" name="agree_box" id="agree_box1" /><label for="agree_box1"> (필수) 이용 약관에 대한 동의</label>
		                     <a href="<%= ctxPath%>/agree.shoes" target="_blank">이용약관 보기</a>&nbsp;<br><br>
		                     <p style="font-weight: bolder;"> 광고성 정보 수신 동의</p>
		                     <input type="checkbox" name="agree_box" id="agree_box2" /><label for="agree_box2"> (선택) 이메일 수신 동의</label>&nbsp;<br>
		                     <input type="checkbox" name="agree_box" id="agree_box3" /><label for="agree_box3"> (선택) 문자 수신동의</label>&nbsp;
		                     
		                </td>
		            	</tr>
		          
			             <tr>
				         <td colspan="2" style="line-height: 90px;" class="text-center">
				          
				            <button type="button" id="btnRegister" class="btnSubmit" onclick="goRegister()" style="position: relative; top: 30px;">가입하기</button> 
				         </td>
				      </tr>
			  </table>
		</div>
	</div>
		
	      <img src="../images/wonhyejin/benefit.png" style="display: block;  position: relative; top: 300px; width:100% ">
	 
	      <p style="font-size: 20px; font-weight: bold; text-align : center; position: relative; bottom: 100px;"> 공식 온라인 스토어 회원 전용 혜택</p>
	       
</div>
 
</div>
    
  <jsp:include page="/WEB-INF/n01_leejeongjun/starting_page/footer_startingPage.jsp" />
    
  