<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  
<style type="text/css">
   table#personInfoTbl {
      border: 0px solid gray;
      border-collapse: collapse;
      width: 90%;
      margin-top: 3%;
   }
   
   table#personInfoTbl tr {
      line-height: 200%;
   }
   
   table#personInfoTbl td {
      border: 0px solid gray;
      border-collapse: collapse;
      font-size: 14pt;
   }
   
   table#personInfoTbl td.title {
      text-align: justify;
      font-size: 14pt;
      font-weight: bold;
   }
   
   div.head {
      border: 2px solid gray;
      border-left:none;
      border-right:none;
      margin: 20px 0;
      padding: 15px 0;
      background-color: none;
      font-size: 18pt;
      text-align: center;
      vertical-align: middle;
   }
    
</style>    

<c:set var="mobile" value="${requestScope.mvo.mobile}" />

<div style="width: 80%; margin: 0 auto;">
   <div class="head">::: 회원상세정보 :::</div>
      <table id="personInfoTbl">
         
         <tr>
           <td class="title">아이디</td>
           <td>${requestScope.mvo.userid}</td>
         </tr>
                  
         <tr>
           <td class="title">성명</td>
           <td>${requestScope.mvo.name}</td>
         </tr>
                  
         <tr>
           <td class="title">이메일</td>
           <td>${requestScope.mvo.email}</td>
         </tr>
         
         <tr>
           <td class="title">연락처</td>
           <td>${fn:substring(mobile, 0, 3)}-${fn:substring(mobile, 3, 7)}-${fn:substring(mobile, 7, 11)}</td>
         </tr>
         
         <tr>
           <td class="title">우편번호</td>
           <td>${requestScope.mvo.postcode}</td>
         </tr>
         
         <tr>
           <td class="title">주소</td>
           <td>${requestScope.mvo.address}<br>${requestScope.mvo.detailaddress}&nbsp;${requestScope.mvo.extraaddress}</td>
         </tr>
                  
         <tr>
            <td colspan="2" align="center">
                <button type="button" style="margin-top: 30px; background-color: navy; color: white; width: 100px; height: 30px; border: none; font-size: 13pt;" onClick="javascript:self.close();">닫기</button>  
            </td>
         </tr>
      </table>
</div>

