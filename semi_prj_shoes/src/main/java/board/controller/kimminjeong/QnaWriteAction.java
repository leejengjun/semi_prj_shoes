package board.controller.kimminjeong;

import java.io.IOException;

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

public class QnaWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser != null  /* && !"admin".equalsIgnoreCase(loginuser.getUserid())*/) {	// 로그인을 했을 때, 관리자가 아닐 때 Qna 를 쓸 수 있도록 한다.	!= 로 수정 필!! (loginuser 만 쓸 수 있게 해야한다!)
			
			String method = request.getMethod(); // GET 또는 POST
			
			if(!"post".equalsIgnoreCase(method)) {	// GET 이면 문의사항 작성페이지로 이동한다.
				// 제품번호와 제품명을 가져온다.
				///// 제품 DAO VO list 가져오기 /////
				
				
				
				//////////////////////////////////
				
				super.setViewPage("/WEB-INF/n01_kimminjeong/QnaWrite.jsp");
				
			} 
			
			else {	// POST 방식이면 문의사항 게시글에 insert 한 후 결과를 출력한다.
		
				// 파일첨부 관련
				MultipartRequest mprequest = null;
								
				ServletContext svlCtx = session.getServletContext(); 
				int fileSize = 10*1024*1024;	// 업로드 파일 사이즈
				String uploadFileDir = svlCtx.getRealPath("/images/kimminjeong");	// 업로드될 폴더 경로
			//	System.out.println("=== 첨부되는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> " + uploadFileDir);		
			//	=== 첨부되는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> C:\NCS\workspace(jsp)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\semi_prj_shoes\images\kimminjeong
				try {
					// 파일첨부 생성자의 매개변수 넣기 (파일 업로드)
					mprequest = new MultipartRequest(request, uploadFileDir, fileSize, "UTF-8", new DefaultFileRenamePolicy()); 							
				
				} catch (IOException e) {					  
					request.setAttribute("message", "파일 용량 초과로 인해 업로드에 실패했습니다.");	
					request.setAttribute("loc", request.getContextPath()+"/qnaWrite.shoes");	// 파일첨부 실패 시 이전페이지로 이동 onclick="javascript:history.back();			
					e.printStackTrace();
					super.setViewPage("/WEB-INF/qnaMsg.jsp");
					return;	 
				}
			
			// 멀티파트 폼(multipart/form-data)으로 넘긴 파라미터 request.getParameter 로 받기
			// 멀티파트 폼(<form enctype=”multipart/form-data”>)으로 넘긴 파라미터는 multipartRequest.getParameter 메서드로 받아야 한다.
			// jsp 에서 name 에 준 값을 그대로 가져온다.
			String qna_writer = mprequest.getParameter("qna_writer");
			String qna_subject = mprequest.getParameter("qna_subject");
	//		String pnum = mprequest.getParameter("pnum");	// 제품 테이블에서 불러올 것		
			String qna_content = mprequest.getParameter("qna_content");		
			// 시큐어코드
			qna_content = qna_content.replaceAll("<", "&lt;");
			qna_content = qna_content.replaceAll(">", "&gt;");
			qna_content = qna_content.replaceAll("\r\n", "<br>");			
			
			String qna_file = mprequest.getFilesystemName("qna_file");	// .metadata 에 올라간 파일명
			String qna_file_originFileName = mprequest.getOriginalFileName("qna_file");	// 사용자가 실제 업로드한 파일명
			
			BoardVO bvo = new BoardVO();
			
			bvo.setQna_writer(qna_writer);
			bvo.setQna_subject(qna_subject);
	//		bvo.setPnum(Integer.parseInt(pnum));	// 제품명 불러오기
			bvo.setQna_content(qna_content);
			bvo.setQna_file(qna_file);				// 파일첨부 테이블 생성
			
			InterBoardDAO bdao = new BoardDAO();
			
			int n = bdao.QnaWrite(bvo);
			
			String message = "";
			String loc = "";
			
			if (n==1) {	// DAO 에서 1 값이 return 됐을 경우 .
				message = "문의사항 작성이 완료되었습니다.";
				loc = request.getContextPath()+"/qnaList.shoes";	// 글목록으로 이동
			}
			else {
				message = "문의사항 작성에 실패했습니다.";
				loc = request.getContextPath()+"/qnaList.shoes";	// 경로 재설정
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/qnaMsg.jsp");
			}
			
		}
		
		else {	// 로그인을 하지 않은 경우
			
			String message = "로그인 후 1:1문의 작성이 가능합니다.";
			String loc = request.getContextPath()+"/n01_wonhyejin/login.shoes";	// 로그인 전용 문의 페이지로 이동
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/qnaMsg.jsp");	// view 단 페이지가 어디인지 알려준다.
			
		}
		

	}

}
