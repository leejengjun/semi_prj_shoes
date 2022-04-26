package board.controller.JeongKyeongEun;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.JeongKyeongEun.BoardEventDAO;
import board.model.JeongKyeongEun.InterBoardEventDAO;
import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;

public class EventDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String e_userid = request.getParameter("e_userid");
		
		// loginuser != null 로 변경할 것
		if( loginuser != null && "admin".equals(loginuser.getUserid()) ) {	// 관리자만 삭제 가능
			
			// 삭제 확인 총 두번
			// 1. 글 상세보기 시 삭제 누를 때 1번 검사.
			// 2. 글 삭제하기 "예" 버튼을 누르면 삭제.
			
			String method = request.getMethod();	// "GET" 또는 "POST"
			
			if("get".equalsIgnoreCase(method)) {
				
				String event_no = request.getParameter("event_no");
				
				request.setAttribute("event_no", event_no);
				request.setAttribute("e_userid", e_userid);
				
				super.setViewPage("/WEB-INF/n01_JeongKyeongEun/event_delete.jsp");
				
			}
			else {
				
				int event_no = Integer.parseInt(request.getParameter("event_no"));

				InterBoardEventDAO bdao = new BoardEventDAO();
				
				int n = bdao.EventDelete(event_no);	// 게시글 삭제
				
				String message = "";
				String loc = "";
				
				if(n==1) {
					// 삭제 성공
					message = "삭제에 성공했습니다!";
					loc = request.getContextPath()+"/event.shoes";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					super.setViewPage("/WEB-INF/n01_JeongKyeongEun/deleteMsg.jsp");
				
				} else {
					
					message = "삭제에 실패했습니다.";
					loc = request.getContextPath()+"/index.shoes";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					super.setViewPage("/WEB-INF/msg.jsp");
					
				}
				
			}
			
			
		}// end of 작성자 삭제 ---------------------
		
		else {	
			
			String message = "삭제 권한이 없습니다.";
			String loc = request.getContextPath()+"/event.shoes";	// 경로 재설정(O)
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
	}

}