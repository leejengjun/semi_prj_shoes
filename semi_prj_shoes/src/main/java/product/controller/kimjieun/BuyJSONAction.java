package product.controller.kimjieun;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;
import product.model.kimjieun.CartVO;
import product.model.kimjieun.InterProductDAO_kje;
import product.model.kimjieun.OrderVO;
import product.model.kimjieun.ProductDAO_kje;


public class BuyJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

	//	String odrcode = request.getParameter("odrcode");
	//	System.out.println(odrcode);
	//	HttpSession session = request.getSession();
	//	MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");


		boolean isLogin = super.checkLogin(request);
		
		if(!isLogin) {
			request.setAttribute("message", "장바구니를 보려면 먼저 로그인 부터 하세요!!");
	        request.setAttribute("loc", "javascript:history.back()"); 
	         
	      //   super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
	        return;
		}
		
		else {
			// 주문페이지 보여주기
			// 주문 목록 보여주기 //
			
			InterProductDAO_kje pdao = new ProductDAO_kje();
			
			String odrcode = request.getParameter("odrcode");
		//	System.out.println("~~~~~~ 확인용 odrcode : " + odrcode);

			
			List<OrderVO> odrList = pdao.selectOrderProduct(odrcode);
		//	Map<String, String> resultMap = pdao.selectOrderPricePoint(odrcode);
			
			JSONArray jsArr = new JSONArray();
			
			if(odrList.size() > 0) {
			
				for(OrderVO ovo: odrList) {
					JSONObject jsObj = new JSONObject();
					jsObj.put("odrcode", ovo.getOdrcode());
					jsObj.put("pnum", ovo.getProd().getPnum());
					jsObj.put("pname", ovo.getProd().getPname() );
					jsObj.put("pimage", ovo.getProd().getPimage());
					jsObj.put("saleprice", ovo.getProd().getSaleprice());
					jsObj.put("psize", ovo.getProd().getPsize());
					jsObj.put("oqty",  ovo.getCart().getOqty());
					jsObj.put("odrtotalprice", ovo.getOdrtotalprice());
					
					jsArr.put(jsObj);
	
				}
			
			}
			String json = jsArr.toString();

			request.setAttribute("odrcode", odrcode);
		    request.setAttribute("json", json);
			request.setAttribute("odrList", odrList);
		//	System.out.println(json);

		//	request.setAttribute("resultMap", resultMap);
			
		//	super.setRedirect(false);
	
			super.setViewPage("/WEB-INF/jsonview.jsp");
		
		}
		
	}
}
	
