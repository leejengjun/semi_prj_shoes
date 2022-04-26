package product.controller.kimjieun;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.wonhyejin.MemberVO;
import product.model.kimjieun.*;


public class OrderAddAction extends AbstractController {

	// === 전표(주문코드)를 생성해주는 메소드 생성하기 === //
	
		private String getOdrcode() throws SQLException{
			
			// 전표(주문코드) 형식 : s+날짜+sequence ==> s20210503-1
			
			// 날짜 생성
			Date now = new Date();
		    SimpleDateFormat smdatefm = new SimpleDateFormat("yyyyMMdd"); 
		    String today = smdatefm.format(now);
		     
		    
		    InterProductDAO_kje pdao = new ProductDAO_kje();
		    
		    int seq = pdao.getSeq_tbl_order();
		    // pdao.getSeq_tbl_order(); 는 시퀀스 seq_tbl_order 값을 채번해오는 것.
		      
			return "s"+today+"-"+seq;

		}// end of private String getOdrcode()--------------------------------------------
		
		@Override
		public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			String pnumjoin = request.getParameter("pnumjoin");
			String oqtyjoin = request.getParameter("oqtyjoin");
			String cartnojoin = request.getParameter("cartnojoin");
			String totalPricejoin = request.getParameter("totalPricejoin");
			
			String sumtotalPrice = request.getParameter("sumtotalPrice");
			String sumtotalPoint = request.getParameter("sumtotalPoint");
		/*	
			System.out.println("~~~~~~~~~~~~ 확인용 pnumjoin: "+ pnumjoin);
			System.out.println("~~~~~~~~~~~~ 확인용 oqtyjoin : " + oqtyjoin);
	        System.out.println("~~~~~~~~~~~~ 확인용 cartnojoin : " + cartnojoin);
	        System.out.println("~~~~~~~~~~~~ 확인용 totalPricejoin : " + totalPricejoin);
	        System.out.println("~~~~~~~~~~~~ 확인용 sumtotalPrice : " + sumtotalPrice);
	        System.out.println("~~~~~~~~~~~~ 확인용 sumtotalPoint : " + sumtotalPoint);
		*/
			
			// ===== Transaction 처리하기 ===== // 
		       // 1. 주문 테이블에 입력되어야할 주문전표를 채번(select)하기 
		       // 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
		       // 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
		       // 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리) 
		        
		       // 5. 장바구니 테이블에서 cartnojoin 값에 해당하는 행들을 삭제(delete OR update)하기(수동커밋처리)
		       // >> 장바구니에서 주문을 한 것이 아니라 특정제품을 바로주문하기를 한 경우에는 장바구니 테이블에서 행들을 삭제할 작업은 없다. << 
		        
		       // 6. 회원 테이블에서 로그인한 사용자의 coin 액을 sumtotalPrice 만큼 감하고, point 를 sumtotalPoint 만큼 더하기(update)(수동커밋처리) 
		       // 7. **** 모든처리가 성공되었을시 commit 하기(commit) **** 
		       // 8. **** SQL 장애 발생시 rollback 하기(rollback) **** 
		   
		       // === Transaction 처리가 성공시 세션에 저장되어져 있는 loginuser 정보를 새로이 갱신하기 ===
		       // === 주문이 완료되었을시 주문이 완료되었다라는 email 보내주기  === // 
	        
			
		    InterProductDAO_kje pdao = new ProductDAO_kje();
		    
		    Map<String, Object> paraMap = new HashMap<>();
		    
		    // ======= 주문 테이블에 insert ======= //
		    // 1. 전표(주문코드)를 가져오기
		    String odrcode = getOdrcode();
		    paraMap.put("odrcode", odrcode);
		    
		    // 2. 회원아이디
		    HttpSession session = request.getSession();
		    MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		    paraMap.put("userid", loginuser.getUserid());
		    
		    // 3. 주문총액 및 주문총포인트
		    paraMap.put("sumtotalPrice", sumtotalPrice);
		    paraMap.put("sumtotalPoint", sumtotalPoint);
		    
		    
		    // ======= 주문상세 테이블에 insert ======= //
		    // 1. 전표(주문코드)를 가져오기는 위에서 만들어 맵에 넣어둠.
		    // 2. 제품번호
		    String[] pnumArr = pnumjoin.split(","); // 장바구니에서 여러개 제품을 주문할 경우       ex) "5,3,60"  ==> ["5","3","60"]
		      										// 장바구니에서 제품 1개만 제품을 주문할 경우    ex) "5"  ==> ["5"]
		    										// 바로주문으로 제품 1개만 제품을 주문할 경우    ex) "60"  ==> ["60"]
		    // 3. 주문량
		    String[] oqtyArr = oqtyjoin.split(",");
		    
		    
		    // 4. 주문가격
		    String[] totalPriceArr = totalPricejoin.split(",");
		    
		    
		    paraMap.put("pnumArr", pnumArr);
		    paraMap.put("oqtyArr", oqtyArr);
		    paraMap.put("totalPriceArr", totalPriceArr);
		    
		    // ======= 제품 테이블 update 하기 ======= //
		    // 1. 제품 테이블의 잔고량 컬럼의 값을 주문량 만큼 감해야 하는데 이미 위에서 주문량을 구해 맵에 넣어둠.
		    
		    
		    // ======= 장바구니 테이블에서 delete 하기 ======= //
		    // 1. 장바구니 번호
		    
	    	paraMap.put("cartnojoin", cartnojoin);    // 장바구니에서 여러개 제품을 주문할 경우       ex) "6,3,1"  ==> ["6","3","1"]
	    											  // 장바구니에서 제품 1개만 제품을 주문할 경우    ex) "6"  ==> ["6"]											     
	    											  // 특정제품을 바로 주문하기를 한 경우          ex) null
	    	// 특정제품을 바로 주문하기를 한 경우라면  cartnojoin의 값은 null이다. 

		    // ======= 회원 테이블에서 로그인한 사용자의 coin 금액과 point 를 update 하기 ======= //
		    // 1. 로그인한 사용자는 이미 위에서 맵에 넣어둠.
		    // 2. coin 금액과 point 를 update 하기 위한 것은 이미 위에서 sumtotalPrice 와 sumtotalPoint 을 맵에 넣어둠.
		    
		    // ******* Transaction 처리를 해주는 메소드 호출하기 ******* //
		    int isSuccess = pdao.orderAdd(paraMap); 
		    
		    JSONObject jsobj = new JSONObject();
		    jsobj.put("isSuccess", isSuccess);
		    
		    jsobj.put("odrcode", odrcode);
		    
		    // **** 주문이 완료되었을시 세션에 저장되어져 있는 loginuser 정보를 갱신하고
		    //      이어서 주문이 완료되었다라는 email 보내주기 시작**** //
		    
	/*	    if(isSuccess == 1) {
		    	
		    	// 세션에 저장되어져 있는 loginuser 정보를 갱신
		    	loginuser.setPoint(loginuser.getPoint() - Integer.parseInt(sumtotalPoint) );
		    	
		    	/////////////// === 주문이 완료되었다는 email 보내기 시작 === ///////////////
		    	
		    	GoogleMail mail = new GoogleMail();
		    	
		    	StringBuilder sb = new StringBuilder();
		    	
		    	for(int i =0; i<pnumArr.length; i++) {
		    		sb.append("\'"+pnumArr[i]+"\',");
		    		/*
		               tbl_product 테이블에서 select 시
		               where 절에 in() 속에 제품번호가 들어간다.
		               만약에 제품번호가 문자열로 되어있어서 반드시 홑따옴표(')가 필요한 경우에는 위와같이 해주면 된다.
		            */
	/*	    		
		    	}// end of for----------------------------
	*/	    	
	/*	    	String pnumes = sb.toString().trim();
		    	// "'6','3','1',"
		    	
		    	pnumes = pnumes.substring(0, pnumes.length()-1);
		    	// 맨 뒤의 콤마(,) 제거하기 위함
		    	// "'6','3','1'"
		    	
		   // 	System.out.println("~~~~~ 확인용 주문한 제품번호 : " + pnumes);
		    	// ~~~~~ 확인용 주문한 제품번호 : '6','3','1'
		    	
		    	List<ProductVO> jumunProductList = pdao.getJumunProductList(pnumes);
		    	// 주문한 제품에 대해 email 보내기시 email 내용에 넣을 주문한 제품번호들에 대한 제품정보를 얻어오는 것
		    	
		    	sb.setLength(0);
		    	// StringBuilder sb의 초기화하기
		    
		    	sb.append("주문코드번호 : <span style='color: blue; font-weight: bold;'>"+odrcode+"</span><br/><br/>");
		        sb.append("<주문상품><br/>");
		    	
		        for(int i=0; i<jumunProductList.size(); i++) {
		        	
		        	sb.append(jumunProductList.get(i).getPname()+"&nbsp;"+oqtyArr[i]+"개&nbsp;&nbsp;");
		        	sb.append("<img src='http://127.0.0.1:9090/MyMVC/images/"+jumunProductList.get(i).getPimage()+"'/>");
		        	sb.append("<br/>");
		        	
		        }// end of for------------------------------------
		        
		        sb.append("<br/>이용해 주셔서 감사합니다.");
		        
		        String emailContents = sb.toString();
		        
		        mail.sendmail_OrderFinish(loginuser.getEmail(), loginuser.getName(), emailContents);
		        
		    	/////////////// === 주문이 완료되었다는 email 보내기 끝 === ///////////////
		    }
	*/	    
		    // **** 주문이 완료되었을시 세션에 저장되어져 있는 loginuser 정보를 갱신하고
		    //      이어서 주문이 완료되었다라는 email 보내주기  끝**** //
		    
		    String json = jsobj.toString();
		    request.setAttribute("json", json);
		    
		    
		    super.setRedirect(false);
		    super.setViewPage("/WEB-INF/jsonview.jsp");
		}

	}
