package product.controller.kimjieun;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;
import product.model.kimjieun.*;

public class OptionEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			// GET 방식이라면
			 String message = "비정상적인 경로로 들어왔습니다";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setViewPage("/WEB-INF/msg.jsp");
	         return;
	         
		}
		else if("POST".equalsIgnoreCase(method) && super.checkLogin(request)) {
			// POST 방식이고 로그인을 했고 로그인한 사용자 소유의 장바구니에 담은 것 이라면 장바구니 수량을 변경 한다. 
			
			String userid = request.getParameter("userid"); // 장바구니 소유주 아이디
			String cartno = request.getParameter("cartno");
			String oqty = request.getParameter("oqty");

			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			
			if(loginuser.getUserid().equals(userid)) {
				
				// 장바구니 테이블에서 특정제품의 주문량 변경하기
				InterProductDAO_kje pdao = new ProductDAO_kje();
				
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("cartno", cartno);
				paraMap.put("oqty", oqty);
				
				int n = pdao.updateCart(paraMap);
				
				JSONObject jsobj = new JSONObject();
				jsobj.put("n", n);	
				
				String json = jsobj.toString();
				
				request.setAttribute("json", json);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/jsonview.jsp");
				
			}else {
				// 로그인 당사자가 아닌 경우
				 String message = "다른 사용자의 장바구니는 제거할 수 없습니다";
		         String loc = "javascript:history.back()";
		         
		         request.setAttribute("message", message);
		         request.setAttribute("loc", loc);
		         
		         super.setViewPage("/WEB-INF/msg.jsp");
		         return;
			}
			
		
		}
		
		
		
			
		}

}
