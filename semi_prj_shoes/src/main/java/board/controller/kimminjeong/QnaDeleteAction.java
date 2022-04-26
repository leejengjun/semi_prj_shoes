package board.controller.kimminjeong;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.kimminjeong.BoardDAO;
import board.model.kimminjeong.InterBoardDAO;
import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;

public class QnaDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String qna_writer = request.getParameter("qna_writer");
		// loginuser != null 로 변경할 것
		if( loginuser != null && qna_writer.equals(loginuser.getUserid()) ) {	// 작성자만 삭제 가능
			
			// 1. 글 상세보기 시 삭제 누를 때 1번 검사.
			
			// 2. 글 삭제하기 "예" 버튼을 누르면 1번 검사.
			
			String method = request.getMethod();	// "GET" 또는 "POST"
			
			if("get".equalsIgnoreCase(method)) {
				
				String qna_num = request.getParameter("qna_num");
				
				request.setAttribute("qna_num", qna_num);
				request.setAttribute("qna_writer", qna_writer);
				
				super.setViewPage("/WEB-INF/n01_kimminjeong/QnaDelete.jsp");
				
			}
			else {
				
				int qna_num = Integer.parseInt(request.getParameter("qna_num"));

				InterBoardDAO bdao = new BoardDAO();
				
				int n = bdao.QnaDelete(qna_num);	// 게시글 삭제
				
				String message = "";
				String loc = "";
				
				if(n==1) {
					// 삭제 성공
					message = "삭제에 성공했습니다!";
					loc = request.getContextPath()+"/qnaList.shoes";	// 경로 재설정
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					super.setViewPage("/WEB-INF/qnaDeleteMsg.jsp");
				
				} 
				else {
					
					message = "삭제에 실패했습니다.";
					loc = request.getContextPath()+"/index.shoes";	// 경로 재설정
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					super.setViewPage("/WEB-INF/qnaMsg.jsp");
					
				}
				
			}
			
			
		}// end of 작성자 삭제 ---------------------
		
		else {	
			
			String message = "삭제 권한이 없습니다.";
			String loc = request.getContextPath()+"/qnaList.shoes";	// 경로 재설정
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/qnaMsg.jsp");
			
		}
		
	}

}
