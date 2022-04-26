package product.model.leejeongjun;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import member.model.wonhyejin.MemberVO;
import util.security.AES256;
import util.security.SecretMyKey;



public class ProductDAO_ljj implements InterProductDAO_ljj {

	private DataSource ds;	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;	// 우편배달부
	private ResultSet rs;
	
	private AES256 aes;
	
	// 기본생성자
	public ProductDAO_ljj() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semi_prj_shoes_oracle");	// web.xml에 있는 주소
		
		    aes = new AES256(SecretMyKey.KEY);
		    // SecretMyKey.KEY 은 우리가 만든 비밀키이다.
		    
		}catch(NamingException e) {
			e.printStackTrace();
		}catch(UnsupportedEncodingException e) {
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
	
	
	// 페이징 처리가 되어진 모든 상품 또는 검색한 상품 목록 보여주기
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ceil(count(*)/?) "
					   + " from tbl_product ";
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
			
		//	System.out.println("~~~ 확인용 colname =>" + colname);
		//	System.out.println("~~~ 확인용 searchWord =>" + searchWord);
		
			
			if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
				sql += " where "+colname+" like '%'|| ? ||'%' ";
			/*	
			 	위치홀더(?) 에 들어오는 값은 데이터값만 들어올 수 있는 것이지
				위치홀더(?) 에는 컬럼명이나 테이블명이 들어오면 오류가 발생한다.	
				그러므로 컬럼명이나 테이블명이 변수로 사용 할 때는 위치홀더(?)가 아닌 변수로 처리해야 한다.
			*/
			}
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("sizePerPage") );
			
			if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {

				pstmt.setString(2, paraMap.get("searchWord"));

			}
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);
		} finally {
			close();
		}
		
		return totalPage;
	}// end of public int getTotalPage(Map<String, String> paraMap) -----------


	// 페이징 처리가 되어진 모든 상품 또는 검색한 상품 목록 보여주기
	@Override
	public List<ProductVO> selectPagingProduct(Map<String, String> paraMap) throws SQLException {
		
		List<ProductVO> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select pnum, pname, pimage, fk_cnum, fk_snum "
					   + " from "
					   + " ( "
					   + " select rownum AS rno, pnum, pname, pimage, fk_cnum, fk_snum "
					   + "     from "
					   + "     ( "
					   + "         select pnum, pname, pimage, fk_cnum, fk_snum "
					   + "         from tbl_product ";
		
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
			
		//	System.out.println("~~~ 확인용 colname =>" + colname);
		//	System.out.println("~~~ 확인용 searchWord =>" + searchWord);
				   
		    if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
				sql += " where "+colname+" like '%'|| ? ||'%' ";
			/*	
			 	위치홀더(?) 에 들어오는 값은 데이터값만 들어올 수 있는 것이지
				위치홀더(?) 에는 컬럼명이나 테이블명이 들어오면 오류가 발생한다.	
				그러므로 컬럼명이나 테이블명이 변수로 사용 할 때는 위치홀더(?)가 아닌 변수로 처리해야 한다.
			*/
			}			   
					   
					   
				 sql   += "         order by pnum desc "
				 	   + "     ) V "
					   + " ) T "
					   + " where rno between ? and ? ";
			
			
		 
			pstmt = conn.prepareStatement(sql);
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			/*
			 	>>> where rno between A and B 
		        A 와 B 를 구하는 공식 <<<
		        
		        currentShowPageNo 은 보고자 하는 페이지 번호이다. 즉, 1페이지, 2페이지, 3페이지...를 말한다.
		        sizePerPage 는 한 페이지당 보여줄 행의 개수를 말한다. 즉, 3개, 5개, 10개를 보여줄 때의 개수를 말한다.
		        
		        A 는 (currentShowPageNo * sizePerPage) - (sizePerPage - 1) 이다.
		        B 는 (currentShowPageNo * sizePerPage) 이다.
			 */
			
			if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
				
				pstmt.setString(1, searchWord);
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			}
			else {
				pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(2, (currentShowPageNo * sizePerPage));
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ProductVO pvo = new ProductVO();
				pvo.setPnum(rs.getInt(1));
				pvo.setPname(rs.getString(2));
				pvo.setPimage(rs.getString(3));
				pvo.setFk_cnum(rs.getInt(4));
				pvo.setFk_snum(rs.getInt(5));
				
				productList.add(pvo);
			}// end of while----------------------------
			
		} finally {
			close();
		}
		
		return productList;
	} // end of public List<ProductVO> selectPagingProduct(Map<String, String> paraMap)--------


	// tbl_category 테이블에서 카테고리 대분류 번호(cnum), 카테고리코드(code), 카테고리명(cname)을 조회해오기 
	@Override
	public List<HashMap<String, String>> getCategoryList() throws SQLException {
		
		List<HashMap<String, String>> categoryList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select cnum, code, cname "+
					     " from tbl_category "+
					     " order by cnum asc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, String> map = new HashMap<>();
				map.put("cnum", rs.getString(1));
				map.put("code", rs.getString(2));
				map.put("cname", rs.getString(3));
				
				categoryList.add(map);
			}// end of while(rs.next())---------------------------
			
		} finally {
			close();
		}
		
		return categoryList;

	}// end of public List<HashMap<String, String>> getCategoryList()-------------


	
	// spec 목록을 보여주고자 한다.
	@Override
	public List<SpecVO> selectSpecList() throws SQLException {

		List<SpecVO> specList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select snum, sname "+
					     " from tbl_spec "+
					     " order by snum asc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SpecVO spvo = new SpecVO();
				spvo.setSnum(rs.getInt(1));
				spvo.setSname(rs.getString(2));
			
				specList.add(spvo);
			}// end of while(rs.next())-------------
			
		} finally {
			close();
		}
		
		return specList;
	}// end of public List<SpecVO> selectSpecList()------------------


	// 제품번호 채번 해오기
	@Override
	public int getPnumOfProduct() throws SQLException {
		
		int pnum = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select seq_tbl_product_pnum.nextval "+
					     " from dual ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			pnum = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return pnum;
	}


	// tbl_product 테이블에 제품정보 insert 하기
	@Override
	public int productInsert(ProductVO pvo) throws SQLException {

		int result = 0;

		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, prdmanual_systemFileName, prdmanual_orginFileName, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent ,psize, point) " +  
					     " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
		
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, pvo.getPnum());
			pstmt.setString(2, pvo.getPname());
			pstmt.setInt(3, pvo.getFk_cnum());    
	        pstmt.setString(4, pvo.getPcompany()); 
	        pstmt.setString(5, pvo.getPimage());     
	        pstmt.setString(6, pvo.getPrdmanual_systemFileName());
	        pstmt.setString(7, pvo.getPrdmanual_orginFileName());
	        pstmt.setInt(8, pvo.getPqty()); 
	        pstmt.setInt(9, pvo.getPrice());
	        pstmt.setInt(10, pvo.getSaleprice());
	        pstmt.setInt(11, pvo.getFk_snum());
	        pstmt.setString(12, pvo.getPcontent());
	        pstmt.setString(13, pvo.getSummary_pcontent());
	        pstmt.setString(14, pvo.getPsize());
	        pstmt.setInt(15, pvo.getPoint());
	        
	        result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return result;
	}// end of public int productInsert(ProductVO pvo)------------------------------


	// tbl_product_addimagefile 테이블에 insert 하기
	@Override
	public int product_addimagefile_Insert(Map<String, String> paraMap) throws SQLException {
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_product_addimagefile(imgfileno, fk_pnum, imgfilename) "+ 
						 " values(seq_addImgfileno.nextval, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, Integer.parseInt(paraMap.get("pnum")) );
			pstmt.setString(2, paraMap.get("attachFileName"));
			
	        result = pstmt.executeUpdate();
		} finally {
			close();
		}
		return result;
	}//end of public int product_imagefile_Insert(Map<String, String> paraMap)--------------


	// 제품번호를 가지고서 해당 제품의 정보를 조회해오기
	@Override
	public ProductVO selectOneProductByPnum(String pnum) throws SQLException {

		ProductVO pvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql =  " select S.sname, pnum, fk_cnum, pname, pcompany, price, saleprice, point, pqty, summary_pcontent, pcontent, pimage, psize, prdmanual_systemFileName, nvl(prdmanual_orginFileName, '없음') AS prdmanual_orginFileName "
					   	+ " from "
						+ " ( "
						+ "     select fk_snum, pnum, fk_cnum, pname, pcompany, price, saleprice, point, pqty, summary_pcontent, pcontent, pimage, psize, prdmanual_systemFileName, prdmanual_orginFileName "
						+ "     from tbl_product "
						+ "     where pnum = ? "
						+ " ) P JOIN tbl_spec S "
						+ " ON P.fk_snum = S.snum ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pnum);
			
			rs = pstmt.executeQuery();
			
			if( rs.next() ) {
				
				String sname = rs.getString(1);     // "HIT", "NEW", "BEST" 값을 가짐 
	            int    npnum = rs.getInt(2);        // 제품번호
	            int fk_cnum = rs.getInt(3);	// 카테고리번호
	            String pname = rs.getString(4);     // 제품명
	            String pcompany = rs.getString(5);  // 제조회사명
	            int    price = rs.getInt(6);        // 제품 정가
	            int    saleprice = rs.getInt(7);    // 제품 판매가
	            int    point = rs.getInt(8);        // 포인트 점수
	            int    pqty = rs.getInt(9);         // 제품 재고량
	            String summary_pcontent = rs.getString(10);  // 제품요약설명
	            String pcontent = rs.getString(11);  // 제품설명
	            String pimage = rs.getString(12);  // 제품이미지1
	            String psize = rs.getString(13);
	            String prdmanual_systemFileName = rs.getString(14); // 파일서버에 업로드되어지는 실제 제품설명서 파일명
	            String prdmanual_orginFileName = rs.getString(15);  // 웹클라이언트의 웹브라우저에서 파일을 업로드 할때 올리는 제품설명서 파일명
	
	            pvo = new ProductVO();
	            
	            SpecVO spvo = new SpecVO();
	            spvo.setSname(sname);
	            
	            pvo.setSpvo(spvo);
	            pvo.setPnum(npnum);
	            pvo.setFk_cnum(fk_cnum);
	            pvo.setPname(pname);
	            pvo.setPcompany(pcompany);
	            pvo.setPrice(price);
	            pvo.setSaleprice(saleprice);
	            pvo.setPoint(point);
	            pvo.setPqty(pqty);
	            pvo.setSummary_pcontent(summary_pcontent);
	            pvo.setPcontent(pcontent);
	            pvo.setPimage(pimage);
	            pvo.setPsize(psize);
	            pvo.setPrdmanual_systemFileName(prdmanual_systemFileName);
	            pvo.setPrdmanual_orginFileName(prdmanual_orginFileName);
	                
			} //  end of if( rs.next() ) ----------------
			
		} finally {
			close();
		}
			
		return pvo;
	}// end of public ProductVO selectOneProductByPnum(String pnum)--------------------


	@Override
	public List<String> getImagesByPnum(String pnum) throws SQLException {
		
		List<String> imgList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select imgfilename "
					+ " from tbl_product_addimagefile "
					+ " where fk_pnum = ? ";
			 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pnum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String imgfilename = rs.getString(1); // 추가되어진 이미지 파일명
				imgList.add(imgfilename);
			}// end of while()--------------------------------
			
		} finally {
			close();
		}
		
		return imgList;
	}// end of public List<String> getImagesByPnum(String pnum)--------------


	// 제품번호를 가지고 해당 제품을 삭제하기
	@Override
	public int deleteProduct(String pnum) throws SQLException {
		
		int result=0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " delete from tbl_product "
					+ " where pnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pnum);
			
			result = pstmt.executeUpdate();
		
		} finally {
			close();
		}
		
		return result;
	}// end of public int deleteProduct(String pnum)-------------


	// 장바구니에 제품 담기
	// 장바구니 테이블에 해당 제품이 존재하지 않는 경우에는 tbl_cart 테이블에 insert 를 해야하고,
	// 장바구니 테이블에 해당 제품이 존재하는 경우에는 또 그 제품을 추가해서 장바구니 담기를 한다라면 tbl_cart 테이블에 updat 를 해야 한다.
	@Override
	public int addCart(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
		
			String sql = " select cartno "
					   + " from tbl_cart "
					   + " where fk_userid = ? and "
					   + " fk_pnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, paraMap.get("pnum"));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// 어떤 제품을 추가로 장바구니에 넣고자 하는 경우
				
				int cartno = rs.getInt(1);
				
				sql = " update tbl_cart set oqty = oqty + ? "
					+ " where cartno = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(paraMap.get("oqty")) );
				pstmt.setInt(2, cartno);
				
				n = pstmt.executeUpdate();
			}
			else {
				// 장바구니에 존재하지 않는 새로운 제품을 넣고자 하는 경우
				
				sql = " insert into tbl_cart(cartno, fk_userid, fk_pnum, oqty, registerday) "
					+ " values(seq_tbl_cart_cartno.nextval, ?, ?, ?, default) ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setInt(2, Integer.parseInt(paraMap.get("pnum")));
				pstmt.setInt(3, Integer.parseInt(paraMap.get("oqty")));
			
				n = pstmt.executeUpdate();
			}
			
		} finally {
			close();
		}
		
		return n;
	}// end of public int addCart(Map<String, String> paraMap)---------------------


	// *** 주문내역에 대한 페이징 처리를 위해 주문 갯수를 알아오기 위한 것으로
	//     관리자가 아닌 일반사용자로 로그인 했을 경우에는 자신이 주문한 갯수만 알아오고,
	//     관리자로 로그인을 했을 경우에는 모든 사용자들이 주문한 갯수를 알아온다.
	@Override
	public int getTotalCountOrder(String userid) throws SQLException {

		int totalCountOrder = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*)"
					+ "from tbl_order A JOIN tbl_orderdetail B "
					+ "on A.odrcode = B.fk_odrcode ";
			
			if("admin".equals(userid)) {	//관리자로 로그인 할 경우 모든 주문내역 보여준다.
				pstmt = conn.prepareStatement(sql);
			}
			else {
				// 관리자가 아닌 일반사용자로 로그인 한 경우
				sql += " where A.fk_userid = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
			}
			
			rs = pstmt.executeQuery();
			rs.next();
			
			totalCountOrder = rs.getInt(1);
		} finally {
			close();
		}
		
		return totalCountOrder;
	}// end of public int getTotalCountOrder(String userid)----------------------------


	// *** 관리자가 아닌 일반사용자로 로그인 했을 경우에는 자신이 주문한 내역만 페이징 처리하여 조회를 해오고,
    //     관리자로 로그인을 했을 경우에는 모든 사용자들의 주문내역을 페이징 처리하여 조회해온다.
	@Override
	public List<Map<String, String>> getOrderList(String userid, int currentShowPageNo, int sizePerPage)
			throws SQLException {
		
		List<Map<String, String>> orderList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select odrcode, fk_userid, odrdate, odrseqnum, fk_pnum, oqty, odrprice, deliverstatus, "
					   + "        pname, pimage, price, saleprice, point, psize "
					   + " from "
					   + " ( "
					   + " select row_number() over (order by B.fk_odrcode desc, B.odrseqnum desc) AS RNO "
					   + "       , A.odrcode, A.fk_userid "
				   	   + "       , to_char(A.odrdate, 'yyyy-mm-dd hh24:mi:ss') AS odrdate "
					   + "       , B.odrseqnum, B.fk_pnum, B.oqty, B.odrprice "
					   + "       , case B.deliverstatus "
					   + "         when 1 then '주문완료' "
					   + "         when 2 then '배송중' "
					   + "         when 3 then '배송완료' "
					   + "         end AS deliverstatus "
					   + "     , C.pname, C.pimage, C.price, C.saleprice, C.point, C.psize "
					   + " from tbl_order A join tbl_orderdetail B "
					   + " on A.odrcode = B.fk_odrcode "
					   + " join tbl_product C "
					   + " on B.fk_pnum = C.pnum ";
			
			if(!"admin".equals(userid)) {
				// 관리자가 아닌 일반사용자로 로그인 한 경우
				sql += " where A.fk_userid = ? ";
			}
			
			sql += " ) V "
				 + " where RNO between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			if(!"admin".equals(userid)) {
				// 관리자가 아닌 일반사용자로 로그인 한 경우
				pstmt.setString(1, userid);
				pstmt.setInt(2, (currentShowPageNo*sizePerPage)-(sizePerPage-1) ); // 공식
	            pstmt.setInt(3, currentShowPageNo*sizePerPage ); // 공식
			}
			else {
				// 롼리자로 로그인 한 경우
				pstmt.setInt(1, (currentShowPageNo*sizePerPage)-(sizePerPage-1) ); // 공식
	            pstmt.setInt(2, currentShowPageNo*sizePerPage ); // 공식
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String odrcode = rs.getString("odrcode");
                String fk_userid = rs.getString("fk_userid");
                String odrdate = rs.getString("odrdate");
                String odrseqnum = rs.getString("odrseqnum");
                String fk_pnum = rs.getString("fk_pnum");
                String oqty = rs.getString("oqty");
                String odrprice = rs.getString("odrprice");
                String deliverstatus = rs.getString("deliverstatus");
                String pname = rs.getString("pname");
                String pimage = rs.getString("pimage");
                String price = rs.getString("price");
                String saleprice = rs.getString("saleprice");
                String point = rs.getString("point");
                String psize = rs.getString("psize");
                
                Map<String, String> odrmap = new HashMap<>();
                odrmap.put("ODRCODE", odrcode);
                odrmap.put("FK_USERID", fk_userid);
                odrmap.put("ODRDATE", odrdate);
                odrmap.put("ODRSEQNUM", odrseqnum);
                odrmap.put("FK_PNUM", fk_pnum);
                odrmap.put("OQTY", oqty);
                odrmap.put("ODRPRICE", odrprice);
                odrmap.put("DELIVERSTATUS", deliverstatus);
                odrmap.put("PNAME", pname);
                odrmap.put("PIMAGE", pimage);
                odrmap.put("PRICE", price);
                odrmap.put("SALEPRICE", saleprice);
                odrmap.put("POINT", point);
                odrmap.put("PSIZE", psize);
                
                orderList.add(odrmap);
                
			}// end of while(rs.next())--------------------------------------------
			
		} finally {
			close();
		}
		
		return orderList;
	}// end of public List<Map<String, String>> getOrderList(String userid, int currentShowPageNo, int sizePerPage)--------------


	// Ajax 를 이용한 제품후기를 작성하기전 해당 제품을 사용자가 실제 구매했는지 여부를 알아오는 것임. 구매했다라면 true, 구매하지 않았다면 false 를 리턴함.
	@Override
	public boolean isOrder(Map<String, String> paraMap) throws SQLException {

		boolean bool = false;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select O.odrcode "
					   + " from tbl_order O JOIN tbl_orderdetail D "
					   + " on O.odrcode = D.fk_odrcode "
					   + " where O.fk_userid = ? and D.fk_pnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("fk_userid"));
			pstmt.setString(2, paraMap.get("fk_pnum"));
			
			rs = pstmt.executeQuery();
			
			bool = rs.next();
			
		} finally {
			close();
		}
		
		return bool;
		
	}// end of public boolean isOrder(Map<String, String> paraMap)------------------


	// 특정 회원이 특정 제품에 대해 좋아요에 투표하기(insert) 
	@Override
	public int likeAdd(Map<String, String> paraMap) throws SQLException {

		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			conn.setAutoCommit(false); 	// 수동 커밋으로 전환
			
			String sql = " delete from tbl_product_dislike "
					   + " where fk_userid = ? and fk_pnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, paraMap.get("pnum"));
			
			pstmt.executeUpdate();
			
			sql = " insert into tbl_product_like(fk_userid, fk_pnum) "
				+ " values(?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, paraMap.get("pnum"));
			
			n = pstmt.executeUpdate();
			
			if(n==1) {	// 정상적으로 실행 되었다면.
				conn.commit();
			}
			
		} catch(SQLIntegrityConstraintViolationException e) {	
		//	e.printStackTrace();
			conn.rollback();
		} finally {
			close();
		}
		
		return n;
	}// end of public int likeAdd(Map<String, String> paraMap)----------------


	// 특정 회원이 특정 제품에 대해 싫어요에 투표하기(insert) 
	@Override
	public int dislikeAdd(Map<String, String> paraMap) throws SQLException {

		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			conn.setAutoCommit(false); 	// 수동 커밋으로 전환
			
			String sql = " delete from tbl_product_like "
					   + " where fk_userid = ? and fk_pnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, paraMap.get("pnum"));
			
			pstmt.executeUpdate();
			
			sql = " insert into tbl_product_dislike(fk_userid, fk_pnum) "
				+ " values(?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, paraMap.get("pnum"));
			
			n = pstmt.executeUpdate();
			
			if(n==1) {	// 정상적으로 실행 되었다면.
				conn.commit();
			}
			
		} catch(SQLIntegrityConstraintViolationException e) {	
		//	e.printStackTrace();
			conn.rollback();
		} finally {
			close();
		}
		
		return n;
	}// end of public int dislikeAdd(Map<String, String> paraMap)


	
	// 특정 제품에 대한 좋아요,싫어요의 투표결과(select)
	@Override
	public Map<String, Integer> getLikeDislikeCnt(String pnum) throws SQLException {

		Map<String, Integer> map = new HashMap<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select "
					   + " 		(select count(*) "
					   + " 		from tbl_product_like "
					   + " 		where fk_pnum = ?) AS LIKECNT "
					   + " , "
					   + " 		(select count(*) "
					   + " 		from tbl_product_dislike "
				       + " 		where fk_pnum = ?) AS DISLIKECNT "
					   + " from dual ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pnum);
			pstmt.setString(2, pnum);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			map.put("likecnt", rs.getInt(1));
			map.put("dislikecnt", rs.getInt(2));
			
		} finally {
			close();
		}
		
		return map;
	}// end of public Map<String, Integer> getLikeDislikeCnt(String pnum)------------


	
	// Ajax 를 이용한 특정 제품의 상품후기를 입력(insert)하기 
	@Override
	public int addComment(PurchaseReviewsVO reviewsvo) throws SQLException {

		int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " insert into tbl_purchase_reviews(review_seq, fk_userid, fk_pnum, contents, writeDate) "
	                  + " values(seq_purchase_reviews.nextval, ?, ?, ?, default) ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, reviewsvo.getFk_userid());
	         pstmt.setInt(2, reviewsvo.getFk_pnum());
	         pstmt.setString(3, reviewsvo.getContents());
	         
	         n = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return n;
	}
	
	
	
	// Ajax 를 이용한 특정 제품의 상품후기를 조회(select)하기
	@Override
	public List<PurchaseReviewsVO> commentList(String fk_pnum) throws SQLException {
		
		List<PurchaseReviewsVO> commentList = new ArrayList<>();
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select review_seq, fk_userid, name, fk_pnum, contents, to_char(writeDate, 'yyyy-mm-dd hh24:mi:ss') AS writeDate "+
	                    " from tbl_purchase_reviews R join tbl_member M "+
	                    " on R.fk_userid = M.userid  "+
	                    " where R.fk_pnum = ? "+
	                    " order by review_seq desc ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, fk_pnum);
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()) {
	            String contents = rs.getString("contents");
	            String name = rs.getString("name");
	            String writeDate = rs.getString("writeDate");
	            String fk_userid = rs.getString("fk_userid");
	            int review_seq = rs.getInt("review_seq");
	                                    
	            PurchaseReviewsVO reviewvo = new PurchaseReviewsVO();
	            reviewvo.setContents(contents);
	            
	            MemberVO mvo = new MemberVO();
	            mvo.setName(name);
	            
	            reviewvo.setMvo(mvo);
	            reviewvo.setWriteDate(writeDate);
	            reviewvo.setFk_userid(fk_userid);
	            reviewvo.setReview_seq(review_seq);
	            
	            commentList.add(reviewvo);
	         }         
	         
	      } finally {
	         close();
	      }
	      
	      return commentList;
	}// end of public List<PurchaseReviewsVO> commentList(String fk_pnum)---------------


	
	// Ajax 를 이용한 특정 제품의 상품후기를 삭제(delete)하기
	@Override
	public int reviewDel(String review_seq) throws SQLException {

		int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " delete from tbl_purchase_reviews "
	         		+ " where review_seq = ? ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, review_seq);
	        
	         n = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return n;
		
	}// end of public int reviewDel(String review_seq)


	// Ajax 를 이용한 특정 제품의 상품후기를 수정(update)하기
	@Override
	public int reviewUpdate(Map<String, String> paraMap) throws SQLException {

		int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " update tbl_purchase_reviews set contents = ? , writedate = sysdate "
	                  + " where review_seq = ? ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, paraMap.get("contents"));
	         pstmt.setString(2, paraMap.get("review_seq"));
	         
	         n = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return n;
	}// end of public int reviewUpdate(Map<String, String> paraMap)--------------


	
	// 영수증전표(odrcode) 소유주에 대한 사용자 정보를 조회해오는 것.
	@Override
	public MemberVO odrcodeOwnerMemberInfo(String odrcode) throws SQLException {
		
		MemberVO mvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender "+
					     "       ,substr(birthday,1,4) AS birthyyyy, substr(birthday,6,2) AS birthmm, substr(birthday,9) AS birthdd "+
					     "       , point, to_char(registerday, 'yyyy-mm-dd') AS registerday "+
					     " from tbl_member "+
					     " where userid = ( select fk_userid " +
					     "					from tbl_order " +
					     "					where odrcode = ? )";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, odrcode);
		
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mvo = new MemberVO();
				
				mvo.setUserid(rs.getString(1));
				mvo.setName(rs.getString(2));
				mvo.setEmail(aes.decrypt(rs.getString(3)) );	// 복호화
				mvo.setMobile(aes.decrypt(rs.getString(4)) ); // 복호화
				mvo.setPostcode(rs.getString(5));
				mvo.setAddress(rs.getString(6));
				mvo.setDetailaddress(rs.getString(7));
				mvo.setExtraaddress(rs.getString(8));
				mvo.setGender(rs.getString(9));
	            
				mvo.setBirthday(rs.getString(10) + rs.getString(11) + rs.getString(12));
				mvo.setPoint(rs.getInt(13));
				mvo.setRegisterday(rs.getString(14));
			}
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();	
		} finally {
			close();
		}
		
		return mvo;
	}// end of public MemberVO odrcodeOwnerMemberInfo(String odrcode)---------------


	// tbl_orderdetail 테이블의 deliverstatus(배송상태) 컬럼의 값을 2(배송시작)로 변경하기
	@Override
	public int updateDeliverStart(String odrcodePnum) throws SQLException {

		int n = 0;
	      
	    try {
	         conn = ds.getConnection();
	         
	         String sql = " update tbl_orderdetail set deliverstatus = 2 "
	                  + " where fk_odrcode || '/' || fk_pnum in("+odrcodePnum+") ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         n = pstmt.executeUpdate();
	         
	    } finally {
	         close();
	    }
	    
	    return n;
	}// end of public int updateDeliverStart(String odrcodePnum) ------------------


	
	// tbl_orderdetail 테이블의 deliverstatus(배송상태) 컬럼의 값을 3(배송완료)로 변경하기
	@Override
	public int updateDeliverEnd(String odrcodePnum) throws SQLException {
		
		int n = 0;
	      
	    try {
	         conn = ds.getConnection();
	         
	         String sql = " update tbl_orderdetail set deliverstatus = 3 "
	                  + " where fk_odrcode || '/' || fk_pnum in("+odrcodePnum+") ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         n = pstmt.executeUpdate();
	         
	    } finally {
	         close();
	    }
	      
	    return n;
	}// end of public int updateDeliverEnd(String odrcodePnum)-----------------


	
	
	


	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
