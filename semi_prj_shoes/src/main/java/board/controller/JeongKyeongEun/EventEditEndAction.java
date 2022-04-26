package board.controller.JeongKyeongEun;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.model.JeongKyeongEun.BoardEventDAO;
import board.model.JeongKyeongEun.BoardEventVO;
import board.model.JeongKyeongEun.InterBoardEventDAO;
import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;

public class EventEditEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 정보를 update 하는 과정이 필요하다. --> 기존 글 내용에서 새롭게 DB에 업데이트 하는 것.
		// 글 수정을 위해서는 우선 로그인 상태여야 한다.
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String method = request.getMethod();
		
		
		if("post".equalsIgnoreCase(method)) { 
			// post 방식으로 글수정 했다면,

			
			MultipartRequest mtrequest = null;

			// 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다.
			ServletContext svlCtx = session.getServletContext();
			String uploadFileDir = svlCtx.getRealPath("/images/JeongKyeongEun");
			
//				    System.out.println("=== 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> " + uploadFileDir);

			
			// ===== 파일을 업로드 해준다. 시작 ===== //
			
			try { 
				
				mtrequest = new MultipartRequest(request, uploadFileDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy() );
			
			} catch (IOException e) { // 잘못됐을때는 이렇게 끝난다.
				e.printStackTrace();
				
				request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대용량 10MB를 초과했으므로 파일업로드 실패함!!");
                request.setAttribute("loc", request.getContextPath()+"/eventEdit.shoes");  // 안 되면 여기 확인

				
				
                super.setViewPage("/WEB-INF/msg.jsp");
                return; // 종료
			}
		
		// ===== 파일을 업로드 해준다. 끝 ===== //		
		
				// 올바른 접근방식. GET 방식이면 안된다.
				
			// hidden form 태그로 받은 글정보를 bvo에 넣는다.
			String e_userid = mtrequest.getParameter("e_userid");
			String e_title = mtrequest.getParameter("e_title");
			String e_contents = mtrequest.getParameter("e_contents");
			String e_file = mtrequest.getFilesystemName("e_file");  // 실제 파일서버에 올라간 파일명!!!!!!
			int event_no = Integer.parseInt(mtrequest.getParameter("event_no"));
			// 시큐어 코드
			e_contents = e_contents.replaceAll("<", "&lt;");
			e_contents = e_contents.replaceAll(">", "&gt;");
			
			e_contents = e_contents.replace("\r\n", "<br>");
			// 업로드되어진 시스템의 첨부파일 이름(파일서버에 업로드 되어진 실제파일명)을 얻어 올때는 
            // cos.jar 라이브러리에서 제공하는 MultipartRequest 객체의 getFilesystemName("form에서의 첨부파일 name명") 메소드를 사용 한다. 
            // 이때 업로드 된 파일이 없는 경우에는 null을 반환한다.
			
			
			String e_file_originFileName = mtrequest.getOriginalFileName("e_file");
			
			
			BoardEventVO bvo = new BoardEventVO();
			
			bvo.setE_userid(e_userid);
			bvo.setE_title(e_title);
			bvo.setE_contents(e_contents);
			bvo.setE_file(e_file);				// 파일첨부 테이블 생성
			bvo.setEvent_no(event_no);
			
			InterBoardEventDAO bdao = new BoardEventDAO();
			
			int n = bdao.EventEdit(bvo);
			
			String message = "";
			String loc = "";
			
			if (n==1) {	// DAO 에서 1 값이 return 됐을 경우 .
				message = "이벤트 게시판 글 수정이 완료되었습니다.";
				loc = request.getContextPath()+"/event_contents.shoes?event_no="+event_no;	// 수정된 글 내용 보여주기
			}
			else {
				message = "이벤트 게시판 글 수정에 실패했습니다.";
				loc = request.getContextPath()+"/index.shoes";	// 경로 재설정
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			}	
			
////////////////////////////////////////////////////////////////////////////////////////////////	
	//	super.setRedirect(false);
	//	super.setViewPage("/WEB-INF/n01_JeongKyeongEun/event_write.jsp");
	
			else {	// 로그인을 하지 않은 경우
				
				String message = "관리자만 이벤트 게시판 글 수정이 가능합니다.";
				String loc = request.getContextPath()+"/index.shoes";	// 로그인 페이지로 이동
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");	// view 단 페이지가 어디인지 알려준다.
				
			}
		}
	}