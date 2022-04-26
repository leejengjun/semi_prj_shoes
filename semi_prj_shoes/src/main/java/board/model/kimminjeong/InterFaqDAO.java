package board.model.kimminjeong;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterFaqDAO {

	// Faq 목록 조회하기
	List<FaqVO> selectAllFaq(Map<String, String> paraMap) throws SQLException;



}
