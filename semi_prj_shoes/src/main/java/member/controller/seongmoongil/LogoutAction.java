package member.controller.seongmoongil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;


public class LogoutAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
		//로그아웃 처리하기
		
		HttpSession session = request.getSession();// 세션불어오기
		
		/////////////////////////////////////////////////////////////////
		// 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것
		String goBackURL = (String) session.getAttribute("goBackURL");
		
		if(goBackURL != null ) {
			goBackURL = request.getContextPath()+goBackURL;
		}
		////////////////////////////////////////////////////////////// 
		
		
		 super.setRedirect(true);
		 
		 if(goBackURL != null && !"admin".equals( ((MemberVO) session.getAttribute("loginuser")).getUserid()  )) {
			 // 관리자가 아닌 일반 사용자로 들어와서 돌아갈 페이지가 있다면
			 session.invalidate(); 
			 super.setViewPage(goBackURL);
		 }
		 else { 
			 session.invalidate(); 
			 super.setViewPage(request.getContextPath()+"/index.shoes");  //로그아웃되어지면 시작페이지로감
		 }
		
		
		
	}

}
