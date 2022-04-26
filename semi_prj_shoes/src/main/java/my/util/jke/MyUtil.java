package my.util.jke;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {
	
	// *** ? 다음의 데이터까지 포함한 현재 URL 주소를 알려주는 메소드를 생성 *** //
	public static String getCurrentURL(HttpServletRequest request) {  // request 만 넘겨주면 현재 url 을 넘겨준다.
		
		String currentURL = request.getRequestURL().toString();   // ? 앞까지 받아온다.
	//	System.out.println("확인용1 currentURL : " + currentURL);
		// 확인용1 currentURL : http://localhost:9090/semi_prj_shoes/notice.shoes
		
		String queryString = request.getQueryString();   // ? 부터 받아온다.
	//	System.out.println("확인용2 queryString : " + queryString);
		// 확인용2 queryString : null
		// 확인용2 queryString : ?sizePerPage=10&searchWord=%EA%B0%9C%EC%9D%B8&searchType=n_title
		// POST 방식은 null
		
		if(queryString != null) { // get 방식이라면
			currentURL += "?" + queryString;
		//		System.out.println("확인용3 currentURL : " + currentURL);
		// 확인용3 currentURL : http://localhost:9090/semi_prj_shoes/notice.shoes?sizePerPage=10&searchWord=%EA%B0%9C%EC%9D%B8&searchType=n_title
		} // frontController.java에서 배워왔다.
		
		String ctxPath = request.getContextPath();
		//		/semi_prj_shoes
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();
	//	System.out.println("확인용4 beginIndex : " + beginIndex);
		// 확인용4 beginIndex : 36
		
		
		currentURL = currentURL.substring(beginIndex);
	//	System.out.println("확인용5 currentURL : " + currentURL);
		// 확인용5 currentURL : /notice.shoes?sizePerPage=10&searchWord=%EA%B0%9C%EC%9D%B8&searchType=n_title
		
		return currentURL;
		
	}

}
