package board.controller.JeongKyeongEun;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.JeongKyeongEun.BoardDAO;
import board.model.JeongKyeongEun.BoardVO;
import board.model.JeongKyeongEun.InterBoardDAO;
import common.controller.AbstractController;
import my.util.jke.MyUtil;

public class NoticeAction extends AbstractController {

	InterBoardDAO bdao = new BoardDAO();		// DAO 에서 가져온다.
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 검색이 있을 경우 시작 //
		String searchType = request.getParameter("searchType");  // searchType 이게 컬럼명
		String searchWord = request.getParameter("searchWord");
		// 검색이 있을 경우 끝 //
		
		InterBoardDAO bdao = new BoardDAO();
		  
	    Map<String, String> paraMap = new HashMap<>();
		
	    String currentShowPageNo = request.getParameter("currentShowPageNo");
		// currentShowPageNo 은 사용자가 보고자 하는 페이지바의 페이지번호 이다.
		// 메뉴에서 공지사항만을 클릭했을 경우에는 currentShowPageNo 은 null 이 된다.
		// currentShowPageNo 이 null 이라면 currentShowPageNo 을 1 페이지로 바꾸어야 한다.
		
		String sizePerPage = request.getParameter("sizePerPage");
		// 한 페이지당 화면상에 보여줄 글의 개수
		// 메뉴에서 공지사항만을 클릭했을 경우에는 sizePerPage 는 null 이 된다.
		// sizePerPage 가 null 이라면 sizePerPage 를 10 으로 바꾸어야 한다.
		// "10" 또는 "5" 또는 "3" 
		
		if(currentShowPageNo == null) { // 현재페이지에 null 이 들어왔다면 1 페이지를 보여준다.
			currentShowPageNo = "1";
		}
		
		// 한 페이지 당 볼 글의 개수를 선택하지 않으면 기본적으로 10개씩 보여주도록 한다.
		if(sizePerPage == null || 
		   !("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage)) ) {
			sizePerPage = "10";
		}
	    
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자가 아닌 문자를 입력한 경우 또는 
		//     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
		try {
			Integer.parseInt(currentShowPageNo);
		} catch(NumberFormatException e) { // 문자 써올때 1페이지로 가도록한다.
			currentShowPageNo = "1";
		}
		// DB로 보낸다.
		paraMap.put("sizePerPage", sizePerPage);   // getTotalPage 에서 sizePerPage 를 잡아줘야한다. totalPage 보다 밑에 있으면 페이지바가 안 뜬다.
		
		///////////////////////////////////////////////////////////////
		
		
		// 검색이 있을 경우 시작 //
		if(searchType != null && !"".equals(searchType) && !"n_title".equals(searchType) && !"n_userid".equals(searchType)) {
			// 사용자가 웹브라우저 주소입력란에서 searchType 란에 장난친 경우
			// 유저가 장난쳐 온 경우이기 때문에 이 밑으로 내려가면 안 된다. 여기서 끝냄
			String message = "부적절한 검색입니다.";
			String loc = request.getContextPath()+"/notice.shoes";  // 공지사항 목록페이지로 이동
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;  // execute() 메소드를 종료시킨다.
		}
		
		paraMap.put("searchType", searchType); // 3개가 맞으면 받아줄 것이다.
		paraMap.put("searchWord", searchWord);
		// 검색이 있을 경우 끝 //
		
		//////////////////////////////////////////////////////////////////////////////////
		
		
		// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 공지사항 글에 대한 총 페이지 알아오기(db에 가야한다.)
		int totalPage = bdao.getTotalPage(paraMap);
	//	System.out.println("확인용 totalPage : " + totalPage);
		// 확인용 totalPage : 4

		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 토탈페이지 수 보다 큰 값을 입력하여 
		//     장난친 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
		if(Integer.parseInt(currentShowPageNo) > totalPage) {
			currentShowPageNo = "1";  //  그 다음에 맵에 넘어가야 한다.
		}
		
		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		// 공지사항 목록 조회 & 페이징 처리가 된 모든 게시글 또는 검색한 글 목록
		List<BoardVO> noticeList = bdao.selectPagingNotice(paraMap); // 테이블에 기록된 모든 글들을 조회해온다.		 	
				
		request.setAttribute("noticeList",  noticeList);		// view 단으로 넘겨서 출력한다.
		request.setAttribute("sizePerPage", sizePerPage);	// view 단으로 넘겨서 출력한다.
		
		
		// **** ============ 페이지바 만들기 시작 ============ **** //
		/*
        1개 블럭당 10개씩 잘라서 페이지 만든다.
        
        1개 페이지당 3개행 또는 5개행 또는  10개행을 보여주는데
            만약에 1개 페이지당 5개행을 보여준다라면 
            총 몇개 블럭이 나와야 할까? 
            총 게시글이 207개 이고, 1개 페이지당 보여줄 게시글이 5 라면
        207/5 = 41.4 ==> 42(totalPage)        
            
        1블럭          1  2  3  4  5  6  7  8  9 10 [다음]
        2블럭   [이전] 11 12 13 14 15 16 17 18 19 20 [다음]
        3블럭   [이전] 21 22 23 24 25 26 27 28 29 30 [다음]
        4블럭   [이전] 31 32 33 34 35 36 37 38 39 40 [다음]
        5블럭   [이전] 41 42 
     */
		
	// ==== !!! pageNo 구하는 공식 !!! 테이블 행의 개수가 아니라 밑에 페이지바에 표시되는 숫자의 개수이다. ==== // 
      /*
          1  2  3  4  5  6  7  8  9  10  -- 첫번째 블럭의 페이지번호 시작값(pageNo)은  1 이다.
          11 12 13 14 15 16 17 18 19 20  -- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.   
          21 22 23 24 25 26 27 28 29 30  -- 세번째 블럭의 페이지번호 시작값(pageNo)은 21 이다.
          
           currentShowPageNo        pageNo  ==> ( (currentShowPageNo - 1)/blockSize ) * blockSize + 1 
          ---------------------------------------------------------------------------------------------
                 1                   1 = ( (1 - 1)/10 ) * 10 + 1
                 2                   1 = ( (2 - 1)/10 ) * 10 + 1     ===> 자바 계산을 따라야 함. 정수타입이니까 0.1이 아니라 0임.
                 3                   1 = ( (3 - 1)/10 ) * 10 + 1 
                 4                   1 = ( (4 - 1)/10 ) * 10 + 1  
                 5                   1 = ( (5 - 1)/10 ) * 10 + 1 
                 6                   1 = ( (6 - 1)/10 ) * 10 + 1 
                 7                   1 = ( (7 - 1)/10 ) * 10 + 1 
                 8                   1 = ( (8 - 1)/10 ) * 10 + 1 
                 9                   1 = ( (9 - 1)/10 ) * 10 + 1 
                10                   1 = ( (10 - 1)/10 ) * 10 + 1 
                 
                11                  11 = ( (11 - 1)/10 ) * 10 + 1 
                12                  11 = ( (12 - 1)/10 ) * 10 + 1
                13                  11 = ( (13 - 1)/10 ) * 10 + 1
                14                  11 = ( (14 - 1)/10 ) * 10 + 1
                15                  11 = ( (15 - 1)/10 ) * 10 + 1
                16                  11 = ( (16 - 1)/10 ) * 10 + 1
                17                  11 = ( (17 - 1)/10 ) * 10 + 1
                18                  11 = ( (18 - 1)/10 ) * 10 + 1 
                19                  11 = ( (19 - 1)/10 ) * 10 + 1
                20                  11 = ( (20 - 1)/10 ) * 10 + 1
                 
                21                  21 = ( (21 - 1)/10 ) * 10 + 1 
                22                  21 = ( (22 - 1)/10 ) * 10 + 1
                23                  21 = ( (23 - 1)/10 ) * 10 + 1
                24                  21 = ( (24 - 1)/10 ) * 10 + 1
                25                  21 = ( (25 - 1)/10 ) * 10 + 1
                26                  21 = ( (26 - 1)/10 ) * 10 + 1
                27                  21 = ( (27 - 1)/10 ) * 10 + 1
                28                  21 = ( (28 - 1)/10 ) * 10 + 1 
                29                  21 = ( (29 - 1)/10 ) * 10 + 1
                30                  21 = ( (30 - 1)/10 ) * 10 + 1                    

       */
		
		String pageBar = "";
		// 페이지 숫자 버튼의 개수
		int blockSize = 3;  // blockSize 사이즈는(몇개) 블럭당 보여지는 페이지 번호의 개수이다.
		
		int loop = 1;
		// loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(blockSize 지금은 10개)까지만 증가하는 용도이다.
		
		// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! //
		int pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
		// pageNo 는 페이지 바에서 보여지는 첫번째 번호이다.  1번, 11번, 21번~
		
		if(searchType == null) { // 자바는 null 이다.
			searchType = ""; // 이렇게 바꿔줘야 한다.
		}
		if(searchWord == null) {
			searchWord = "";
		}
		
		// **** ============ [맨처음] [이전] 만들기 =========== **** // 
		if(pageNo != 1) {
		pageBar += "<li class='page-item'><a class='page-link' href='notice.shoes?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[맨처음]</a></li>";
		pageBar += "<li class='page-item'><a class='page-link' href='notice.shoes?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[이전]</a></li>";
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) { // 10번 반복
			
			if(pageNo == Integer.parseInt(currentShowPageNo)) { // 내가 선택한 번호 가 현재 보여주는 페이지 번호와 같다면
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
			}
			else { // 내가 선택하지 않은 번호
				pageBar += "<li class='page-item'><a class='page-link' href='notice.shoes?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a></li>";				
			}
			loop++;
			pageNo++;
		}// end of while----------------------------------------------
		
		// **** ============ [다음] [마지막] 만들기 =========== **** // 
		// pageNo ==> 11
		if(pageNo <= totalPage ) { // 마지막 페이지가 아닐 때만 보여준다.
			pageBar += "<li class='page-item'><a class='page-link' href='notice.shoes?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[다음]</a></li>";			
			pageBar += "<li class='page-item'><a class='page-link' href='notice.shoes?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[마지막]</a></li>";
		}
		
		request.setAttribute("pageBar", pageBar); 
		// **** ============ 페이지바 만들기 끝 ============ **** //
		
		
		
		
		
		// **** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 **** //
		// 여기서만 쓰이는 게 아니니까 메소드로 빼야한다.
		String currentURL = MyUtil.getCurrentURL(request);
		// 게시글을 조회 했을시 현재 그 페이지로 그대로 되돌아가기 위한 용도로 쓰임.
		
	//	System.out.println("확인용 currentURL => " +currentURL);
		/*
		 확인용 currentURL => /notice.shoes
		 확인용 currentURL => /notice.shoes?sizePerPage=10&searchWord=admin&searchType=n_userid

		 */
		
		currentURL = currentURL.replaceAll("&", " ");
	//	System.out.println("확인용 currentURL => " +currentURL);
		/*
		 확인용 currentURL => /notice.shoes
		 확인용 currentURL => /notice.shoes?sizePerPage=10 searchWord=admin searchType=n_userid

		 */
		
		request.setAttribute("goBackURL", currentURL);
		
	// 위에서 null 을 ""로 바꿨다. null 인 경우가 존재하지 않기 때문에 if 를 쓸 필요가 없다. 그냥 하면 됨
	//	if(searchType != null && searchWord != null) { // 검색했을 때만 넘겨준다!!
			// 검색한 것 유지시키기(검색했을때만 유지)
		request.setAttribute("searchType", searchType);
		request.setAttribute("searchWord", searchWord);
	//	}
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/n01_JeongKyeongEun/notice.jsp");
		
		
	}

}
