package product.controller.kimjieun;

import java.util.*;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.kimjieun.*;

public class AllProductCategoryAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
				// 카테고리가 있는 경우
				super.getCategoryList(request);
				
				String cnum = request.getParameter("cnum");
				InterProductDAO_kje pdao = new ProductDAO_kje();
				
				List<ProductVO> categoryList = pdao.cateProductSelect(cnum);

				request.setAttribute("categoryList", categoryList);
				
			
				
				
			 // super.setRedirect(false);
				super.setViewPage("/WEB-INF/n01_kimjieun/allProduct.jsp");
	}

}
