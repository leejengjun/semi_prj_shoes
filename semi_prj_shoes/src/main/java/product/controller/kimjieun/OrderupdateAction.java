package product.controller.kimjieun;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;
import product.model.kimjieun.InterProductDAO_kje;
import product.model.kimjieun.OrderVO;
import product.model.kimjieun.ProductDAO_kje;


public class OrderupdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
	/*	if("GET".equalsIgnoreCase(method)) {
			// super.setRedirect(false);
			   super.setViewPage("/WEB-INF/n01_leejeongjun/index_startingPage.jsp");
		}
		else {
			// 결제 버튼을 클릭했을 경우
			String odrcode = request.getParameter("odrcode");
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			String name = request.getParameter("gname");
			String userid = request.getParameter(loginuser.getUserid());
			String email = request.getParameter("email");
			String bphone1 = request.getParameter("bphone21");
			String bphone2 = request.getParameter("bphone22");
			String bphone3 = request.getParameter("bphone23");
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String detailaddress = request.getParameter("bdetailaddr");
			String extraaddress = request.getParameter("extraAddress");
			String msg1 = request.getParameter("msg1");
			String msg2 = request.getParameter("msg2");
			
			String mobile = bphone1+bphone2+bphone3;
			
			OrderVO ordmember= new OrderVO(userid, name, email, mobile, postcode, address, detailaddress, extraaddress, msg1, msg2);
			
			String message = "";
			String loc= "";
			try {
				InterProductDAO_kje pdao = new ProductDAO_kje();
				int n = pdao.buyContentinsert(ordmember, odrcode, loginuser.getUserid());
			
				if(n==1) {
					message = "결제 성공";
					loc = request.getContextPath()+"/index.up"; //시작페이지로 이동한다.
				}
				
			} catch(SQLException e) {
				message = "sql 에러 발생";
				
				InterProductDAO_kje pdao = new ProductDAO_kje();
				pdao.orderDelte(odrcode);
			
				loc = "javascript:history.back()"; // 자바스크립트를 이요한 이전페이지로 이동한다.
				e.printStackTrace();
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		
		
		}*/
		
		
		if(super.checkLogin(request)) {
			// 로그인을 했으면
			
			String userid = request.getParameter("userid");
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			if(loginuser.getUserid().equals(userid)) {
				// 로그인한 사용자가 자신의 코인을 충전하는 경우
				
				String coinmoney = request.getParameter("coinmoney");
				
				request.setAttribute("coinmoney", coinmoney);
				request.setAttribute("email", loginuser.getEmail());	
				request.setAttribute("name", loginuser.getName());
				request.setAttribute("mobile", loginuser.getMobile());
				request.setAttribute("userid", userid);
		//		request.setAttribute("addr", loginuser.getAddress());	
		//		request.setAttribute("postcode", loginuser.getPostcode());	
		//		request.setAttribute("email", loginuser.getEmail());	


				
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/member/paymentGateway.jsp");
				
			}
			else {
				// 로그인한 사용자가 다른 사용자의 코인을 충전하려고 하는 경우
				String message = "다른 사용자의 코인충전 결제 시도는 불가합니다!!";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);

//				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
			}
			
//			
		}
		else {
			// 로그인을 안 했으면
			String message = "코인 충전 결제를 하기 위해서는 먼저 로그인을 하세요!!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);

//			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}

	}
}