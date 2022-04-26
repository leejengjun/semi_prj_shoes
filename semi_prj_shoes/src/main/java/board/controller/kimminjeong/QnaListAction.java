package board.controller.kimminjeong;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.kimminjeong.BoardDAO;
import board.model.kimminjeong.BoardVO;
import board.model.kimminjeong.InterBoardDAO;
import common.controller.AbstractController;

public class QnaListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임.
		  super.goBackURL(request);	 
		
		  // == 페이징 처리가 된 모든 글 목록 또는 검색한 회원 목록 보여주기 == //
		  // 검색이 있을 경우 시작 //
		  String searchType = request.getParameter("searchType");
		  String searchWord = request.getParameter("searchWord");		  
		  // 검색이 있을 경우 끝 //
		  
		  InterBoardDAO bdao = new BoardDAO();
		  
		  Map<String, String> paraMap = new HashMap<>();
		  
		  // 현재 페이지 no
		  String currentShowPageNo = request.getParameter("currentShowPageNo");
		  
		  // 한 페이지당 보여줄 글의 갯수
		  String sizePerPage = request.getParameter("sizePerPage");
		  
		  if(currentShowPageNo == null) {
			  // 페이지바에서 선택한 값이 없을 때 (null) default 로 1페이지로 가도록 한다.
			  currentShowPageNo = "1";  
		  }
		  
		  if(sizePerPage == null ||
					// 회원목록만을 클릭했을 때, 맨 처음 1 페이지당 보여질 개수는 10개로 기본값을 해줘야 한다. // 3개 / 5개 / 10개이외의 것을 선택하면, 기본 페이지는 10개가 보이도록 한다.
					!("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage))) {
			  sizePerPage = "10";
		  }
		  
		  try {
			  Integer.parseInt(currentShowPageNo);
		  } catch (NumberFormatException e) {
			  currentShowPageNo ="1";
		  }
		  
		  
		  // DB로 보낸다.
		  paraMap.put("sizePerPage", sizePerPage);
		  
		  if(searchType != null && !"".equals(searchType) && !"qna_subject".equals(searchType) && !"qna_content".equals(searchType) && !"qna_writer".equals(searchType)) {
			  
			  String message = "부적절한 검색입니다.";
			  String loc = request.getContextPath()+"/qnaList.shoes";	// 원래 글목록으로 이동
		  
			  request.setAttribute("message", message);
			  request.setAttribute("loc", loc);
		  
		//	  super.setRedirect(false);
			  super.setViewPage("/WEB-INF/qnaMsg.jsp");
			  
			  return;	// execute() 메소드 종료
		  }

		  paraMap.put("searchType", searchType);
		  paraMap.put("searchWord", searchWord);

	   // 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 회원에 대한 총 페이지 알아오기.
		  int totalPage = bdao.getTotalPage(paraMap);
		  
		  // totalPage 이상의 수를 입력했을 때 1 페이지로 이동하도록 한다.
		  if(Integer.parseInt(currentShowPageNo) > totalPage) {
			  currentShowPageNo = "1";
		  };

		  paraMap.put("currentShowPageNo", currentShowPageNo);
		  
		  // 글쓰기 목록 조회 & 페이징 처리가 된 모든 회원 또는 검색한 회원 목록
		  List<BoardVO> qnaList = bdao.selectAllQna(paraMap); // Qna 게시판에 들어왔을 때 Qna 테이블에 기록된 모든 글들을 조회해온다.		 	
		
		  request.setAttribute("qnaList", qnaList);	// view 단으로 넘겨서 출력한다.
		  request.setAttribute("sizePerPage", sizePerPage);	// view 단으로 넘겨서 출력한다.
		  		  
		  
		  // *** 페이지바 시작 *** //
		  String pageBar = "";
		  
		  int blocksize = 3;
		  
		  int loop = 1;
		  
		  int pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blocksize ) * blocksize + 1;
		  
		  if(searchType == null) {
			  searchType = "";
		  }
		  if(searchWord == null) {
			  searchWord = "";
		  }
		  
		  // [맨처음][이전] 버튼 만들기 		  
		  if(pageNo != 1) {
				pageBar += "<li class='page-item'><a class='page-link' href='qnaList.shoes?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>◀◀</a></li>";
				pageBar += "<li class='page-item'><a class='page-link' href='qnaList.shoes?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>◀</a></li>";
		  }
		  
		  while ( !( loop > blocksize || pageNo > totalPage ) ) {

			if(pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='qnaList.shoes?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a></li>";
			} 
			
			loop++;
			pageNo++;
			
		  }// end of while ( !( loop > blocksize || pageNo > totalPage ) ) {}------------


		  // [다음][마지막] 버튼 만들기
		  if(pageNo <= totalPage) {
				pageBar += "<li class='page-item'><a class='page-link' href='qnaList.shoes?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>▶</a></li>";
				pageBar += "<li class='page-item'><a class='page-link' href='qnaList.shoes?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>▶▶</a></li>";					  
		  }
		  
		  request.setAttribute("pageBar", pageBar);
		  
//		  int pageNo = ((Integer.parseInt(currentShowPageNo) - 1)/blocksize) * blocksize + 1;
		  
		  // *** 페이지바 만들기 끝 *** //
		  		  
		  request.setAttribute("searchType", searchType);
		  request.setAttribute("searchWord", searchWord);		  
		  
	//	super.setRedirect(false);	  
		super.setViewPage("/WEB-INF/n01_kimminjeong/QnaList.jsp");	// view 단 페이지가 어디인지 알려준다.

	}

}
