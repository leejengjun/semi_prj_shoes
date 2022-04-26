package member.controller.wonhyejin;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.wonhyejin.InterMemberDAO;
import member.model.wonhyejin.MemberDAO;
import member.model.wonhyejin.MemberVO;

public class MemberRegisterAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    String method = request.getMethod();
      
      if("GET".equalsIgnoreCase(method)) {
          super.setViewPage("/WEB-INF/n01_wonhyejin/memberRegister.jsp");
          
      }
      else {  
         // 가입하기 버튼 누른 후
            String name = request.getParameter("name");
            String userid = request.getParameter("userid");
            String pwd = request.getParameter("pwd");
            String email = request.getParameter("email");
            String hp1 = request.getParameter("hp1");
            String hp2 = request.getParameter("hp2");
            String hp3 = request.getParameter("hp3");
            String postcode = request.getParameter("postcode");
            String address = request.getParameter("address");
            String detailaddress = request.getParameter("detailAddress");
            String extraaddress = request.getParameter("extraAddress");
            String gender = request.getParameter("gender");
            String birthyyyy = request.getParameter("birthyyyy");
            String birthmm = request.getParameter("birthmm");
            String birthdd = request.getParameter("birthdd");
            
            String mobile = hp1+hp2+hp3;
            String birthday = birthyyyy+"-"+birthmm+"-"+birthdd;
            
            MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday); 
         
          
          //    // ######## 회원가입이 성공되면 자동으로 로그인이 안되도록 ######## //
            /*       String message = "";
            String loc = "";
            
            try {
               InterMemberDAO mdao = new MemberDAO();
               int n = mdao.registerMember(member);
               
               if(n==1) {
                  message = "회원가입 성공";
                 loc = request.getContextPath()+"/index.shoes"; //시작페이지 이동
               }
               
            } catch(SQLException e) {
               message = "SQL구문 에러발생";
               loc = "javascript:history.back()"; //이전 페이지로 이동
                e.printStackTrace();
            }
            
            request.setAttribute("message", message);
            request.setAttribute("loc", loc);
            
         // super.setRedirect(false);
            super.setViewPage("/WEB-INF/n01_wonhyejin/msg.jsp"); 
      */  
         
            
        // ######## 회원가입이 성공되면 자동으로 로그인 되도록 하겠다. ######## //
                   
             try {
               InterMemberDAO mdao = new MemberDAO();
               int n = mdao.registerMember(member);
               
               if(n==1) {
                  request.setAttribute("userid", userid);
                  request.setAttribute("pwd", pwd);
                  
                  //super.setRedirect(false);
                  super.setViewPage("/WEB-INF/n01_wonhyejin/registerAfterAutoLogin.jsp");  
               }
               
            } catch(SQLException e) {
               
                 e.printStackTrace();
                 
                 String message = "SQL구문 에러발생";
                  String loc = "javascript:history.back()"; 
                  
                   request.setAttribute("message", message);
                   request.setAttribute("loc", loc);
                     
                  // super.setRedirect(false);
                     super.setViewPage("/WEB-INF/n01_wonhyejin/msg.jsp");
                 }    
      
          ///////////////////////////////////////////////////////////////
         
         }
      
         
      }

}