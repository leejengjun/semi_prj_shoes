package product.controller.leejeongjun;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.leejeongjun.*;

public class LikeDislikeCountAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String pnum = request.getParameter("pnum");
		
		InterProductDAO_ljj pdao = new ProductDAO_ljj();
		
		Map<String, Integer> map = pdao.getLikeDislikeCnt(pnum);
		
		JSONObject jsonObj = new JSONObject(); // {}
		
		jsonObj.put("likecnt", map.get("likecnt"));
		jsonObj.put("dislikecnt", map.get("dislikecnt"));
		
		String json = jsonObj.toString(); 	// "{"likecnt":2, "dislikecnt":0}"
		
		request.setAttribute("json", json);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
