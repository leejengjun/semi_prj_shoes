<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String ctxPath = request.getContextPath();
    //     /MyMVC
%>       
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/seongmoongil/style2.css">


<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">


<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.css" > 
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.js"></script>



<!-- 구글 글꼴 임포트 -->




</head>

<script src="https://kit.fontawesome.com/2467f0d6d5.js"></script>
     
   <style type="text/css">
   
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
   
   .star { color: red;
           font-weight: bold;
           font-size: 13pt;
   }
   body {     
	font-family: Arial, "MS Trebuchet", sans-serif; 
    border: solid 0px gray;
    margin: 0;                 
     
    padding: 0;             
  
}
   
   div#container {
	border: solid 0px navy;
	width: 100%;
	margin: 20px auto;  
	
	
}

  div#header {
	height: 300px;  
    margin: 0 0 0 auto;
    background-image: url(../images/wonhyejin/join_top_image.jpg);
}

.join_top_txt{
    color: #fff;
    text-align: right;
    
    width: 80%;
    height: 260px;
    margin-top: 20px;
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
    padding: 0;
    cursor: pointer;
    border: 2px solid #000;
 } 
   </style>
   

<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
<script type="text/javascript">

	let b_flagEmailDuplicateClick = false;
	// 확인 버튼을 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도임.

	$(document).ready(function(){
		
		$("span.error").hide();
		
		$("input#name").blur( ()=>{
			
			const $target = $(event.target);
			
			const name = $target.val().trim();
			if(name == "") {
				// 입력하지 않거나 공백만 입력한 경우
				$("table#tblMemberUpdate :input").prop("disabled",true);
				$target.prop("disabled",false);
				
			//	$target.next().show();
			//  또는
			    $target.parent().find(".error").show();
			    $target.focus();
			}
			else {
				// 공백이 아닌 글자를 입력했을 경우
				$("table#tblMemberUpdate :input").prop("disabled",false);
			
			//	$target.next().hide();
			//  또는
				$target.parent().find(".error").hide();
			}
			
		});// end of $("input#name").blur()-------------------
		   // 아이디가 name 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
		$("input#pwd").blur( ()=>{
			
			const $target = $(event.target);
			
			const passwd = $target.val();
			
		//	const regExp_PW = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
		//  또는
			const regExp_PW = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
			// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
			
			const bool = regExp_PW.test(passwd);
			
			if(!bool) { 
				// 암호가 정규표현식에 위배된 경우 
				$("table#tblMemberUpdate :input").prop("disabled",true);
				$target.prop("disabled",false);
			
				$target.parent().find(".error").show();
				$target.focus();
			}
			else { 
				// 암호가 정규표현식에 맞는 경우 
				$("table#tblMemberUpdate :input").prop("disabled",false);
			
				$target.parent().find(".error").hide();
				
				$("input#pwdcheck").focus();
			} 
		});// end of $("input#pwd").blur()-------------------
		   // 아이디가 pwd 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
		$("input#pwdcheck").blur( ()=>{
			
			const $target = $(event.target);
			
			const passwd = $("input#pwd").val();
			const passwdCheck = $target.val();
			
			if(passwd != passwdCheck) { 
				// 암호와 암호확인값이 틀린 경우 
				$("table#tblMemberUpdate :input").prop("disabled",true);
				$target.prop("disabled",false);
				$("input#pwd").prop("disabled",false);
			
				$target.parent().find(".error").show();
			    $("input#pwd").focus();
			}
			else { 
				// 암호와 암호확인값이 같은 경우 
				$("table#tblMemberUpdate :input").prop("disabled",false);
				
				$target.parent().find(".error").hide();
			}
			
		});// end of $("input#pwdcheck").blur()--------------
		   // 아이디가 pwdcheck 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.

		
		$("input#email").blur( ()=>{
			
			const $target = $(event.target);
			
			const email = $target.val();
			
			const regExp_EMAIL = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;  
			
			const bool = regExp_EMAIL.test(email);
			
			if(!bool) { 
				// 이메일이 정규표현식에 위배된 경우
				$("table#tblMemberUpdate :input").prop("disabled",true);
				$target.prop("disabled",false);
			
				$target.parent().find(".error").show();
				$target.focus();
			}
			else { 
				// 이메일이 정규표현식에 맞는 경우
				$("table#tblMemberUpdate :input").prop("disabled",false);
				
				$target.parent().find(".error").hide();
			}
			
		});// end of $("input#email").blur()--------------
		   // 아이디가 email 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.

		
		$("input#hp2").blur( ()=>{
			
			const $target = $(event.target);
			
			const regExp_HP2 = /^[1-9][0-9]{3}$/g;
			// 숫자 4자리만 들어오도록 검사해주는 정규표현식
			
			const hp2 = $target.val();
			
			const bool = regExp_HP2.test(hp2);
			
			if(!bool) {
				// 국번이 정규표현식에 위배된 경우
				$("table#tblMemberUpdate :input").prop("disabled",true);
				$target.prop("disabled",false);
			
				$target.parent().find(".error").show();
				$target.focus();
			}
			else {
				// 국번이 정규표현식에 맞는 경우
				$("table#tblMemberUpdate :input").prop("disabled",false);
			
				$target.parent().find(".error").hide();
			}	
		});// end of $("input#hp2").blur()-------------------
		   // 아이디가 hp2 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
		$("input#hp3").blur( ()=>{
			
			const $target = $(event.target);
			
			const regExp_HP3 = /^\d{4}$/g;
			// 숫자 4자리만 들어오도록 검사해주는 정규표현식
			
			const hp3 = $target.val();
			
			const bool = regExp_HP3.test(hp3);
			
			if(!bool) {
				// 마지막 전화번호 4자리가 정규표현식에 위배된 경우
				$("table#tblMemberUpdate :input").prop("disabled",true);
				$target.prop("disabled",false);
			
				$target.parent().find(".error").show();
				$target.focus();
			}
			else {
				// 마지막 전화번호 4자리가 정규표현식에 맞는 경우
				$("table#tblMemberUpdate :input").prop("disabled",false);
				
				$target.parent().find(".error").hide();
			}	
		});// end of $("input#hp3").blur()------------------
		   // 아이디가 hp3 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
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
	                document.getElementById("detailAddress").focus();
	            }
	        }).open();				
		});
		
	 // 이메일값이 변경되면 가입하기 버튼을 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도 초기화 시키기    
    	$("input#email").bind("change", ()=>{
    		b_flagEmailDuplicateClick = false;
    	});
	 
	});// end of $(document).ready()-----------------------

	// 이메일 중복여부 검사하기
	   function isExistEmailCheck() {
	      
	      b_flagEmailDuplicateClick = true;
	       // 가입하기 버튼을 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도임.
	       
	       $.ajax({
	          url:"<%= ctxPath%>/edit/emailDuplicateCheck.shoes",
	          type:"post",
	          data:{"email":$("input#email").val()},
	          dataType:"json",
	          success:function(json) {
	             
	             if(json.isExists) {
	                
	                // 세션에 올라온 email 과 입력해준 email 이 같은 경우 (즉, 이메일을 새로이 변경하지 않고 그대로 사용할 경우)
	                if( "${sessionScope.loginuser.email}" == $("input#email").val() ) {
	                   $("span#emailCheckResult").html($("input#email").val()+" 은 사용가능합니다").css("color","green");
	                }
	                else { 
	                // 이메일을 새로이 변경한 경우인데 입력한 email 이 이미 사용중 이라면
	                   $("span#emailCheckResult").html($("input#email").val()+" 은 이미 사용중이므로 사용불가 합니다.").css("color","orange");
	                   $("input#email").val("");
	                }
	              }
	             else {
	                // 입력한 email 이 DB 테이블에 존재하지 않는 경우라면 
	                $("span#emailCheckResult").html($("input#email").val()+" 은 사용가능합니다").css("color","green");
	             }
	             
	          },
	          error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	         }
	       });      
	      
	   }// end of function isExistEmailCheck() {}----------------------------------
	
	   
	// 수정하기
	   function goEdit() {
	      
	      // *** 필수입력사항에 모두 입력이 되었는지 검사한다. *** //
	      let flagBool = false;
	      
	      $("input.requiredInfo").each( (index, item)=>{
	         const data = $(item).val().trim();
	         if(data == "") {
	            flagBool = true;
	            return false;
	            /*
	               for문에서의 continue; 와 동일한 기능을 하는것이 
	               each(); 내에서는 return true; 이고,
	               for문에서의 break; 와 동일한 기능을 하는것이 
	               each(); 내에서는 return false; 이다.
	            */
	         }
	      });
	      
	      if(flagBool) {
	         alert("필수입력란은 모두 입력하셔야 합니다.");
	         return; // 종료
	      }
	      
	      if(!b_flagEmailDuplicateClick) {
	          // "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도임.
	          alert("이메일중복확인 클릭하여 이메일중복검사를 하세요!!");
	          return; // 종료
	       }
	      
	      const frm = document.editFrm;
	      frm.method = "POST";
	      frm.action = "<%= ctxPath%>/edit/memberEditEnd.shoes";
	      frm.submit();
	      
	   }// end of function goEdit()-----------------------------
	
</script>



	
	
	<div>  
	<form name="editFrm"> 
    <div>


	   <table style="margin-bottom: 2%;" id="tblMemberRegister">
	     <thead>
	      <tr>
	          
	           <th colspan="2" id="th">개인정보 수정 (<span style="font-size: 10pt; font-style: italic;"><span class="star">*</span>표시는 필수입력사항</span>) :::</th>
	      </tr>
	      </thead>
	      
	      <tbody>
	      <tr>
	         <td style="width: 20%; font-weight: bold;">아이디&nbsp;<span class="star">*</span></td>
	         <td style="width: 80%; text-align: left;">
	             <input type="text" name="userid" id="userid" class="requiredInfo" value="${sessionScope.loginuser.userid}" readonly/>&nbsp;&nbsp;
	             
	         </td> 
	      </tr>
	       <tr>
	         <td style="width: 20%; font-weight: bold;">비밀번호&nbsp;<span class="star">*</span></td>
	         <td style="width: 80%; text-align: left;"><input type="password" name="pwd" id="pwd" class="requiredInfo" />
	            <span class="error">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로 입력하세요.</span>
	         </td>
	      </tr>
	      <tr>
	         <td style="width: 20%; font-weight: bold;">비밀번호확인&nbsp;<span class="star">*</span></td>
	         <td style="width: 80%; text-align: left;"><input type="password" id="pwdcheck" class="requiredInfo" /> 
	            <span class="error">암호가 일치하지 않습니다.</span>
	         </td>
	      </tr>
	      <tr>
	         <td style="width: 20%; font-weight: bold;">이름&nbsp;<span class="star">*</span></td>
	         <td style="width: 80%; text-align: left;">
	             <input type="text" name="name" id="name" class="requiredInfo"  value="${sessionScope.loginuser.name}" readonly/> 
	            
	         </td>
	      </tr>
	         <tr>
	         <td style="width: 20%; font-weight: bold;">우편번호</td>
	         <td style="width: 80%; text-align: left;">
	            <input type="text" id="postcode" name="postcode" size="6" maxlength="5" value="${sessionScope.loginuser.postcode}"/>&nbsp;&nbsp;
	            <%-- 우편번호 찾기 --%>
	            <img id="zipcodeSearch" src="<%= ctxPath%>/images/seongmoongil/b_zipcode_hj.gif" style="vertical-align: middle;" />
	            <span class="error">우편번호 형식이 아닙니다.</span>
	         </td>
	      </tr>
	      <tr>
	         <td style="width: 20%; font-weight: bold;">주소</td>
	         <td style="width: 80%; text-align: left;">
	            <input type="text" id="address" name="address" size="40" value="${sessionScope.loginuser.address}" /><br/>
	            <input type="text" id="detailAddress" name="detailAddress" size="40" value="${sessionScope.loginuser.detailaddress}" />&nbsp;<input type="text" id="extraAddress" name="extraAddress" size="40" value="${sessionScope.loginuser.extraaddress}" /> 
	            <span class="error">주소를 입력하세요</span>
	         </td>
	      </tr>
	      <tr>
	         <td style="width: 20%; font-weight: bold;">연락처</td>
	         <td style="width: 80%; text-align: left;">
	             <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
	             <input type="text" id="hp2" name="hp2" size="6" maxlength="4" value="${ fn:substring(sessionScope.loginuser.mobile, 3, 7) }" />&nbsp;-&nbsp;
	             <input type="text" id="hp3" name="hp3" size="6" maxlength="4" value="${ fn:substring(sessionScope.loginuser.mobile, 7, 11) }" />
	             <span class="error">휴대폰 형식이 아닙니다.</span>
	         </td>
	      </tr>
	           
	      
	      <tr>
	         <td style="width: 20%; font-weight: bold;">이메일&nbsp;<span class="star">*</span></td>
	         <td style="width: 80%; text-align: left;"><input type="text" name="email" id="email" class="requiredInfo" value="${sessionScope.loginuser.email}" /> 
	             <span class="error">이메일 형식에 맞지 않습니다.</span>
	             
	           
	             <span style="display: inline-block; width: 80px; height: 30px; border: solid 1px gray; border-radius: 5px; font-size: 8pt; text-align: center; margin-left: 10px; cursor: pointer;" onclick="isExistEmailCheck();">이메일중복확인</span> 
	             <span id="emailCheckResult"></span>
	           
	         </td>
	      </tr>
	     
	         </tbody>
	   </table>
</div>	      
	     
	     <div>
	     <table id="tbl2">
	       
	       <tr>
                <td class="title">
                       
                      <label for="agree_box1" style="font-weight: bolder;">oo 공식 온라인 스토어 회원 약관 및 개인정보 수집•이용에 대한 동의</label><br>

                     <input type="checkbox" name="agree_box" id="agree_box3" /> (선택) 이메일 수신 동의&nbsp;<br>
                     <input type="checkbox" name="agree_box" id="agree_box4" /><label for="agree_box4"> &nbsp;(선택) 문자 수신동의</label>&nbsp;
                     
                </td>
            </tr>
            
             <tr>
	         <td colspan="2" style="line-height: 90px;" class="text-center">
	          
	           
	         </td>
	      </tr>
	
	
  </table>
  </div>
   <button type="button" id="btnUpdate" class="btnSubmit" onclick="goEdit()" style="margin-left:30%;">수정하기</button> 
  </form>
</div>
</html>



    
    
    
  