package product.controller.kimjieun;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.kimjieun.*;

public class AllProductAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		// 카테고리가 있는 경우
		super.getCategoryList(request);

		
		// 옵션이 있을 경우 시작 //
		String optionType = request.getParameter("optionType");
		String cnum = request.getParameter("cnum");
		String check = request.getParameter("soldout");
		
		InterProductDAO_kje pdao = new ProductDAO_kje();
		
		Map<String, String> paraMap = new HashMap<>();
		Map<String, String> cateMap = new HashMap<>();

		
		paraMap.put("optionType", optionType);
		cateMap.put("cnum", cnum);
		
		List<ProductVO> productList = pdao.allProductSelect(paraMap, cateMap, check);
		
		request.setAttribute("optionType", optionType);
		request.setAttribute("productList", productList);
		
	
		
		
	 // super.setRedirect(false);
		super.setViewPage("/WEB-INF/n01_kimjieun/allProduct.jsp");
			
		
	}

}
