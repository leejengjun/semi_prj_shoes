package board.model.JeongKyeongEun;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterBoardEventDAO {
	
	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 이벤트게시판 글에 대한 총 페이지 알아오기(db에 가야한다.)
	int getTotalPage(Map<String, String> paraMap) throws SQLException;
	
	// 이벤트게시판 목록 조회 & 페이징 처리가 된 모든 이벤트게시판 글 목록
	List<BoardEventVO> selectPagingEvent(Map<String, String> paraMap) throws SQLException;
	
	// 이벤트게시판 글쓰기 메소드
	int eventWrite(BoardEventVO bvo) throws SQLException;
	
	// 이벤트게시판 글 한개를 보여주는 메소드
	BoardEventVO selectOneEvent(String event_no) throws SQLException;
	
	// 이벤트게시판 글 삭제하기 메소드
	int EventDelete(int event_no) throws SQLException;

	// 이벤트게시판 글 수정하기 메소드
	int EventEdit(BoardEventVO bvo) throws SQLException;

	

	


	
}
