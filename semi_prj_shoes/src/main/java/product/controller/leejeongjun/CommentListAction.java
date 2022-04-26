package product.controller.leejeongjun;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.leejeongjun.*;

public class CommentListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String fk_pnum = request.getParameter("fk_pnum");
		
		InterProductDAO_ljj pdao = new ProductDAO_ljj();
		List<PurchaseReviewsVO> commentList = pdao.commentList(fk_pnum);
		
		JSONArray jsArr = new JSONArray();
		
		if(commentList.size() > 0) {
			for(PurchaseReviewsVO reviewsVO : commentList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("review_seq", reviewsVO.getReview_seq());
				jsObj.put("userid", reviewsVO.getFk_userid());
				jsObj.put("name", reviewsVO.getMvo().getName());
				jsObj.put("contents", reviewsVO.getContents());
				jsObj.put("writeDate", reviewsVO.getWriteDate());
				
				jsArr.put(jsObj);
			}// end of for-----------------------------
		}
		
		String json = jsArr.toString(); 
	
		request.setAttribute("json", json);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
