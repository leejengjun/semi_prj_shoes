package member.controller.seongmoongil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import common.controller.AbstractController;
import member.model.wonhyejin.*;

public class MemberEditEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			// *** POST 방식으로 넘어온 것이라면 *** //
			
			String userid = request.getParameter("userid");
			String name = request.getParameter("name"); 
	        String pwd = request.getParameter("pwd"); 
	        String email = request.getParameter("email"); 
	        String hp1 = request.getParameter("hp1"); 
	        String hp2 = request.getParameter("hp2"); 
	        String hp3 = request.getParameter("hp3"); 
	        String postcode = request.getParameter("postcode");
	        String address = request.getParameter("address"); 
	        String detailAddress = request.getParameter("detailAddress"); 
	        String extraAddress = request.getParameter("extraAddress");
	        
	        String mobile = hp1+hp2+hp3;
	        
	        MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode, address, detailAddress, extraAddress);
	        
	        InterMemberDAO mdao = new MemberDAO();
	        int n = mdao.updateMember(member);
	        
	        String message = "";
	        
	        if(n==1) {
	        	HttpSession session = request.getSession();        	
	        	MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	        	
	        	loginuser.setPwd(pwd);
	        	loginuser.setName(name);
	        	loginuser.setEmail(email);
	        	loginuser.setMobile(mobile);
	        	loginuser.setPostcode(postcode);
	        	loginuser.setAddress(address);
	        	loginuser.setDetailaddress(detailAddress);
	        	loginuser.setExtraaddress(extraAddress);
	        	
	        	
	        	message = "회원정보 수정 성공!!";
	        	        	
	        }
	        else {
	        	
	        	message = "회원정보 수정 실패!!"; 	
	        }
	        
	        String loc = "javascript:history.back()";
	        
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	        
	   //     super.setRedirect(false);
	        JOptionPane.showMessageDialog(null, message);  //알림창을 띄울 수 있는 함수

	        super.setViewPage("/WEB-INF/n01_seongmoongil/MyPage.jsp");
		}
		else {
			// *** POST 방식으로 넘어온 것이 아니라면 *** //
			String message = "비정상적인 경로를 통해 들어왔습니다.!!";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setViewPage("/WEB-INF/msg.jsp");
	         
		}
		
		
		
	}

}
