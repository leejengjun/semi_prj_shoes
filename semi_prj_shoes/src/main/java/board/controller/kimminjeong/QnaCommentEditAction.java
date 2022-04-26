package board.controller.kimminjeong;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.kimminjeong.CommentVO;
import common.controller.AbstractController;

public class QnaCommentEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// form 태그에서 보내온 name 값을 받아오자.
		String qna_num = request.getParameter("qna_num");
		int qna_commentno = Integer.parseInt(request.getParameter("qna_commentno"));	// getparameter 시 String 으로 반환하므로 int 변환
		String fk_qna_cmtWriter = request.getParameter("fk_qna_cmtWriter");
		String qna_cmtContent = request.getParameter("qna_cmtContent");
		

	//	System.out.println("확인용 qna_commentno => " + qna_commentno);
		
		CommentVO cvo = new CommentVO();
		
		cvo.setQna_commentno(qna_commentno);
		cvo.setFk_qna_cmtWriter(fk_qna_cmtWriter);
		cvo.setQna_cmtContent(qna_cmtContent);
		
		request.setAttribute("cvo", cvo);
		request.setAttribute("qna_num", qna_num);
		
		super.setViewPage("/WEB-INF/n01_kimminjeong/QnaCmtEdit.jsp");	// 경로
	}

}
