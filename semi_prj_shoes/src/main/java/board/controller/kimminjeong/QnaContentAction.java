package board.controller.kimminjeong;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.kimminjeong.BoardDAO;
import board.model.kimminjeong.BoardVO;
import board.model.kimminjeong.CommentDAO;
import board.model.kimminjeong.CommentVO;
import board.model.kimminjeong.InterBoardDAO;
import board.model.kimminjeong.InterCommentDAO;
import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;

public class QnaContentAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 로그인 한 유저가 누구인지 알아오자.
		// 문의사항 글을 보기 위해서는 글 작성자 또는 운영자여야 한다.
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");

		// 게시글 번호는 게시글 select where 과 댓글 select where 위해서 사용한다.
		String qna_num = request.getParameter("qna_num");
		// 글작성자, 운영자 구분
		// 아예 넘길 때 id 값을 넘기자. (이름을 넘기게 되면 동명이인이 엄청 많기 때문이다.
		String qna_writer = request.getParameter("qna_writer");	
		
		String message = "";
		String loc = "";

	//	System.out.println("확인용 loginuser ==> " +loginuser);
	//	System.out.println("확인용 qna_writer ==> " +qna_writer);

		
		// 여기서도 이름이 아니라 id 값을 받게 되면 아래의 if 문에서 두번 검증할 필요 없이
		// if 문 한줄로 끝낼 수 있다 --> 수정이 필요하다!!
		if(loginuser != null && qna_writer != null) {	
			// 로그인 상태이며, 작성자만 자신의 글을 볼 수 있다.
			
			if(qna_writer.equals(loginuser.getUserid()) || "admin".equals(loginuser.getUserid())) {
				// 글작성자 == 로그인 한 userid or 운영자만 볼 수 있도록 한다.
				
				InterBoardDAO bdao = new BoardDAO();			

				BoardVO bvo = bdao.selectOneQna(qna_num);	// 해당 글번호에 맞는 게시글을 조회해온다.
				
				// 조회수 증가 시작(qna_viewCnt)
				int n = bdao.updateViewCount(Integer.parseInt(qna_num));
	
				if(n==1) {
					// DAO update 성공 시 qna_viewCnt + 1 (조회수 1 증가)
				//	System.out.println("게시글 조회수 update 성공");
				}
				else {
					// 조회하지 않았다면 오류
				//	System.out.println("게시글 조회수 update 실패");
					return;
				}	
				// 조회수 증가 끝
				
				if(bvo != null) {
					// 해당 글의 댓글 조회하기
					
					InterCommentDAO cdao = new CommentDAO();
					
					List<CommentVO> commentList = cdao.commentList(qna_num);
					
					request.setAttribute("commentList", commentList);
				}
								
				request.setAttribute("bvo", bvo);
			//	System.out.println("bvo 출력 : "+ bvo);
				super.setViewPage("/WEB-INF/n01_kimminjeong/QnaContent.jsp");	// view 단 페이지가 어디인지 알려준다.
				
			}
			
			else {
				// 글작성자 or 운영자가 아닐 때 
				message = "문의사항은 작성자 본인만 확인이 가능합니다.";
				loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);			
				super.setViewPage("/WEB-INF/qnaMsg.jsp");				
			}
			
		}
		else {
			// 로그인을 하지 않았을 때
			message = "로그인 후 서비스 이용이 가능합니다.";
			loc = request.getContextPath()+"/n01_wonhyejin/login.shoes";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);			
			super.setViewPage("/WEB-INF/qnaMsg.jsp");
		}
		
		
	}
	
}	
