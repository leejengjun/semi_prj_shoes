package member.controller.wonhyejin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class AgreeAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		//	super.setRedirect(false);

			super.setViewPage("/WEB-INF/n01_wonhyejin/agree.jsp");
			
		
	}

}
