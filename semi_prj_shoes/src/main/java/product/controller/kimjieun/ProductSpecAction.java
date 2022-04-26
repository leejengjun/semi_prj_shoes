package product.controller.kimjieun;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.kimjieun.*;


public class ProductSpecAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		
		// 카테고리 목록을 가져오기
			super.getCategoryList(request);
			
			// === Ajax(JSON)을 사용하여 HIT 상품목록을 "더보기" 방식으로 페이징처리해서 보여주겠다. === //
			InterProductDAO_kje pdao = new ProductDAO_kje();
			
			int totalHITCount = pdao.totalPspecCount("1"); // HIT 상품의 전체개수를 알아온다.
			
		//	System.out.println("~~~~ 확인용 totalHITCount : "+totalHITCount);
		//  ~~~~ 확인용 totalHITCount : 36
			
			request.setAttribute("totalHITCount", totalHITCount);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/n01_kimjieun/productSpec.jsp");
				
		
	}

}
