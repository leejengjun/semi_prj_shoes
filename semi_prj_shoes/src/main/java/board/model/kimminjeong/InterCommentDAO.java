package board.model.kimminjeong;

import java.sql.SQLException;
import java.util.List;

public interface InterCommentDAO {

	
	// 원게시글 번호에 딸린 댓글내용 보여주기 //
	List<CommentVO> commentList(String boardno) throws SQLException;

	// 댓글쓰기 //
	int write_comment(CommentVO comment) throws SQLException;

	// 댓글 삭제하기
	int qnaDeleteComment(int qna_commentno) throws SQLException;

	// 댓글 수정하기
	int qnaEditComment(CommentVO cvo) throws SQLException;
	
	
}
