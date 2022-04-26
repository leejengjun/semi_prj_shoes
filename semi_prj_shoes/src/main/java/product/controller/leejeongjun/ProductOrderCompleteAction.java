package product.controller.leejeongjun;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class ProductOrderCompleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		super.goBackURL(request);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/n01_leejeongjun/productPage/ordercomplete.jsp");
		
	}

}
