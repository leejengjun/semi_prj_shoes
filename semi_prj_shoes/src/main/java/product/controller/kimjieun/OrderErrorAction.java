package product.controller.kimjieun;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class OrderErrorAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// super.setRedirect(false);
		super.setViewPage("/WEB-INF/n01_kimjieun/orderError.jsp");
	}

}
