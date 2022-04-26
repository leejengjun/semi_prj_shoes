package member.controller.seongmoongil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;

public class MemberEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 내정보(회원정보)를 수정하귀 위한 전제조건은 먼저 로그인을 해야하는 것이다.
		if( super.checkLogin(request) ) {
			// 로그인은 했으면 
			
			String userid = request.getParameter("userid");
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			if( loginuser.getUserid().equals(userid) ) {
				// 자기 정보를 수정하는 경우
				
			 // super.setRedirect(false);
				super.setViewPage("/WEB-INF/n01_seongmoongil/edit.jsp");
			}
			else {
				String message = "다른 사용자의 정보변경은 불가합니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
			 // super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
		}
		else {
			// 로그인을 안 했으면 
			String message = "회원정보를 수정하기 위해서는 먼저 로그인을 해야합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		 // super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
	}

}
