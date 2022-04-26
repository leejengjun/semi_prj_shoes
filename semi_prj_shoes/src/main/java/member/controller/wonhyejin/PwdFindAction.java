package member.controller.wonhyejin;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.wonhyejin.InterMemberDAO;
import member.model.wonhyejin.MemberDAO;

public class PwdFindAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      String method = request.getMethod();   
      //"GET" 또는 "POST"
      
      if("POST".equalsIgnoreCase(method)) {
         //비밀번호 찾기 모달창에서 "찾기"버튼을 클릭했을 경우 
         
        String userid = request.getParameter("userid");
        String email = request.getParameter("email");
        
        InterMemberDAO mdao = new MemberDAO();
        Map<String, String> paraMap = new HashMap<>();
        paraMap.put("userid", userid);
        paraMap.put("email", email);
        
        boolean isUserExist = mdao.isUserExist(paraMap);
        
        boolean sendMailSuccess = false;// 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도 
        
        if(isUserExist) {
           // 회원으로 존재하는 경우
           //인증키를 랜덤하게 생성하도록 한다.
           Random rnd = new Random();
           
           String certificationCode = "";  
           //인증키는 영문소문자 5글자 +숫자 7글자
         
           char randchar = ' ';
           for(int i=0; i<5; i++) {
             
              randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');  
              certificationCode  += randchar;
           } //end of for----------------
           
           int randnum = 0;
           for(int i=0; i<7; i++) {
              randnum = rnd.nextInt(9 - 0 + 1) + 0;
              certificationCode += randnum;
              
           }//end of for---------
         
            //랜덤하게 생성한 인증코드(certificationCode)를 비밀번호 찾기를 하고자 하는 사용자의 email로 전송시킨다.
           GmailSpend mail =  new GmailSpend();
           
           try {
              mail.sendmail(email, certificationCode);
              sendMailSuccess = true;   //메일전송이 성공했음을 기록함
              
              //세션 불러오기
             HttpSession session = request.getSession();
            session.setAttribute("certificationCode",certificationCode);   
              //발금한 인증코드를 세션에 저장시킴
              
           }  catch(Exception e) {
              //메일전송이 실패한 경우
              e.printStackTrace();
              sendMailSuccess = false;   //메일전송이 실패했음을 기록함
           }
      
        }//end of if(isUserExist)----------------------
        
        request.setAttribute("isUserExist", isUserExist);  
        request.setAttribute("sendMailSuccess", sendMailSuccess);  
        request.setAttribute("userid", userid);  
        request.setAttribute("email", email);  
        
        
      }// end of if("POST".equalsIgnoreCase(method))-----------------
   
      request.setAttribute("method", method);   
      //super.setRedirect(false);
      super.setViewPage("/WEB-INF/n01_wonhyejin/pwdFind.jsp");  
      
   }

}
