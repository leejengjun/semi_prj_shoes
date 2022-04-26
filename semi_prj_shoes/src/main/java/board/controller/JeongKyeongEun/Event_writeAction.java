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

public class Event_writeAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// == 관리자(admin)로 로그인 했을 때만 글쓰기가 가능하도록 해야 한다. == //
		HttpSession session = request.getSession();   // session 정보를 본다.
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");  // 세션에 가서 있는지 없는지 확인 한다.
		
		if( loginuser != null && "admin".equals(loginuser.getUserid()) ) {
			// 로그인되지 않았거나    일반사용자로 로그인 한 경우(관리자가 아닌 경우)
			
			String method = request.getMethod(); // GET 또는 POST
			
			if(!"post".equalsIgnoreCase(method)) {	
			
			//	super.setViewPage("/WEB-INF/n01_JeongKyeongEun/event_write.jsp");
				super.setViewPage("/WEB-INF/n01_JeongKyeongEun/event_write.jsp");
			
			}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
			else {	// POST 방식이면 문의사항 게시글에 insert 한 후 결과를 출력한다.
				
				/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                파일을 첨부해서 보내는 폼태그가 enctype="multipart/form-data" 으로 되어었다라면
		           HttpServletRequest request 을 사용해서는 데이터값을 받아올 수 없다.
		           이때는 cos.jar 라이브러리를 다운받아 사용하도록 한 후  
		           아래의 객체를 사용해서 데이터 값 및 첨부되어진 파일까지 받아올 수 있다.
		           !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!    
		       */
				
				MultipartRequest mtrequest = null;
				/*
	             	MultipartRequest mtrequest 은 
	             	HttpServletRequest request 가 하던일을 그대로 승계받아서 일처리를 해주고 
	                동시에 파일을 받아서 업로드, 다운로드까지 해주는 기능이 있다.      
				 */
				
				
				// 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다.
				ServletContext svlCtx = session.getServletContext();
				String uploadFileDir = svlCtx.getRealPath("/images/JeongKyeongEun");
				
	//		    System.out.println("=== 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> " + uploadFileDir);
				//=== 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> C:\NCS\workspace(jsp)\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\semi_prj_shoes\images\JeongKyeongEun
				
				/*
	             MultipartRequest의 객체가 생성됨과 동시에 파일 업로드가 이루어 진다.
	                   
	             MultipartRequest(HttpServletRequest request,           ----> 파라미터에 있는 생성자
	                              String saveDirectory, -- 파일이 저장될 경로
		                          int maxPostSize,      -- 업로드할 파일 1개의 최대 크기(byte)
		                          String encoding,
		                          FileRenamePolicy policy) -- 중복된 파일명이 올라갈 경우 파일명다음에 자동으로 숫자가 붙어서 올라간다.   
	                  
	             파일을 저장할 디렉토리를 지정할 수 있으며, 업로드제한 용량을 설정할 수 있다.(바이트단위). 
	             이때 업로드 제한 용량을 넘어서 업로드를 시도하면 IOException 발생된다. 
	             또한 국제화 지원을 위한 인코딩 방식을 지정할 수 있으며, 중복 파일 처리 인터페이스를사용할 수 있다.
	                        
	             이때 업로드 파일 크기의 최대크기를 초과하는 경우이라면 
	             IOException 이 발생된다.
	             그러므로 Exception 처리를 해주어야 한다.                
	          */
				
				// ===== 파일을 업로드 해준다. 시작 ===== //
				
				try {  // 잘못됐을때는 이렇게 끝난다.
					mtrequest = new MultipartRequest(request, uploadFileDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy() );
				} catch (IOException e) {
					e.printStackTrace();
					
					request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대용량 10MB를 초과했으므로 파일업로드 실패함!!");
	                request.setAttribute("loc", request.getContextPath()+"/event_write.shoes");  // 안 되면 여기 확인
	              
	                super.setViewPage("/WEB-INF/msg.jsp");
	                return; // 종료
				}
			
			// ===== 파일을 업로드 해준다. 끝 ===== //
				
				
				
				// === 첨부 이미지 파일을 올렸으니 그 다음으로 글 정보를 (아이디, 제목, 글내용,...) DB의 tbl_board_event 테이블에 insert 를 해주어야 한다.  ===
				
				// 새로운 제품 등록시 form 태그(jsp)에서 입력한 값들을 얻어오기
				String e_userid = mtrequest.getParameter("e_userid");
				String e_title = mtrequest.getParameter("e_title");
				String e_contents = mtrequest.getParameter("e_contents");
				
				// 시큐어 코드
				e_contents = e_contents.replaceAll("<", "&lt;");
				e_contents = e_contents.replaceAll(">", "&gt;");
				
				e_contents = e_contents.replace("\r\n", "<br>");
				// 업로드되어진 시스템의 첨부파일 이름(파일서버에 업로드 되어진 실제파일명)을 얻어 올때는 
	            // cos.jar 라이브러리에서 제공하는 MultipartRequest 객체의 getFilesystemName("form에서의 첨부파일 name명") 메소드를 사용 한다. 
	            // 이때 업로드 된 파일이 없는 경우에는 null을 반환한다.
				
				String e_file = mtrequest.getFilesystemName("e_file");  // 실제 파일서버에 올라간 파일명!!!!!!
				String e_file_originFileName = mtrequest.getOriginalFileName("e_file");
				
				
				BoardEventVO bvo = new BoardEventVO();
				
				bvo.setE_userid(e_userid);
				bvo.setE_title(e_title);
				bvo.setE_contents(e_contents);
				bvo.setE_file(e_file);				// 파일첨부 테이블 생성
				
				InterBoardEventDAO bdao = new BoardEventDAO();
				
				int n = bdao.eventWrite(bvo);
				
				String message = "";
				String loc = "";
				
				if (n==1) {	// DAO 에서 1 값이 return 됐을 경우 .
					message = "이벤트 게시판 글 작성이 완료되었습니다.";
					loc = request.getContextPath()+"/event.shoes";	// 글목록으로 이동
				}
				else {
					message = "이벤트 게시판 글 작성에 실패했습니다.";
					loc = request.getContextPath()+"/index.shoes";	// 경로 재설정
				}
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				}	
			}	
	////////////////////////////////////////////////////////////////////////////////////////////////	
		
		else {	// 로그인을 하지 않은 경우
			
			String message = "관리자만 이벤트 게시판 글 작성이 가능합니다.";
			String loc = request.getContextPath()+"/index.shoes";	// 로그인 전용 문의 페이지로 이동
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");	// view 단 페이지가 어디인지 알려준다.
			
		}
	}
}