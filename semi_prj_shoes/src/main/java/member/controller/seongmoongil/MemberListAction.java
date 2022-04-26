package member.controller.seongmoongil;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.wonhyejin.*;
import my.util.MyUtil;




public class MemberListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.goBackURL(request);
		
		// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 해야 한다. == //
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if( loginuser == null || !"admin".equals(loginuser.getUserid()) ) {
			// 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우
			String message = "관리자만 접근이 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		else {
			// 관리자(admin)로 로그인 했을 경우 
			// == 페이징 처리가 되어진 모든 회원 또는 검색한 회원 목록 보여주기 == //
			String searchType = request.getParameter("searchType");
			String searchWord = request.getParameter("searchWord");

			
			InterMemberDAO mdao = new MemberDAO();
			
			Map<String, String> paraMap = new HashMap<>();
			
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			
			String sizePerPage = request.getParameter("sizePerPage");
			
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			
			if(sizePerPage == null || 
			   !("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage)) ) {
				sizePerPage = "10";
			}
			

			try {
				Integer.parseInt(currentShowPageNo);
			} catch(NumberFormatException e) {
				currentShowPageNo = "1";
			}
			
			paraMap.put("sizePerPage", sizePerPage);
			
			if(searchType != null && !"".equals(searchType) && !"name".equals(searchType) && !"userid".equals(searchType) && !"email".equals(searchType)) {
				String message = "부적절한 검색 입니다.";
				String loc = request.getContextPath()+"/admin/memberList.shoes";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				return; 
			}
			
			paraMap.put("searchType", searchType); 
			paraMap.put("searchWord", searchWord); 

			int totalPage = mdao.getTotalPage(paraMap);
			
			if( Integer.parseInt(currentShowPageNo) > totalPage ) {
				currentShowPageNo = "1";
			}
			
			paraMap.put("currentShowPageNo", currentShowPageNo);
			
			List<MemberVO> memberList = mdao.selectPagingMember(paraMap);
			
			request.setAttribute("memberList", memberList);
			request.setAttribute("sizePerPage", sizePerPage);
			
			
			String pageBar = "";
			
			int blockSize = 10;
			
			int loop = 1;
			
			int pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
			
			if(searchType == null) {
				searchType = "";
			}
			
			if(searchWord == null) {
				searchWord = "";
			}
			
			// **** [맨처음][이전] 만들기 **** //
			if( pageNo != 1 ) {
				pageBar += "<li class='page-item'><a class='page-link' href='memberList.shoes?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[맨처음]</a></li>"; 
				pageBar += "<li class='page-item'><a class='page-link' href='memberList.shoes?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[이전]</a></li>";  
			}
						
			while( !(loop > blockSize || pageNo > totalPage) ) {
			
				if( pageNo == Integer.parseInt(currentShowPageNo) ) {
					pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='memberList.shoes?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a></li>";   
				}
				
				loop++;
				pageNo++;
			}// end of while---------------------------------
			
			// **** [다음][마지막] 만들기 **** //
			// pageNo ==> 11
			if( pageNo <= totalPage ) {
				pageBar += "<li class='page-item'><a class='page-link' href='memberList.shoes?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[다음]</a></li>";  
				pageBar += "<li class='page-item'><a class='page-link' href='memberList.shoes?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[마지막]</a></li>"; 
			}
			
			request.setAttribute("pageBar", pageBar); 
			// **** ============ 페이지바 만들기 끝 ============ **** //
			
			// **** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 **** //
			String currentURL = MyUtil.getCurrentURL(request);
			// 회원조회를 했을시 현재 그 페이지로 그대로 되돌아가기 위한 용도로 쓰임.
			
			
			currentURL = currentURL.replaceAll("&", " ");
			
			request.setAttribute("goBackURL", currentURL);
			
			request.setAttribute("searchType", searchType);
			request.setAttribute("searchWord", searchWord);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/n01_seongmoongil/admin/memberList.jsp");
		}
		
	}

}
