package product.controller.kimjieun;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;

import product.model.kimjieun.*;

public class AllSpecViewJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sname= request.getParameter("sname");  // "HIT" "NEW" "BEST
		String start= request.getParameter("start");
		String len= request.getParameter("len");
		
		
		InterProductDAO_kje pdao = new ProductDAO_kje();
		
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("sname", sname);
		paraMap.put("start", start); // start "1" "9" "17" "25" "33"
		
		String end= String.valueOf( Integer.parseInt(start) + Integer.parseInt(len) -1);
									 // end => start + len - 1;
									 // end   "8" "16" "24" "32" "40"
		paraMap.put("end", end);
		
		List<ProductVO> prodList = pdao.selectBySpecName(paraMap);
		
		JSONArray jsonArr = new JSONArray();   //     []
		
		if(prodList.size() > 0) {
			
			for( ProductVO pvo : prodList) {
				
				JSONObject jsonObj = new JSONObject();  //  {}  {}  {}  {}  {}  {}  {}  {}
														//  {}  {}  {}  {}
				
				jsonObj.put("pnum", pvo.getPnum());
				jsonObj.put("pname", pvo.getPname());
				jsonObj.put("code", pvo.getCategvo().getCode());
				jsonObj.put("pcompany", pvo.getPcompany());
				jsonObj.put("pimage", pvo.getPimage());
				jsonObj.put("qty", pvo.getPqty());
				jsonObj.put("price", pvo.getPrice());
				jsonObj.put("saleprice", pvo.getSaleprice());
				jsonObj.put("sname", pvo.getSpvo().getSname());				
				jsonObj.put("pcontent", pvo.getPcontent());
	            jsonObj.put("point", pvo.getPoint());
	            jsonObj.put("pinputdate", pvo.getPinputdate());
	            
				jsonObj.put("discountPercent", pvo.getDiscountPercent());
				// jsonObj ==> {"pnum":1, "pname":"스마트TV", "code":"100000", "pcompany":"삼성",....... "pinputdate":"2021-04-23", "discoutPercent": 15} 
	            // jsonObj ==> {"pnum":2, "pname":"노트북", "code":"100000", "pcompany":"엘지",....... "pinputdate":"2021-04-23", "discoutPercent": 10}
				
				jsonArr.put(jsonObj);
				/*
	               [ {"pnum":1, "pname":"스마트TV", "code":"100000", "pcompany":"삼성",....... "pinputdate":"2021-04-23", "discoutPercent":15} 
	                ,{"pnum":2, "pname":"노트북", "code":"100000", "pcompany":"엘지",....... "pinputdate":"2021-04-23", "discoutPercent":10} 
	                ,{....}
	                ,{....}
	                , .....
	                ,{....} 
	               ] 
	            */
				
			}// end of for-------------------------------
			
			String json = jsonArr.toString(); // 문자열로 변환
		//	System.out.println("~~~ 확인용 json => " +json);
		//	~~~ 확인용 json => [{"pnum":36,"code":"100000","discountPercent":17,"pname":"노트북30","pcompany":"삼성전자","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"59.jpg","pimage2":"60.jpg","pcontent":"30번 노트북","price":1200000,"sname":"HIT","qty":100},
		//				   	  {"pnum":35,"code":"100000","discountPercent":17,"pname":"노트북29","pcompany":"레노버","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"57.jpg","pimage2":"58.jpg","pcontent":"29번 노트북","price":1200000,"sname":"HIT","qty":100},
		//				   	  {"pnum":34,"code":"100000","discountPercent":17,"pname":"노트북28","pcompany":"아수스","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"55.jpg","pimage2":"56.jpg","pcontent":"28번 노트북","price":1200000,"sname":"HIT","qty":100},
        //		   	          {"pnum":33,"code":"100000","discountPercent":17,"pname":"노트북27","pcompany":"애플","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"53.jpg","pimage2":"54.jpg","pcontent":"27번 노트북","price":1200000,"sname":"HIT","qty":100},
		//		   	          {"pnum":32,"code":"100000","discountPercent":17,"pname":"노트북26","pcompany":"MSI","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"51.jpg","pimage2":"52.jpg","pcontent":"26번 노트북","price":1200000,"sname":"HIT","qty":100},
		//		   	          {"pnum":31,"code":"100000","discountPercent":17,"pname":"노트북25","pcompany":"삼성전자","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"49.jpg","pimage2":"50.jpg","pcontent":"25번 노트북","price":1200000,"sname":"HIT","qty":100},
		//		   	          {"pnum":30,"code":"100000","discountPercent":17,"pname":"노트북24","pcompany":"한성컴퓨터","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"47.jpg","pimage2":"48.jpg","pcontent":"24번 노트북","price":1200000,"sname":"HIT","qty":100},
		//		   	          {"pnum":29,"code":"100000","discountPercent":17,"pname":"노트북23","pcompany":"DELL","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"45.jpg","pimage2":"46.jpg","pcontent":"23번 노트북","price":1200000,"sname":"HIT","qty":100}]

			request.setAttribute("json", json);
		
			
		
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/n01_kimjieun/jsonview.jsp");
			
		}
		else {
			//DB에서 조회된 것이 없다라면
			
			String json = jsonArr.toString(); // 문자열로 변환
			
			
		//  *** 만약에 select 되어진 정보가 없다라면 [] 로 나오므로 null이 아닌 요소가 없는 빈배열이다 *** //	
		//	System.out.println("~~~ 확인용 json => " +json);
		//	~~~ 확인용 json => []
			
			request.setAttribute("json", json);
			
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/n01_kimjieun/jsonview.jsp");
				
			
		}
		
	}

}
