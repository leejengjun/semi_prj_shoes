package product.controller.leejeongjun;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;
import product.model.leejeongjun.InterProductDAO_ljj;
import product.model.leejeongjun.ProductDAO_ljj;

public class ProductDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.goBackURL(request);
		
		// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 해야 한다. == //
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String message = "";
		String loc = "";
		
		if(loginuser == null || !"admin".equals(loginuser.getUserid()) ) {	
			// 로그인을 안 한 경우 또는 일반사용자로 로그인 한 경우
			message = "관리자만 접근이 가능합니다.";
			loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		else {
			
			
			String pnum = request.getParameter("pnum");
		//	System.out.println("확인용 pnum : "+pnum);
			
			InterProductDAO_ljj pdao = new ProductDAO_ljj();
			
			int n = pdao.deleteProduct(pnum);	// 입력받은 제품번호에 해당하는 제품을 삭제하는 메소드
			
			if(n != 1) { 
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/n01_leejeongjun/adminPage/admin_productDeletePage.jsp");
				
			}
			
			else {
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/n01_leejeongjun/adminPage/productDeletesuccess.jsp");
			
			}
			
		}
		
	}

}
