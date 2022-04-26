package board.model.kimminjeong;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterBoardDAO {

	// 글쓰기 목록 조회 & 페이징 처리가 된 모든 회원 또는 검색한 회원 목록
	List<BoardVO> selectAllQna(Map<String, String> paraMap) throws SQLException;	

	// Qna 글 쓰기
	int QnaWrite(BoardVO bvo) throws SQLException;	

	// Qna 글 1개 조회하기
	BoardVO selectOneQna(String qna_num) throws SQLException;	
	
	// Qna 글 수정하기
	int QnaEdit(BoardVO bvo) throws SQLException;
	
	// Qna 글 삭제하기 
	int QnaDelete(int qnaNum) throws SQLException;

	// Qna 전체 게시글에 대한 총 페이지 알아오기
	int getTotalPage(Map<String, String> paraMap) throws SQLException;

	// Qna 글 조회수 알아오기
	public int updateViewCount(int qna_num) throws SQLException;

}
