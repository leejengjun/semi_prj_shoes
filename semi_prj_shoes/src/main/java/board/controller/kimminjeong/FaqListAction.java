package board.controller.kimminjeong;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.kimminjeong.FaqDAO;
import board.model.kimminjeong.FaqVO;
import board.model.kimminjeong.InterFaqDAO;
import common.controller.AbstractController;

public class FaqListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		///////////////////////////////////////////////////
		String faq_num = request.getParameter("faq_num");
		String faq_userid = request.getParameter("faq_userid");
		
		InterFaqDAO fdao = new FaqDAO();

		Map<String, String> paraMap = new HashMap<>();
		
		List<FaqVO> fvoList = fdao.selectAllFaq(paraMap);

		request.setAttribute("fvoList", fvoList);		
		///////////////////////////////////////////////////
		
		super.setViewPage("/WEB-INF/n01_kimminjeong/FaqList.jsp");
		
	}

}
