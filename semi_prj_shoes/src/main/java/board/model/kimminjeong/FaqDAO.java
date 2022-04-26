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

public class FaqDAO implements InterFaqDAO {
// VO 객체를 통해 데이터 연결
	
	// DB 에 가서 읽어와야 하기 때문에 Connection 을 한다. (DBCP 를 쓴다.)
	private DataSource ds;		// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public FaqDAO() {
	    
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

	
	// faq 목록 조회
	@Override
	public List<FaqVO> selectAllFaq(Map<String, String> paraMap) throws SQLException {

		List<FaqVO> faqList = new ArrayList<>();

		try {
			
			conn = ds.getConnection();
			
			String sql = " select faq_num, faq_userid, faq_question, faq_answer "
					   + " from tbl_faqBoard ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				FaqVO fvo = new FaqVO();
				
				fvo.setFaq_num(rs.getInt(1));
				fvo.setFaq_userid(rs.getString(2));
				fvo.setFaq_question(rs.getString(3));
				fvo.setFaq_answer(rs.getString(4));
				
				faqList.add(fvo);
			}
			
		} finally {
			close();
		}
		
		return faqList;
	}
	
	// Faq 글쓰기 (관리자 only)
	
	
	
}
