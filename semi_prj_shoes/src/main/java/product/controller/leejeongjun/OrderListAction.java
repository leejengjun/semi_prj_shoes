package product.controller.leejeongjun;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;
import product.model.leejeongjun.*;

public class OrderListAction extends AbstractController {
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.goBackURL(request);
		
		// === 로그인 유무 검사하기 === //
		boolean isLogIn = super.checkLogin(request);
  
		if(!isLogIn) {
			request.setAttribute("message", "주문내역을 조회하려면 먼저 로그인 부터 하세요!!");
			request.setAttribute("loc", "javascript:history.back()"); 
     
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		else {
			// *** 페이징 처리한 주문 목록 보여주기 *** //
			InterProductDAO_ljj pdao = new ProductDAO_ljj();
			
			// 1. 페이징 처리를 위해 1페이지당 보여줄 장바구니에 들어간 제품의 갯수를 몇개로 할 것인가를 정한다.
			//    한 페이지당 보여줄 장바구니에 들어간 제품의 갯수는 10개로 한다.
			int sizePerPage = 10;
			
			// 2. 페이징 처리한 데이터 조회 결과물 가져오기
			int totalPage = 0;
			
			// --- 주문내역에 들어있는 제품의 총갯수 구하기
			// *** 관리자가 아닌 일반사용자로 로그인 했을 경우에는 자신이 주문한 내역만 조회를 해오고, 
			//     관리자로 로그인을 했을 경우에는 모든 사용자들의 주문내역을 조회해온다.
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			String userid = loginuser.getUserid(); 
			
			// *** 주문내역에 대한 페이징 처리를 위해 주문 갯수를 알아오기 위한 것으로
			//     관리자가 아닌 일반사용자로 로그인 했을 경우에는 자신이 주문한 갯수만 알아오고,
			//     관리자로 로그인을 했을 경우에는 모든 사용자들이 주문한 갯수를 알아온다.
			int totalCountOrder = pdao.getTotalCountOrder(userid);
			
			totalPage = (int) Math.ceil( (double)totalCountOrder/sizePerPage );
            //                       17.0/10 = 1.7  ==> 2.0  ==> 2
            //                       20.0/10 = 2.0 ==> 2.0  ==> 2 
   
			// System.out.println("~~~ 확인용 totalPage : " + totalPage);
			
			//   -- 조회하고자 하는 페이지번호를 받아와야 한다.
			String str_currentShowPageNo = request.getParameter("currentShowPageNo"); 
			          
			int currentShowPageNo = 0;
			          
			try {
			     if(str_currentShowPageNo == null) {
			       currentShowPageNo = 1; 
			      }
			      else {
			        currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
			         
			        if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
			           currentShowPageNo = 1;
			        }
			      }
			 } catch (NumberFormatException e) {
			         currentShowPageNo = 1;
			 }
			
			// *** 관리자가 아닌 일반사용자로 로그인 했을 경우에는 자신이 주문한 내역만 페이징 처리하여 조회를 해오고,
	        //     관리자로 로그인을 했을 경우에는 모든 사용자들의 주문내역을 페이징 처리하여 조회해온다.
			List<Map<String, String>> orderList = pdao.getOrderList(userid, currentShowPageNo, sizePerPage);
			
		 //  -- 페이지바 만들기 
	        String url = "orderList.shoes";
	        int blockSize = 10;
	        //  blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 갯수이다.
	                  
	      //        1 2 3 4 5 6 7 8 9 10 [다음][마지막]                -- 1개 블럭
	      //  [처음][이전] 11 12 13 14 15 16 17 18 19 20 [다음][마지막]  -- 1개 블럭
	      //  [처음][이전] 21 22                                      -- 1개 블럭 
	         
	        int loop = 1;
	        // loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 갯수(위의 설명상 지금은 10(==blockSize)까지만 증가하는 용도이다.
	         
	        int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1; 
	        // *** !! 공식이다. !! *** // 
	        
	        String pageBar = "";
	         
	        // *** [맨처음][이전] 만들기 *** // 
	        if(pageNo != 1) {
	           pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo=1'>[맨처음]</a></li>";
	           pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
	        }
	         
	        while( !(loop > blockSize || pageNo > totalPage) ) {
	            
	           if(pageNo == currentShowPageNo) {
	              pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";  
	           }
	           else {
	              pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
	           }
	            
	           loop++;
	           pageNo++;
	        }// end of while----------------------
	         
	        // *** [다음][마지막] 만들기 *** // 
	        if( pageNo <= totalPage ) {
	            pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo="+pageNo+"'>[다음]</a></li>";
	            pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
	         }
			
	        request.setAttribute("orderList", orderList);
	        request.setAttribute("pageBar", pageBar);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/n01_leejeongjun/productPage/orderList.jsp");
		}
		
	}

}
