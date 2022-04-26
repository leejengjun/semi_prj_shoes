package board.model.JeongKyeongEun;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterBoardDAO {

	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 공지사항 글에 대한 총 페이지 알아오기(db에 가야한다.)
	int getTotalPage(Map<String, String> paraMap) throws SQLException;

	// 공지사항 목록 조회 & 페이징 처리가 된 모든 공지사항 글 목록
	List<BoardVO> selectPagingNotice(Map<String, String> paraMap) throws SQLException;
	
	// 공지사항 글쓰기 메소드
	int NoticeWrite(BoardVO bvo) throws SQLException;

	// 공지사항 글 한개를 보여주는 메소드
	BoardVO selectOneNotice(String notice_no) throws SQLException;

	// 공지사항 글 삭제하기 메소드
	int NoticeDelete(int notice_no) throws SQLException;
	
	// 공지사항 글 수정하기 메소드
	int NoticeEdit(BoardVO bvo) throws SQLException;
	
	

}
