package member.controller.seongmoongil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;
import product.model.kimjieun.*;




public class MyPageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if( loginuser == null ) {
			// 로그인을 안한 경우 
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/n01_wonhyejin/login.jsp");
		}
		
		else {
			
			InterProductDAO_kje pdao = new ProductDAO_kje();
			int cartCount = pdao.getCartCount(loginuser.getUserid());
			request.setAttribute("cartCount", cartCount);// 장바구니에 담긴 물건갯수
			
			super.setViewPage("/WEB-INF/n01_seongmoongil/MyPage.jsp");
		}
	

}
}