package common.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import member.model.wonhyejin.MemberVO;
import my.util.MyUtil;
import product.model.leejeongjun.InterProductDAO_ljj;
import product.model.leejeongjun.ProductDAO_ljj;

public abstract class AbstractController implements InterCommand {   //ㅂ인터페이스에 올렸던 애들을 재정의를 안하겠다 따라서 미완성클래스로만든다
//AbstractController 클래스는 미완성(추상)클래스로써  부모클래스로 사용된다.
	
		/*
	    === 다음의 나오는 것은 우리끼리한 약속이다. ===
	
	    ※ view 단 페이지(.jsp)로 이동시 forward 방법(dispatcher)으로 이동시키고자 한다라면 
	       자식클래스에서는 부모클래스에서 생성해둔 메소드 호출시 아래와 같이 하면 되게끔 한다.
	     
	    super.setRedirect(false); 
	    super.setViewPage("/WEB-INF/index.jsp");
	    
	    
          ※ URL 주소를 변경하여 페이지 이동시키고자 한다라면
          즉, sendRedirect 를 하고자 한다라면    
          자식클래스에서는 부모클래스에서 생성해둔 메소드 호출시 아래와 같이 하면 되게끔 한다.
	          
	    super.setRedirect(true);
	    super.setViewPage("registerMember.up");               
	*/
	
	   private boolean isRedirect = false;
	// isRedirect 변수의 값이 false 이라면 view단 페이지(.jsp)로  forward 방법(dispatcher)으로 이동시키겠다. 
	   // isRedirect 변수의 값이 true 이라면 sendRedirect 로 페이지이동을 시키겠다.
	   
	   private String viewPage;
	  // viewPage 는 isRedirect 값이 false 이라면 view단 페이지(.jsp)의 경로명 이고,
	   // isRedirect 값이 true 이라면 이동해야할 페이지 URL 주소 이다.

	public boolean isRedirect() {
		return isRedirect;
	}

	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}

	public String getViewPage() {
		return viewPage;
	}

	public void setViewPage(String viewPage) {
		this.viewPage = viewPage;
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////
	
	// 로그인 유무를 검사해서 로그인 했으면 true 를 리턴해주고,
	// 로그인 안했으면 false 를 리턴해주도록 한다.
	public boolean checkLogin(HttpServletRequest request) {
	
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null) {
		// 로그인 한 경우
		return true;
		}
		else {
		// 로그인 안한 경우
		return false;			
		}
	
	}
	
	
	// 방금 보았던 그 페이지로 그대로 간다
	public void goBackURL(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("goBackURL", MyUtil.getCurrentURL(request)); 
	}


	
	//////////////////////////////////////////////////////////////////////////////
	// ***** 제품목록(Category)을 보여줄 메소드 생성하기 ***** //
	// VO를 사용하지 않고 Map 으로 처리해보겠다.
	public void getCategoryList(HttpServletRequest request) throws SQLException {
	
	InterProductDAO_ljj pdao = new ProductDAO_ljj();
	List<HashMap<String, String>> categoryList = pdao.getCategoryList();
	
	request.setAttribute("categoryList", categoryList);	// 리퀘스트 영역에 카테고리리스트 담아준다.
	}// end of public void getCategoryList(HttpServletRequest request)----------------

	
}
