package member.controller.wonhyejin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.wonhyejin.InterMemberDAO;
import member.model.wonhyejin.MemberDAO;

public class IdfindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();   
		
		if("POST".equalsIgnoreCase(method)) {  //찾기 버튼을 클릭했을 경우
			
			String name = request.getParameter("name");
			String email = request.getParameter("email");   
			
			InterMemberDAO mdao = new MemberDAO();
			
			Map<String, String> paraMap = new HashMap<>(); //name과 email보내기
			paraMap.put("name", name);
			paraMap.put("email", email);
			
			String userid = mdao.findUserid(paraMap);
			
			if(userid != null) {
				request.setAttribute("userid", userid);
			}
			else {   // ID가 존재하지 않은 경우
				request.setAttribute("userid", "존재하지 않는 회원 아이디입니다.");
			}
			
			request.setAttribute("name",name ); //넘어온 키 값 
			request.setAttribute("email",email );
			
		}// end of if("POST".equalsIgnoreCase(method))------------
		
		request.setAttribute("method", method);	
		//super.setRedirect(false);
		super.setViewPage("/WEB-INF/n01_wonhyejin/idfind.jsp");  
		
	}
		
 }


