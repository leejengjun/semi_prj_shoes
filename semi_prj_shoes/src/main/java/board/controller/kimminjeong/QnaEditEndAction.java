package board.controller.kimminjeong;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.model.kimminjeong.BoardDAO;
import board.model.kimminjeong.BoardVO;
import board.model.kimminjeong.InterBoardDAO;
import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;

public class QnaEditEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 정보를 update 하는 과정이 필요하다. --> 기존 글 내용에서 새롭게 DB에 업데이트 하는 것.
		// 글 수정을 위해서는 우선 로그인 상태여야 한다.
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		String method = request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {
			// 올바른 접근방식. GET 방식이면 안된다.
			
			MultipartRequest mprequest = null;
			
			ServletContext svlCtx = session.getServletContext();
			String uploadFileDir = svlCtx.getRealPath("/images/kimminjeong");
			
			try {
				
				mprequest = new MultipartRequest(request, uploadFileDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
				
			} catch (Exception e) {
				request.setAttribute("message", "파일 용량 초과로 인해 업로드에 실패했습니다.");
				request.setAttribute("loc", request.getContextPath()+"/qnaEdit.shoes");	// 이전 페이지로 가도록 설정하기
				e.printStackTrace();
				super.setViewPage("/WEB-INF/qnaMsg.jsp");
				return;
			}
			
			// hidden form 태그로 받은 글정보를 vo에 넣는다.
			String qna_writer = mprequest.getParameter("qna_writer");
			int qna_num = Integer.parseInt(mprequest.getParameter("qna_num"));
			String qna_subject = mprequest.getParameter("qna_subject");
			String qna_content = mprequest.getParameter("qna_content");
			
			// file 의 경우 getParameter가 아님.
			// 이때 업로드 된 파일이 없는 경우에는 null 반환한다.
			String qna_file = mprequest.getFilesystemName("qna_file");	// 수정하기 위한 글에 첨부파일이 없다면 null
		//	String pname = mprequest.getParameter("pname");
			
		//	시큐어코드	
			qna_content = qna_content.replaceAll("<", "&lt;");
			qna_content = qna_content.replaceAll(">", "&gt;");
			qna_content = qna_content.replaceAll("\r\n", "<br>");
			
			BoardVO bvo = new BoardVO();
			
			bvo.setQna_writer(qna_writer);
			bvo.setQna_subject(qna_subject);
			bvo.setQna_content(qna_content);
			bvo.setQna_file(qna_file);
			bvo.setQna_num(qna_num);
		//	bvo.setPname(Pname);	// 상품정보 불러오기
			
			InterBoardDAO mdao = new BoardDAO();
			
			int n = mdao.QnaEdit(bvo);	// dao 에서 return 값 가져오기
			
			String message = "";
			String loc = "";
			
			if(n==1) {
				// update 성공
				message = "글이 성공적으로 수정되었습니다.";
				loc = request.getContextPath()+"/qnaContent.shoes?qna_num="+qna_num+"&qna_writer="+qna_writer;
			}
			else {
				// return 값 0 = update 실패;
				message = "글 수정에 실패했습니다.";
				loc = request.getContextPath()+"/qnaList.shoes";	// 이전 페이지로 경로 재설정
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/qnaMsg.jsp");
			
		}
		
		else { // GET 방식일 경우
			
			String message = "잘못된 접근입니다.";
			String loc = request.getContextPath()+"/qnaList.shoes";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/qnaMsg.jsp");
			
		}
		
	}

}
