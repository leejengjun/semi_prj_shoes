package board.controller.JeongKyeongEun;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.JeongKyeongEun.BoardDAO;
import board.model.JeongKyeongEun.InterBoardDAO;
import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;


public class NoticeDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String n_userid = request.getParameter("n_userid");
		
		// loginuser != null 로 변경할 것
		if( loginuser != null && "admin".equals(loginuser.getUserid()) ) {	// 작성자만 삭제 가능
			
			// 삭제 확인 총 두번
			// 1. 글 상세보기 시 삭제 누를 때 1번 검사.
			// 2. 글 삭제하기 "예" 버튼을 누르면 삭제.
			
			String method = request.getMethod();	// "GET" 또는 "POST"
			
			if("get".equalsIgnoreCase(method)) {
				
				String notice_no = request.getParameter("notice_no");
				
				request.setAttribute("notice_no", notice_no);
				request.setAttribute("n_userid", n_userid);
				
				super.setViewPage("/WEB-INF/n01_JeongKyeongEun/notice_delete.jsp");
				
			}
			else {
				
				int notice_no = Integer.parseInt(request.getParameter("notice_no"));

				InterBoardDAO bdao = new BoardDAO();
				
				int n = bdao.NoticeDelete(notice_no);	// 게시글 삭제
				
				String message = "";
				String loc = "";
				
				if(n==1) {
					// 삭제 성공
					message = "삭제에 성공했습니다!";
					loc = request.getContextPath()+"/notice.shoes";
					
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
			String loc = request.getContextPath()+"/notice.shoes";	// 경로 재설정(O)
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
	}

}