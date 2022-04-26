package product.controller.kimjieun;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;
import product.model.kimjieun.*;


public class CartAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 카테고리 목록 조회해오기
		super.getCategoryList(request);
		
		// 장바구니 보기는 반드시 해당사용자가 로그인을 해야만 볼 수 있다.
		boolean isLogin = super.checkLogin(request);
		
		if(!isLogin) {
			request.setAttribute("message", "장바구니를 보려면 먼저 로그인 부터 하세요!!");
	        request.setAttribute("loc", "javascript:history.back()"); 
	         
	      //   super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
	        return;
		}
		else {
			// 장바구니 목록 보여주기 //
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			InterProductDAO_kje pdao = new ProductDAO_kje();
			List<CartVO> cartList = pdao.selectProductCart(loginuser.getUserid());
			Map<String, String> resultMap = pdao.selectCartSumPricePoint(loginuser.getUserid());
			
			request.setAttribute("cartList", cartList);
			request.setAttribute("resultMap", resultMap);

			super.setRedirect(false);
			super.setViewPage("/WEB-INF/n01_kimjieun/cart.jsp");
			
		}
	}

}
