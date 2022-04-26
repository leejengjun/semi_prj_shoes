package member.controller.wonhyejin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class VerifyCertificationAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userCertificationCode = request.getParameter("userCertificationCode");  //유저 인증키
		String userid = request.getParameter("userid");
		 
		 
		 HttpSession session = request.getSession();  // 랜덤하게 발송되어진 인증키
		 String certificationCode =(String)session.getAttribute("certificationCode");   //세션에 저장된 인증코드 가져오기
		 
		 String message = "";
		 String loc = "";
		 
		 if(certificationCode.equals(userCertificationCode) ) {   //유저가 보내준 인증키하고 내가 보내준인증키하고 같냐 같지않냐
			 message = "인증이 완료되었습니다.";  // 유저가 보내준 인증코드와 메일 받은 인증코드가 같다면  새로운 비밀번호 만들기
			 loc = request.getContextPath()+"/pwdUpdate.shoes?userid="+userid;  // 변경할 유저 아이디
		 }
		 else {
			 message = "발급된 인증코드가 아닙니다. 인증코드를 다시 발급받으세요!!";
			 loc = request.getContextPath()+"/pwdFind.shoes";
		 }
		 
		 request.setAttribute("message", message);
		 request.setAttribute("loc", loc);
		 
		 //super.setRedirect(false);
		 super.setViewPage("/WEB-INF/n01_wonhyejin/msg.jsp");
		
		 session.removeAttribute("certificationCode");  //세션에 저장된 인증코드 삭제
		 
		 
	}

}
