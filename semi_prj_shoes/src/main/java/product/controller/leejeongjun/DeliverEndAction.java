package product.controller.leejeongjun;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;
import product.model.leejeongjun.InterProductDAO_ljj;
import product.model.leejeongjun.ProductDAO_ljj;


public class DeliverEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
	      
		if(!"POST".equalsIgnoreCase(method)) {
			String message = "비정상적인 경로로 들어왔습니다.";
			String loc = "javascript:history.back();";
			 
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			 
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			 
			return; // 종료 
		}
		
		// === 로그인 유무 검사하기 === //
	    boolean isLogIn = super.checkLogin(request);
	      
	    if(!isLogIn) {
	        request.setAttribute("message", "주문에 대한 소유주를 조회하려면 먼저 로그인 부터 하세요!!");
	        request.setAttribute("loc", "javascript:history.back()"); 

	   //   super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
	        return;
	    }
	    
	    else {
	         HttpSession session = request.getSession();
	         
	         MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
	         String userid = loginuser.getUserid();
	         
	         if(!"admin".equals(userid) ) {
	            String message = "접근불가!! 관리자가 아닙니다.";
	            String loc = "javascript:history.back()";
	            
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
	            
	            super.setRedirect(false);
	            super.setViewPage("/WEB-INF/msg.jsp");
	            
	            return;
	         }
	         
	         else {
	        	 // "admin" 으로 로그인 한 경우(관리자)이라면
	        	 String[] odrcodeArr = request.getParameterValues("odrcode");
	        	 String[] pnumArr = request.getParameterValues("pnum");
	        	 
	        	 StringBuilder sb = new StringBuilder();
	        	 /*
	        	  	's20220414-9/62','s20220412-8/6','s20220412-8/4','s20220412-5/5','s20220412-5/4'
	        	 	's20220414-9 은 주문코드(전표)' 이고 / 뒤에 붙은 60은 제품번호이다.
	        	 	이것은 오라클에서 주문코드(전표)컬럼||'/'||제품번호컬럼으로 사용하기 위한 데이터 값을 만들려고 한다.
	        	 */
	        	 
	        	 for(int i=0; i < odrcodeArr.length; i++) {
	        		 sb.append("\'"+odrcodeArr[i]+"/"+pnumArr[i]+"\',");
	        		 // sql 문의 where 절에 fk_odrcode || '/' || fk_pnum in('전표/제품번호','전표/제품번호','전표/제품번호') 을 사용하기 위한 것이다.
	        	 }// end of for------------------------------------
	        	
	        	 String odrcodePnum = sb.toString();
	        	 
	        	 // 맨뒤의 콤마(,)제거하기
	        	 odrcodePnum = odrcodePnum.substring(0, odrcodePnum.length()-1);
	        	 
	        //	 System.out.println("~~~~~ 확인용 odrcodePnum => "+odrcodePnum);
	        	// ~~~~~ 확인용 odrcodePnum => 's20220414-9/62','s20220412-8/6','s20220412-8/4','s20220412-5/5','s20220412-5/4'
	        
	        	// tbl_orderdetail 테이블의 deliverstatus(배송상태) 컬럼의 값을 3(배송완료)로 변경하기
	            InterProductDAO_ljj pdao = new ProductDAO_ljj();
	             
	            int n = 0;
	             
	            try {
	            	n = pdao.updateDeliverEnd(odrcodePnum);
	            	
	            	if(n==odrcodeArr.length) {
	            		String message = "선택하신 제품들은 배송완료로 변경되었습니다.";
	                    String loc = request.getContextPath()+"/shop/orderList.up";
	                    
	                    request.setAttribute("message", message);
	                    request.setAttribute("loc", loc);
	                    
	                    super.setRedirect(false);
	                    super.setViewPage("/WEB-INF/msg.jsp");
	            	}
	            	else {
	            		String message = "선택하신 제품들은 배송완료로 변경이 실패되었습니다.";
	                    String loc = "javascript:history.back();";
	                    
	                    request.setAttribute("message", message);
	                    request.setAttribute("loc", loc);
	                    
	                    super.setRedirect(false);
	                    super.setViewPage("/WEB-INF/msg.jsp");
	            	}
				} catch (SQLException e) {
					e.printStackTrace();
					
					String message = "선택하신 제품들은 배송완료로 변경이 실패되었습니다.";
                    String loc = "javascript:history.back();";
                    
                    request.setAttribute("message", message);
                    request.setAttribute("loc", loc);
                    
                    super.setRedirect(false);
                    super.setViewPage("/WEB-INF/msg.jsp");
				}
	         }
		

	    }
		
	}

}
