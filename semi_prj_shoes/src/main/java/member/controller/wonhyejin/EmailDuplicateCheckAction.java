package member.controller.wonhyejin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.wonhyejin.InterMemberDAO;
import member.model.wonhyejin.MemberDAO;


public class EmailDuplicateCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod(); 
		
		if("POST".equalsIgnoreCase(method)) {
			
			String email = request.getParameter("email");
			
			InterMemberDAO mdao = new MemberDAO();
			boolean isExist = mdao.emailDuplicateCheck(email);
			
			JSONObject jsonObj = new JSONObject(); 
			jsonObj.put("isExist", isExist);    
			
			String json = jsonObj.toString(); 
	
			request.setAttribute("json", json);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp"); 
	}
}

}

