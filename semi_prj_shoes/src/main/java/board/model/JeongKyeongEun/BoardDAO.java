package board.model.JeongKyeongEun;

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



public class BoardDAO implements InterBoardDAO {
	
	private DataSource ds;    // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	
	// 기본생성자
	public BoardDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semi_prj_shoes_oracle");
		  //Connection conn = ds.getConnection();  여기 4줄이 고정.
		    
		    
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	// 자원반납 해주는 메소드
	private void close() {
		
		try {
			if(rs != null)    {rs.close();	  rs = null;}
			if(pstmt != null) {pstmt.close(); pstmt = null;}
			if(conn != null)  {conn.close();  conn = null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
	}// end of private void close()-------------------------------------

	
	
	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 공지사항 게시글 대한 총 페이지 알아오기(db에 가야한다.)
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			// sql 문 해와야한다.
			String sql = " select ceil( count(*)/? ) "
					   + " from tbl_board_notice ";
			
			// 맵에서 꺼내온다.
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
			
		//	System.out.println("확인용 colname : "+colname);
		//	System.out.println("확인용 searchWord : "+searchWord);
			
			if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {  // 컬럼네임은 절대로 위치홀더 쓰면 안 됨!!!! 데이터 값만 위치홀더 쓴다.
				sql += " where "+colname+" like '%'|| ? ||'%' ";
				// 위치홀더(?)에 들어오는 값은 데이터 값만 들어올 수 있고 
				// 위치홀더(?)에는 컬럼명이나 테이블명이 들어오면 오류가 발생한다.
				// 그러므로 컬럼명이나 테이블명을 변수로 사용할 때는 위치홀더(?)가 아닌 변수로 처리해야한다.
			}
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("sizePerPage"));
			
			if(colname != null && !"".equals(colname) &&searchWord != null && !"".equals(searchWord)) {
				
					pstmt.setString(2, paraMap.get("searchWord"));
				
			}
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);
			
		} catch(Exception e) {
			e.printStackTrace();		
		} finally {
			close();
		}
		
		return totalPage;
		
	}

	
	
	// 글쓰기 목록 조회 & 페이징 처리가 된 모든 회원 또는 검색한 회원 목록
	@Override
	public List<BoardVO> selectPagingNotice(Map<String, String> paraMap) throws SQLException {
		
		List<BoardVO> noticeList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			// sql 문 쓸거당, VO 에도 rno는 없어. rno는 빼야한다!
			String sql = " select notice_no, n_title, n_userid, n_date "
					+ " from "
					+ " ( "
					+ "    select rownum AS rno, notice_no, n_title, n_userid, n_date "
					+ "    from "
					+ "    ( "
					+ "       select notice_no "
					+ "	  		   , case when length(n_title) > 25 then substr(n_title, 0, 25) || '...' else n_title end AS n_title "
					+ "	           , n_userid , to_char(n_date, 'yyyy-mm-dd') as n_date "
					+ "        from tbl_board_notice ";
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
			
		//	System.out.println("확인용 colname : "+colname);
		//	System.out.println("확인용 searchWord : "+searchWord);
			
			if(colname != null && !"".equals(colname) &&searchWord != null && !"".equals(searchWord)) {  // 컬럼네임은 절대로 위치홀더 쓰면 안 됨!!!! 데이터 값만 위치홀더 쓴다.
				sql += " where "+colname+" like '%'|| ? ||'%' ";
				// 위치홀더(?)에 들어오는 값은 데이터 값만 들어올 수 있고 
				// 위치홀더(?)에는 컬럼명이나 테이블명이 들어오면 오류가 발생한다.
				// 그러므로 컬럼명이나 테이블명을 변수로 사용할 때는 위치홀더(?)가 아닌 변수로 처리해야한다.
			}
			
			sql += "        order by notice_no desc "
				 + "    ) V "
			 	 + " ) T "
			 	 + " where rno between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			// 파라맵에 뭐가 들어왔는지 보려면 MemberListAction 가보면 된다.
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			/*
	        >>>  where rno between A and B : A ~ B 를 구하는 공식   <<<
	        
	        currentShowPageNo 은 보고자 하는 페이지 번호이다. 즉, 1페이지, 2페이지, 3페이지 ... 를 말한다.
	        sizePerPage 은 한 페이지에 보고자 하는 행의 개수를 말한다. 즉, 3개, 5개, 10개를 보여줄 때의 개수를 말한다.
	        
	     A : (currentShowPageNo * sizePerPage) - (sizePerPage - 1)
	     B : (currentShowPageNo * sizePerPage) */
			
			
			if(colname != null && !"".equals(colname) &&searchWord != null && !"".equals(searchWord)) {
				
				// 검색 했을 때
				pstmt.setString(1, searchWord);
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			}
			else { // 검색 안 했을 때
				pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(2, (currentShowPageNo * sizePerPage));
			}
			
			rs = pstmt.executeQuery();  // 리턴타입 resultSet
			
			while(rs.next()) {
				
				BoardVO bvo = new BoardVO();
				
				bvo.setNotice_no(rs.getInt(1)); 
			    bvo.setN_title(rs.getString(2));
			    bvo.setN_userid(rs.getString(3)); 
			    bvo.setN_date(rs.getString(4));
				
				noticeList.add(bvo);
			} // end of while ------------------
			
			
		} finally {
			close();
		}
		
		return noticeList;
	}	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	
	
	
	// *** 공지사항 글쓰기 메소드를 구현하기 *** //
	@Override
	public int NoticeWrite(BoardVO bvo) throws SQLException {
		
		int n = 0;
		
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " insert into tbl_board_notice(notice_no, n_userid, n_title, n_contents, n_file) "
					   + " values (notice_seq.nextval, ?, ?, ?, ?) "; 
			
			// 우편배달부 만들기
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, bvo.getN_userid());
			pstmt.setString(2, bvo.getN_title());
			pstmt.setString(3, bvo.getN_contents());
			pstmt.setString(4, bvo.getN_file());
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		
		return n;
		
	} // end of public int NoticeWrite(BoardVO bvo)-------------------

	
	
	
	
	// 공지사항 글 한개를 보여주는 메소드
	@Override
	public BoardVO selectOneNotice(String notice_no) throws SQLException {
		
		BoardVO bvo = null;

		try {
			
			conn = ds.getConnection();
			
			String sql = " select notice_no "
					   + " , n_title "
					   + " , n_userid "
					   + " , n_contents "
					   + " , to_char(n_date, 'yyyy-mm-dd') as n_date "
					   + " , n_file "
					   + " from tbl_board_notice "
					   + " where notice_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, notice_no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				bvo = new BoardVO();
				
				bvo.setNotice_no(rs.getInt(1));
				bvo.setN_title(rs.getString(2));
				bvo.setN_userid(rs.getString(3));
				bvo.setN_contents(rs.getString(4));
				bvo.setN_date(rs.getString(5));
				bvo.setN_file(rs.getString(6));
				
			}
			
		} finally {
			close();
		}
		
		return bvo;
	}// end of public BoardVO selectOneNotice(String notice_no) -------------------
	
	
	
	
	// 공지사항 글 삭제하기 메소드
	@Override
	public int NoticeDelete(int notice_no) throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " delete from tbl_board_notice "
					   + " where notice_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, notice_no);
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}		
		return n;		
	}

	
	
	
	// 공지사항 글 수정하기 메소드
	@Override
	public int NoticeEdit(BoardVO bvo) throws SQLException {
		
		int n = 0; 
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " update tbl_board_notice set n_userid = ?, n_title = ?, n_contents = ? , n_file = ? "
					   + " where notice_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, bvo.getN_userid());
			pstmt.setString(2, bvo.getN_title());
			pstmt.setString(3, bvo.getN_contents());
			pstmt.setString(4, bvo.getN_file());
			pstmt.setInt(5, bvo.getNotice_no());
			
			n = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return n;
	}

	
	

	
	
	
}
