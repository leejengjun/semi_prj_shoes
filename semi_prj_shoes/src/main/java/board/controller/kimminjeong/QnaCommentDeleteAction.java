package board.controller.kimminjeong;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.kimminjeong.CommentDAO;
import board.model.kimminjeong.InterCommentDAO;
import common.controller.AbstractController;

public class QnaCommentDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if(!"post".equalsIgnoreCase(method)) {

			String qna_commentno = request.getParameter("qna_commentno");
			
			request.setAttribute("qna_commentno",qna_commentno);
			
			super.setViewPage("/WEB-INF/n01_kimminjeong/QnaCmtDelete.jsp");
			
		}
		else {
			
			int qna_commentno = Integer.parseInt(request.getParameter("qna_commentno"));
			
			InterCommentDAO cdao = new CommentDAO();
			
			int n = cdao.qnaDeleteComment(qna_commentno);
			
			String message = "";
			String loc = "";
			
			if(n==1) {
				// 삭제에 성공했다면 (해당 게시글에 머무를 수 있도록 경로 설정)
				message = "댓글이 삭제되었습니다.";
				loc = "javascript:history.back()";
				// http://localhost:9090/semi_prj_shoes/qnaContent.shoes?qna_num=43&qna_writer=kimkimkim
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);				
				super.setViewPage("/WEB-INF/qnaMsg.jsp");				
			}
			else {
				// 댓글 삭제 실패
				message = "댓글 삭제에 실패했습니다.";
				loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);				
				super.setViewPage("/WEB-INF/qnaMsg.jsp");				
			}
			
		}
						
	}

}
