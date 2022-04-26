package board.model.kimminjeong;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import member.model.wonhyejin.MemberVO;

public class CommentDAO implements InterCommentDAO {
	// VO 객체를 통해 데이터 연결
	
		// DB 에 가서 읽어와야 하기 때문에 Connection 을 한다. (DBCP 를 쓴다.)
		private DataSource ds;		// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
		private Connection conn;
		private PreparedStatement pstmt;
		private ResultSet rs;
		
		public CommentDAO() {
		    
			try {		
				Context initContext = new InitialContext();	// 1. 커넥션 풀에 접근하려면 JNDI 서비스를 사용
			    Context envContext  = (Context)initContext.lookup("java:/comp/env");  
			    ds = (DataSource)envContext.lookup("jdbc/semi_prj_shoes_oracle"); // 2. .lookup( )은 리소스를 찾은 후 리소스를 사용할 수 있도록 객체를 반환해주는 메소드
			    // "jdbc/semi_prj_shoes" 는 web.xml 에 있는 <res-ref-name> 이다.
			    // 이는 context.xml에 있는 name에 해당한다. (오라클 DB와 연결)
			    
			} catch (NamingException e) {
				e.printStackTrace();
			}
		    
		}
		
		// 자원 반납해주는 close() 메소드
		private void close() {
			// 사용된 것을 닫아야(close) 한다. null이 아니라면, 자원반납
			try {
				if(rs != null) 		{ rs.close(); 		rs = null;	}
				if(pstmt != null) 	{ pstmt.close(); 	pstmt = null;	}
				if(conn != null) 	{ conn.close(); 	conn = null;	}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}// end of private void close()-----------------------


	// 원게시글 번호에 달린 댓글 내용 조회	
	@Override
	public List<CommentVO> commentList(String qna_num) throws SQLException {
	
		List<CommentVO> commentList = new ArrayList<>();
		
		try {
	
			conn = ds.getConnection();
			
			String sql = " select qna_commentno, fk_qna_num, fk_qna_cmtWriter, qna_cmtContent, to_char(qna_cmtRegDate, 'yyyy-mm-dd') as qna_cmtRegDate "+
						 " from tbl_qna_comment "+
						 " where fk_qna_num = ? "+
						 " order by qna_cmtRegDate asc ";
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(qna_num));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				CommentVO cvo = new CommentVO();
				
				cvo.setQna_commentno(rs.getInt(1));
				cvo.setFk_qna_num(rs.getString(2));
				cvo.setFk_qna_cmtWriter(rs.getString(3));
				cvo.setQna_cmtContent(rs.getString(4));
				cvo.setQna_cmtRegDate(rs.getString(5));
				
				commentList.add(cvo);
				
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return commentList;
	}

	
	
	// 댓글 쓰기	
	@Override
	public int write_comment(CommentVO comment) throws SQLException {

		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " insert into tbl_qna_comment(qna_commentno, fk_qna_num, fk_qna_cmtWriter, qna_cmtContent) "
					   + " values(seq_comment.nextval, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, comment.getFk_qna_num());
			pstmt.setString(2, comment.getFk_qna_cmtWriter());
			pstmt.setString(3, comment.getQna_cmtContent());

			n = pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return n;
	}
	
	// 댓글 삭제		
	@Override
	public int qnaDeleteComment(int qna_commentno) throws SQLException {

		int n = 0;
		
		try {

			conn = ds.getConnection();
			
			String sql = " delete from tbl_qna_comment "
					   + " where qna_commentno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qna_commentno);
			
			n = pstmt.executeUpdate();			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return n;		
		
	}// end of public int qnaDeleteComment(int qna_commentno) {}-------------

	// 댓글 수정
	@Override
	public int qnaEditComment(CommentVO cvo) throws SQLException {

		int n = 0;

		try {
			
				conn = ds.getConnection();
				
				String sql = " update tbl_qna_comment set qna_cmtContent = ? "
						   + " where qna_commentno = ? "; 
				   
				pstmt = conn.prepareStatement(sql); 
				
				pstmt.setString(1, cvo.getQna_cmtContent()); 
				pstmt.setInt(2, cvo.getQna_commentno());
				  
				n = pstmt.executeUpdate();
			
		} catch (Exception e) {

		} finally {
			close();
		}
		
		return n;
	}
	
}
