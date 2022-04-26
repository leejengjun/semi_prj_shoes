package board.controller.kimminjeong;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.kimminjeong.CommentDAO;
import board.model.kimminjeong.CommentVO;
import board.model.kimminjeong.InterCommentDAO;
import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;

public class QnaCommentAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// 댓글 작성 후 Action 단으로 data가 들어옴.
		String method = request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {
			
			String fk_qna_num = request.getParameter("fk_qna_num");
			String fk_qna_cmtWriter = request.getParameter("fk_qna_cmtWriter");
			String qna_cmtContent = request.getParameter("qna_cmtContent");

			InterCommentDAO cdao = new CommentDAO();
			
			CommentVO cvo = new CommentVO();
			
			cvo.setFk_qna_num(fk_qna_num);
			cvo.setFk_qna_cmtWriter(fk_qna_cmtWriter);
			cvo.setQna_cmtContent(qna_cmtContent);

			int n = cdao.write_comment(cvo);
			// 답변이 DB에 insert 되었는지 여부
			
			String message = "";
			String loc = "";
			
			if(n==1) {
				message = "댓글 등록에 성공했습니다.";	
				loc = request.getContextPath()+"/qnaContent.shoes?qna_num="+fk_qna_num+"&qna_writer="+loginuser.getUserid();	// 해당 게시글에 머무를 수 있도록 경로 재설정
				// http://localhost:9090/semi_prj_shoes/qnaContent.shoes?qna_num=45&qna_writer=kimkimkim
			}
			
			else {
				message = "댓글 등록에 실패했습니다.";
				loc = "javascript:history.back()";	// 이전페이지로
		
			}	
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/qnaMsg.jsp");	
		}				
		
	}

}
