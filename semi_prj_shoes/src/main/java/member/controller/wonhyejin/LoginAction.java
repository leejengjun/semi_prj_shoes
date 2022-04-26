package member.controller.wonhyejin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.wonhyejin.InterMemberDAO;
import member.model.wonhyejin.MemberDAO;
import member.model.wonhyejin.MemberVO;


public class LoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		 String method = request.getMethod(); 
			
			if("GET".equalsIgnoreCase(method)){   
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/n01_wonhyejin/login.jsp");
			}
			else { 

				String userid = request.getParameter("userid");
				String pwd = request.getParameter("pwd");
				
		    
		    Map<String, String> paraMap = new HashMap<>();
		    paraMap.put("userid", userid);	
		    paraMap.put("pwd", pwd);	
		    
		    InterMemberDAO mdao = new MemberDAO();
		    
		    MemberVO loginuser = mdao.selectOneMember(paraMap);
		    
		    if( loginuser != null) {
		    	
		    	if(loginuser.getIdle() == 1) {
		    		String message = "1년 이상 로그인이 되지 않아 휴면 상태로 전환되었습니다. 관리자에게 문의 바랍니다.";
			    	String loc = request.getContextPath()+"/index.shoes";
			    	
			    	request.setAttribute("message", message);
			    	request.setAttribute("loc", loc);
			    	
			    	super.setRedirect(false);
			    	super.setViewPage("/WEB-INF/n01_wonhyejin/msg.jsp");
			    	
			    	return;  
		    	}
				
		    	HttpSession session = request.getSession();
		    	session.setAttribute("loginuser", loginuser);
		    	
		    	session.setAttribute("login_ok", loginuser.getName()+"님 로그인 성공하셨습니다.");  //로그인 했을 때 나타내기
		    	
		    	if( loginuser.isRequirePwdChange() == true ) {
		    		String message = "비밀번호를 변경하신지  3개월이 지났습니다. 보안을 위해 비밀번호를 변경하시기 바랍니다.";
			    	String loc = request.getContextPath()+"/index.shoes";
			    	
			    	request.setAttribute("message", message);
			    	request.setAttribute("loc", loc);
			    	
			    	super.setRedirect(false);
			    	super.setViewPage("/WEB-INF/n01_wonhyejin/msg.jsp");

		    	}
		    	else { //페이지 이동
		    	
		    		super.setRedirect(true);
                  
		    		String goBackURL = (String) session.getAttribute("goBackURL");
		    	
		    		if(goBackURL != null) {
		    			 super.setViewPage(request.getContextPath()+goBackURL);
		    		} 
		    		else {  //null이면 시작페이지
		    			super.setViewPage(request.getContextPath()+"/index.shoes");
		    		}
		      }
		    }
		    else {
		    	String message = "로그인 실패하였습니다. 다시 시도해주시기 바랍니다.";
		    	String loc = "javascript:history.back()";   
		    	request.setAttribute("message", message);
		    	request.setAttribute("loc", loc);
		    	
		    	super.setRedirect(false);
		    	super.setViewPage("/WEB-INF/n01_wonhyejin/msg.jsp");
		    	
		    }
		}

		}
	}
