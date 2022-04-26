package board.controller.JeongKyeongEun;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.JeongKyeongEun.BoardEventDAO;
import board.model.JeongKyeongEun.BoardEventVO;
import board.model.JeongKyeongEun.InterBoardEventDAO;
import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;

public class Event_contentsAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 로그인 한 유저가 누구인지 알아오자.
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// 게시글 번호는 게시글 select where 을 위해서 사용한다.
		String event_no = request.getParameter("event_no");
		
		InterBoardEventDAO bdao = new BoardEventDAO();
					
		BoardEventVO bvo = bdao.selectOneEvent(event_no);	// 해당 글번호에 맞는 게시글을 조회해온다.
		
		request.setAttribute("bvo", bvo);

	//	System.out.println("bvo 출력 : "+ bvo);
		
		super.setViewPage("/WEB-INF/n01_JeongKyeongEun/event_contents.jsp");	// view 단 페이지가 어디인지 알려준다.

		
	}

}
