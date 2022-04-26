package board.controller.kimminjeong;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.model.kimminjeong.BoardVO;
import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;

public class QnaEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String method = request.getMethod();
		
		if("post".equalsIgnoreCase(method)) { 
			// post 방식으로 글수정 했다면,
			MultipartRequest mprequest = null;
			
			ServletContext svlCtx = session.getServletContext();
			String uploadFileDir = svlCtx.getRealPath("/images/kimminjeong");
			
			try {
				
				mprequest = new MultipartRequest(request, uploadFileDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
				
			} catch (Exception e) {
				request.setAttribute("message", "파일 용량 초과로 인해 업로드에 실패했습니다.");
				request.setAttribute("loc",request.getContextPath()+"/index.shoes");
				e.printStackTrace();
				super.setViewPage("/WEB-INF/qnaMsg.jsp");
				return;
			}
			
			// hidden form 태그로 받은 글정보를 vo에 넣는다.
			String qna_writer = mprequest.getParameter("qna_writer");
			int qna_num = Integer.parseInt(mprequest.getParameter("qna_num"));
			String qna_subject = mprequest.getParameter("qna_subject");
			String qna_content = mprequest.getParameter("qna_content");
			String qna_file = mprequest.getParameter("qna_file");
		//	String pname = mprequest.getParameter("pname");
			
			qna_content = qna_content.replaceAll("<br>", "\r\n");	// jsp 에서 엔터처리
			
			if(loginuser != null && qna_writer.equals(loginuser.getUserid())) {	// 로그인한 상태이며, 글 작성자와 로그인한 유저가 같을 때 vo 에 저장한 후, 수정 처리를 진행한다.
			
				BoardVO bvo = new BoardVO();
				
				bvo.setQna_writer(qna_writer);
				bvo.setQna_num(qna_num);
				bvo.setQna_subject(qna_subject);
				bvo.setQna_content(qna_content);
				bvo.setQna_file(qna_file);
			//	bvo.setQna_pname(pname);	
				
				request.setAttribute("bvo", bvo);
				
				// 글 수정 페이지인 view 페이지로 이동한다.
				super.setViewPage("/WEB-INF/n01_kimminjeong/QnaEdit.jsp");	// view 단 페이지가 어디인지 알려준다.
				
			}
			else {
				
				String message = "글 작성자만 수정이 가능합니다.";
				String loc = request.getContextPath()+"/qnaList.shoes";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/qnaMsg.jsp");	
			}
			
		}
		
		else {
			// GET 방식으로 접근
			
			String message = "잘못된 접근입니다.";
			String loc = request.getContextPath()+"/index.shoes";
			
			request.setAttribute("message", message);
			request.setAttribute("loc",loc);
			
			super.setViewPage("/WEB-INF/qnaMsg.jsp");
			
		}
		
		
		
	}

}
