package board.model.kimminjeong;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import member.model.wonhyejin.MemberVO;


public class BoardDAO implements InterBoardDAO {
// VO 객체를 통해 데이터 연결
	
	// DB 에 가서 읽어와야 하기 때문에 Connection 을 한다. (DBCP 를 쓴다.)
	private DataSource ds;		// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public BoardDAO() {
	    
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

	/*
	  	// 외부에서 객체생성 요구 시 getter 메서드를 이용해서 객체 생성을 받환 private static BoardDAO instance
	  	= new BoardDAO();
	  
	  	public static BoardDAO getInstance() { return instance; }
	*/
	
	// 글쓰기 목록 조회 & 페이징 처리가 된 모든 회원 또는 검색한 회원 목록
	@Override
	public List<BoardVO> selectAllQna(Map<String, String> paraMap) throws SQLException {

		List<BoardVO> qnaList = new ArrayList<>();

		try {

			conn = ds.getConnection();			

			String sql = " select qna_num, qna_subject, qna_writer, qna_regDate, qna_viewCnt "+
					" from "+
					"  (  "+
					"    select rownum as rno, qna_num, qna_subject, qna_writer, qna_regDate, qna_viewCnt "+
					"    from "+
					"    ( "+
					"        select qna_num "+
					"        , case when length(qna_subject) > 20 then substr(qna_subject, 0, 20) || '...' else qna_subject end AS qna_subject "+
					"        , qna_writer , to_char(qna_regDate, 'yyyy-mm-dd') as qna_regDate "+
					"        , qna_viewCnt "+
					"        from tbl_qnaBoard ";
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
			
		//	System.out.println("확인용 colname : "+ colname);
		//	System.out.println("확인용 searchWord : "+ searchWord);
			
			if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
				sql += " where "+colname+" like '%'|| ? ||'%' ";
			}
	
			 sql += "        order by to_number(qna_num) desc "+
				   "    ) V "+
				   " ) T "+
				   " where rno between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
				// 검색이 있을 때
				pstmt.setString(1, searchWord);
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			}
			else {
				// 검색이 없을 때
				pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(2, (currentShowPageNo * sizePerPage));			
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				BoardVO bvo = new BoardVO();
				
				bvo.setQna_num(rs.getInt(1));
				bvo.setQna_subject(rs.getString(2));
				bvo.setQna_writer(rs.getString(3));
				bvo.setQna_regDate(rs.getString(4));
				bvo.setQna_viewCnt(rs.getInt(5));

				qnaList.add(bvo);				
			}

		} finally {
			close();
		}		
		return qnaList;
	}	

	

	// 글 번호를 이용해 해당 글을 찾고, 조회 수를 증가시키는 메소드 ==> 조회수 증가 (1개만 선택)
	// select 문과 update 문 사용
	// Qna 게시판 글 1개 내용보기 (QnaDetailAction)
	@Override
	public BoardVO selectOneQna(String qna_num) throws SQLException {
	// product 테이블과 join 필요 (문의할 제품 불러오기 위해서)
		
		BoardVO bvo = null;

		try {
			
			conn = ds.getConnection();
			
			String sql = " select qna_num "
					   + " , case when length(qna_subject) > 20 then substr(qna_subject, 0, 20) || '...' else qna_subject end AS qna_subject "
					   + " , qna_writer "
					   + " , qna_content "
					   + " , to_char(qna_regDate, 'yyyy-mm-dd') as qna_regDate "
					   + " , qna_viewCnt "
					   + " , qna_file "
					   + " from tbl_qnaBoard "
					   + " where qna_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, qna_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bvo = new BoardVO();
				
				bvo.setQna_num(rs.getInt(1));
				bvo.setQna_subject(rs.getString(2));
				bvo.setQna_writer(rs.getString(3));
				bvo.setQna_content(rs.getString(4));
				bvo.setQna_regDate(rs.getString(5));
				bvo.setQna_viewCnt(rs.getInt(6));	// 조회수
				bvo.setQna_file(rs.getString(7));

			}
			
		} finally {
			close();
		}
		
		return bvo;
	}// end of public BoardVO selectOneQna(String qna_num)-------------------

	
	// Qna 글 읽었을 때 조회수 증가 (글번호에 따른 조회수 증가)
	@Override
	public int updateViewCount(int qna_num) throws SQLException {

		int n = 0;
		
		try {
		
			conn = ds.getConnection();
			
			String sql = " update tbl_qnaBoard set qna_viewCnt = qna_viewCnt + 1 "
					   + " where qna_num = ? ";
			
			pstmt = conn.prepareStatement(sql);	
			pstmt.setInt(1, qna_num);
			
			n = pstmt.executeUpdate();		
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return n;
	}


	// Qna 게시판 글 쓰기 (QnaWriteAction)
	@Override
	public int QnaWrite(BoardVO bvo) throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " insert into tbl_qnaBoard(qna_num, qna_subject, qna_writer, qna_content, qna_file) "
					   + " values (seq_qnaBoard.nextval, ?, ?, ?, ?) "; 

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bvo.getQna_subject());
			pstmt.setString(2, bvo.getQna_writer());
			pstmt.setString(3, bvo.getQna_content());
			pstmt.setString(4, bvo.getQna_file());
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;	//  메서드의 반환 값은 해당 SQL 문 실행에 영향을 받는 행 수를 반환
	}// end of public int QnaWrite(BoardVO bvo)-------------------

	
	// Qna 게시판 글 수정하기 (QnaUpdateAction)
	@Override
	public int QnaEdit(BoardVO bvo) throws SQLException {

		int n = 0; 
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " update tbl_qnaBoard set qna_writer = ?, qna_subject = ?, qna_content =? , qna_file = ? "
					   + " where qna_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, bvo.getQna_writer());
			pstmt.setString(2, bvo.getQna_subject());
			pstmt.setString(3, bvo.getQna_content());
			pstmt.setString(4, bvo.getQna_file());
			pstmt.setInt(5, bvo.getQna_num());
			
			n = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return n;
	}	
	
	// Qna 게시판 게시글 삭제하기 (QnaDeleteAction)
	public int QnaDelete(int qna_num) throws SQLException {
	
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " delete from tbl_qnaBoard "
					   + " where qna_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qna_num);
			
			n = pstmt.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}		
		return n;		
	}

	
	// 페이징 처리가 된 모든 글 보기 또는 검색한 글 보기
	// 페이징 처리를 위한 검색된 또는 검색되지 않은 전체 글에 대한 총 페이지 알아오기
	// Qna 전체 게시글에 대한 총 페이지 알아오기
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {

		int totalPage = 0;
		
		try {
		
			conn = ds.getConnection();
			
			String sql = " select ceil(count(*)/?) "
					   + " from tbl_qnaBoard ";
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");

			if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
				sql += " where "+colname+" like '%'|| ? ||'%' ";
			}
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("sizePerPage"));   

			if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {			
				pstmt.setString(2, paraMap.get("searchWord")); 			
			}
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return totalPage;
	}


}
