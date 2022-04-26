package board.controller.kimminjeong;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.kimminjeong.CommentDAO;
import board.model.kimminjeong.CommentVO;
import board.model.kimminjeong.InterCommentDAO;
import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;

public class QnaCommentEditEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// 댓글 수정 form 태그 전송
		String method = request.getMethod();
		
		String message = "";
		String loc = "";
		
		if("post".equalsIgnoreCase(method)) {
			
			int qna_commentno = Integer.parseInt(request.getParameter("qna_commentno"));
			String qna_cmtContent = request.getParameter("qna_cmtContent");
			String qna_num = request.getParameter("qna_num");		// 원래 게시글로 돌아간다. view 단에서 값 받아오는지 확인
	//		String fk_qna_cmtWriter = request.getParameter("fk_qna_cmtWriter");
			String qna_writer = request.getParameter("qna_writer");
			
			// 아래 두개를 못불러옴
			System.out.println("확인용 qna_num : "+qna_num);
			System.out.println("확인용 qna_writer : "+qna_writer);
			
			CommentVO cvo = new CommentVO();			
			cvo.setQna_commentno(qna_commentno);
			cvo.setQna_cmtContent(qna_cmtContent);
		//	cvo.setFk_qna_num(qna_num);
			
			InterCommentDAO cdao = new CommentDAO();
			
			int n = cdao.qnaEditComment(cvo);
			
			if(n==1) {	// dao 에서 수정 후 return 된 값이 1 (댓글 수정 성공)
				
				message = "댓글 수정에 성공했습니다.";
				loc = request.getContextPath()+"/qnaContent.shoes?qna_num="+qna_num+"&qna_writer="+loginuser.getUserid();
				// 댓글 수정 했을 때 원래 게시글로 돌아올 수 있도록 한다.	
				// http://localhost:9090/semi_prj_shoes/qnaContent.shoes?qna_num=43&qna_writer=kimkimkim
			}
			else { // (댓글 수정 실패)
				message = "댓글 수정에 실패했습니다.";
				loc = request.getContextPath()+"/qnaContent.shoes";	// 경로 재수정
				
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/qnaMsg.jsp");			
			
		}
		
		else {
			// get 방식으로 접근
			
			message = "잘못된 접근입니다.";
			loc = request.getContextPath()+"/index.shoes";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/qnaMsg.jsp");			
		}
		
	}

}
