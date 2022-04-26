package product.controller.leejeongjun;

import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.leejeongjun.*;


public class CommentRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String fk_userid = request.getParameter("fk_userid");
		String fk_pnum = request.getParameter("fk_pnum");
		String contents = request.getParameter("contents");
		
		// !!!! 크로스 사이트 스트립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!!! //
		contents = contents.replaceAll("<", "&lt");
		contents = contents.replaceAll(">", "&gt");
		
		// 입력한 내용에서 엔터는 <br>로 변환시키기
		contents = contents.replaceAll("\r\n", "<br>");
		
		PurchaseReviewsVO reviewsvo = new PurchaseReviewsVO();
		reviewsvo.setFk_userid(fk_userid);
		reviewsvo.setFk_pnum(Integer.parseInt(fk_pnum));
		reviewsvo.setContents(contents);
		
		InterProductDAO_ljj pdao = new ProductDAO_ljj();
		
		int n = 0;
		try {
			n = pdao.addComment(reviewsvo);
		} catch(SQLIntegrityConstraintViolationException e) { // 제약조건에 위배된 경우 (동일한 제품에 대하여 동일한 회원이 제품후기를 2번 쓴 경우 unique 제약에 위배됨)
			e.printStackTrace();
			n = -1;
		} catch (Exception e) {
			e.printStackTrace();	
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		String json = jsonObj.toString(); // {"n":1} 또는 {"n":-1}
		
		request.setAttribute("json", json);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
