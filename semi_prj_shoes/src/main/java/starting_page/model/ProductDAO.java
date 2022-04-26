package starting_page.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ProductDAO implements InterProductDAO {

	private DataSource ds;	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;	// 우편배달부
	private ResultSet rs;
	
	// 기본생성자
	public ProductDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semi_prj_shoes_oracle");	// web.xml에 있는 주소
		}catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	
	// 자원반납해주는 메소드
	private void close() {
		
		try {
			if(rs != null) {rs.close(); rs = null;}
			if(pstmt != null) {pstmt.close(); pstmt = null;}
			if(conn != null) {conn.close(); conn = null;}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
	}// end of private void close()----------------
	
	
	
	// 시작(메인)페이지에 보여주는 상품이미지 파일명으로 모두 조회(select)하는 메소드
	@Override
	public List<ImageVO> imageSelectAll() throws SQLException {
		
		List<ImageVO> imgList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select imgno, imgfilename "+
					     " from tbl_main_i "+
					     " order by imgno asc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ImageVO imgvo = new ImageVO();
				imgvo.setImgno(rs.getInt(1));
				imgvo.setImgfilename(rs.getString(2));
				
				imgList.add(imgvo);
			}// end of while()---------------------------
			
			
		} finally {
			close();
		}
		
		return imgList;
		
	} // end of public List<ImageVO> imageSelectAll()------------------


	// 시작(메인)페이지에 보여줄 상품 이미지 4개를 파일명으로 모두 조회하는 메소드
	@Override
	public List<ImageVO> imageShow() throws SQLException {
		
		List<ImageVO> imgshow = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select imgno, imgfilename "+
					     " from tbl_main_img "+
					     " order by imgno asc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ImageVO imgshows = new ImageVO();
				imgshows.setImgno(rs.getInt(1));
				imgshows.setImgfilename(rs.getString(2));
				
				imgshow.add(imgshows);
			}// end of while()---------------------------
			
			
		} finally {
			close();
		}
		
		return imgshow;
	}


	
	

}
