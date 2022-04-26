package product.model.kimjieun;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;

public class ProductDAO_kje implements InterProductDAO_kje {
	
	private DataSource ds;	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;	// 우편배달부
	private ResultSet rs;
	private AES256 aes;

	
	// 기본생성자
	public ProductDAO_kje() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semi_prj_shoes_oracle");	// web.xml에 있는 주소
		
		   
		    aes = new AES256(SecretMyKey.KEY);
		    // SecretMyKey.KEY 은 우리가 만든 비밀키이다.
		    
		} catch(NamingException e) {
			e.printStackTrace();
		} catch(UnsupportedEncodingException e) {
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

	
	///////////////////////////////////////////////////////////////////////////////
	
	
	// 카테고리
		@Override
		public List<HashMap<String, String>> getCategoryList() throws SQLException {
			
			List<HashMap<String, String>> categoryList = new ArrayList<>();
			
			try {
				conn = ds.getConnection();
				
				String sql = " select cnum, code, cname "
						   + " from tbl_category "
						   + " order by cnum asc ";
				
				pstmt = conn.prepareStatement(sql);
				   
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					HashMap<String, String> map = new HashMap<>();
					map.put("cnum", rs.getString(1));
					map.put("code", rs.getString(2));
					map.put("cname", rs.getString(3));
					
					categoryList.add(map);
				}// end of while(rs.next())---------------------
							
			} finally {
				close();
			}
			
			return categoryList;
		}


	// 모든제품 조회
	@Override
	public List<ProductVO> allProductSelect(Map<String, String> paraMap, Map<String, String> cateMap, String check) throws SQLException {
		

		List<ProductVO> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select pnum, pname, pimage, price "
					   + " from tbl_product ";
			
			String colname = paraMap.get("optionType");
			String cnum = cateMap.get("cnum");
			
			if("highprice".equals(colname)) {
				sql += " order by price desc ";
			}
			if("lowprice".equals(colname)) {
				sql += " order by price ";
			}
			if(cnum != null) {
				sql += "where fk_cnum = ? ";		
			}
			if(check == "1") {
				sql += " where pqty != 0 ";
			}
			
		/*	if() {
				sql += " where pqty != 0 ";
			}
		*/	
			pstmt = conn.prepareStatement(sql);
			
			if(cnum != null) {
				pstmt.setString(1, cnum);
				
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ProductVO pvo = new ProductVO(); // product.model.kimjieun.ProductVO
				pvo.setPnum(rs.getInt(1));
				pvo.setPname(rs.getString(2));
				pvo.setPimage(rs.getString(3));
				pvo.setPrice(rs.getInt(4));
				
				productList.add(pvo);
				
			}// end of while---------
			
		} finally {
			close();
		}
		
		return productList;
	}

	// Ajax(JSON)를 사용하여 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라서(start ~ end) 조회해오기  
			@Override
			public List<ProductVO> selectBySpecName(Map<String, String> paraMap) throws SQLException {
				
				List<ProductVO> prodList = new ArrayList<>();
				
				try {
					 conn = ds.getConnection();
					 
					 String sql = " select pnum, pname, code, pcompany, pimage, pqty, price, saleprice, sname, pcontent, point, pinputdate "
						 		+ " from "
						 		+ " ( "
						 		+ "    select row_number() over(order by P.pnum desc) AS RNO "
						 		+ "         , P.pnum, P.pname, C.code, P.pcompany, P.pimage, P.pqty, P.price, P.saleprice, S.sname, P.pcontent, P.point "  
						 		+ "         , to_char(P.pinputdate, 'yyyy-mm-dd') AS pinputdate "
						 		+ "    from tbl_product P "
						 		+ "    JOIN tbl_category C "
						 		+ "    ON P.fk_cnum = C.cnum "
						 		+ "    JOIN tbl_spec S "
						 		+ "    ON P.fk_snum = S.snum "
						 		+ "    where S.sname = ? "
						 		+ " ) V "
						 		+ " where V.RNO between ? and ? ";
					 
					 pstmt = conn.prepareStatement(sql);
					 pstmt.setString(1, paraMap.get("sname"));
					 pstmt.setString(2, paraMap.get("start"));
					 pstmt.setString(3, paraMap.get("end"));
					 
					 rs = pstmt.executeQuery();
					 
					 while(rs.next()) {
						 
						 ProductVO pvo = new ProductVO();
						 
						 pvo.setPnum(rs.getInt(1));     // 제품번호
						 pvo.setPname(rs.getString(2)); // 제품명
						 
						 CategoryVO categvo = new CategoryVO(); 
						 categvo.setCode(rs.getString(3)); 
						 
						 pvo.setCategvo(categvo);           // 카테고리코드 
						 pvo.setPcompany(rs.getString(4));  // 제조회사명
						 pvo.setPimage(rs.getString(5));   // 제품이미지   이미지파일명
						 pvo.setPqty(rs.getInt(6));         // 제품 재고량
						 pvo.setPrice(rs.getInt(7));        // 제품 정가
						 pvo.setSaleprice(rs.getInt(8));    // 제품 판매가(할인해서 팔 것이므로)
							
						 SpecVO spvo = new SpecVO(); 
						 spvo.setSname(rs.getString(9)); 
						 
						 pvo.setSpvo(spvo); // 스펙 
							
						 pvo.setPcontent(rs.getString(10));	  // 제품설명 
						 pvo.setPoint(rs.getInt(11));         // 포인트 점수  	   
						 pvo.setPinputdate(rs.getString(12)); // 제품입고일자
						 
						 prodList.add(pvo);
					 }// end of while(rs.next())-------------------------------
					 
				} finally {
					close();
				}
				
				return prodList;
			}


			// Ajax(JSON)를 사용하여 상품목록을 "더보기" 방식으로 페이징처리 해주기 위해 스펙별로 제품의 전체개수 알아오기 // 
			@Override
			public int totalPspecCount(String fk_snum) throws SQLException {
				int totalCount = 0;
				
				try {
					 conn = ds.getConnection();
					 
					 String sql = " select count(*) "+
							      " from tbl_product "+
							      " where fk_snum = ? ";
					 
					 pstmt = conn.prepareStatement(sql);
					 pstmt.setString(1, fk_snum);
					 
					 rs = pstmt.executeQuery();
					 
					 rs.next();
					 
					 totalCount = rs.getInt(1);
					 
				} finally {
					close();
				}
				
				return totalCount;
			
			}

	
	// 장바구니 제품 조회
	@Override
	public List<CartVO> selectProductCart(String userid) throws SQLException {
		
		List<CartVO> cartList = new ArrayList<>();
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select A.cartno, A.fk_userid, A.fk_pnum, "+
	                    "        B.pname, B.pimage, B.price, B.saleprice, B.point, A.oqty "+
	                    " from tbl_cart A join tbl_product B "+
	                    " on A.fk_pnum = B.pnum "+
	                    " where A.fk_userid = ? "+
	                    " order by A.cartno desc ";
			 
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, userid);
			 
			 rs = pstmt.executeQuery();
			 
			 while( rs.next() ) {

				    int cartno = rs.getInt("cartno");
		            String fk_userid = rs.getString("fk_userid");
		            int fk_pnum = rs.getInt("fk_pnum");
		            String pname = rs.getString("pname");
		            String pimage = rs.getString("pimage");
		            int price = rs.getInt("price");
		            int saleprice = rs.getInt("saleprice");
		            int point = rs.getInt("point");
		            int oqty = rs.getInt("oqty");  // 주문량 
		            
		            ProductVO prodvo = new ProductVO();
		            prodvo.setPnum(fk_pnum);
		            prodvo.setPname(pname);
		            prodvo.setPimage(pimage);
		            prodvo.setPrice(price);
		            prodvo.setSaleprice(saleprice);
		            prodvo.setPoint(point);
				 
		            // *** !!! 중요함 !!! *** //
		            
		            prodvo.setTotalPriceTotalPoint(oqty);
		            
		            // *** !!! 중요함 !!! *** //
		            
		            CartVO cvo = new CartVO();
		            cvo.setCartno(cartno);
		            cvo.setUserid(fk_userid);
		            cvo.setPnum(fk_pnum);
		            cvo.setOqty(oqty);
		            cvo.setProd(prodvo);
		            
		            cartList.add(cvo);
			 }// end of while---------------------------
			 
		} finally {
			close();
		}
		
		
		return cartList;
	}



	// 장바구니 테이블에서 특정제품을 주문량 변경하기
		@Override
		public int updateCart(Map<String, String> paraMap) throws SQLException {
			
			int n = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " update tbl_cart set oqty = ? "
						+ " where cartno = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("oqty"));
				pstmt.setString(2, paraMap.get("cartno"));
				
				n = pstmt.executeUpdate();
				
			}finally{
				close();
			}
			
			return n;
		}
		
		// 로그인한 사용자의 장바구니에 담긴 주문총액합계 및 총포인트 합계 알아오기
		@Override
		public Map<String, String> selectCartSumPricePoint(String userid) throws SQLException {

			Map<String, String> resultMap = new HashMap<>();
					
			try {
				 conn = ds.getConnection();
				 
				 String sql = " select NVL( sum(B.saleprice *  A.oqty), 0)  as SUMTOTALPRICE " +
				 		      "             , NVL( sum(B.point * A.oqty), 0) as SUMTOTALPOINT " +
		                     " from tbl_cart A join tbl_product B "+
		                     " on A.fk_pnum = B.pnum "+
		                     " where A.fk_userid = ? ";
				  
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1, userid);
				 
				 rs = pstmt.executeQuery();
				 
				 rs.next();
				 
				 resultMap.put("SUMTOTALPRICE", rs.getString(1));
				 resultMap.put("SUMTOTALPOINT", rs.getString(2));
				 
				 int DELIVERYPRICE = 0;
				 
				 if(Integer.parseInt(rs.getString(1)) < 50000 ) {
					DELIVERYPRICE = 5000;
				 }
				 
				 resultMap.put("DELIVERYPRICE", String.valueOf(DELIVERYPRICE));
				 
			} finally {
				close();
			}
			
			return resultMap;
		}

	
	
	//장바구니에 담긴 물건갯수 알아오기 select
	   @Override
	   public int getCartCount(String userid) throws SQLException {
	      int n = 0;
	         
	         try {
	            conn = ds.getConnection();
	            
	            String sql = " select count(*) from tbl_cart "
	                       + " where fk_userid = ? ";
	                     
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, userid);
	            
	            rs = pstmt.executeQuery();
	            
	            if(rs.next()) {
	               n = rs.getInt(1);
	            }
	            
	            
	         } finally {
	            close();
	         }
	         
	         return n;
	   }

	
	
		// 장바구니에 담긴 물건 갯수알아오기 select
		@Override
		public List<ProductVO> cateProductSelect(String cnum) throws SQLException {

			List<ProductVO> categoryList = new ArrayList<>();
			
			try {
				
				conn = ds.getConnection();
				
				String sql =" select pnum, pname, pimage, price "
						+  " from tbl_product "
						+  " where fk_cnum = ? ";
					
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, cnum);
						
						
				rs = pstmt.executeQuery();
						
				while(rs.next()) {
					ProductVO pvo = new ProductVO(); // product.model.kimjieun.ProductVO "
					pvo.setPnum(rs.getInt(1));
					pvo.setPname(rs.getString(2));
					pvo.setPimage(rs.getString(3));
					pvo.setPrice(rs.getInt(4));
					
					categoryList.add(pvo);
					
				}
				
			}finally {
				close();
			}
			
			return categoryList;
		}

		
		// 장바구니 제품 delete
		@Override
		public int delCart(String cartno) throws SQLException {
			int n = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " delete from tbl_cart "
						+ " where cartno = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, cartno);
				
				n = pstmt.executeUpdate();
				
			}finally{
				close();
			}
			
			return n;
		}


		// 주문번호(시퀀스 seq_tbl_order 값)을 채번해오는 것.
		@Override
		public int getSeq_tbl_order() throws SQLException {
			
			int seq = 0;
			
			try {
				 conn = ds.getConnection();
				 
				 String sql = " select seq_tbl_order.nextval "
				 		    + " from dual ";
				  
				 pstmt = conn.prepareStatement(sql);
				
				 rs = pstmt.executeQuery();
				 rs.next();

				 seq = rs.getInt(1);
				 
			} finally {
				close();
			}
			
			return seq;
		}

		// ===== Transaction 처리하기 ===== // 
	    // >> 앞에서 미리 했으므로 안함 1. 주문 테이블에 입력되어야할 주문전표를 채번(select)하기 
	    
		// 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
	    // 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
	    // 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리) 
	    
	    // 5. 장바구니 테이블에서 cartnojoin 값에 해당하는 행들을 삭제(delete OR update)하기(수동커밋처리) 
	    // >> 장바구니에서 주문을 한 것이 아니라 특정제품을 바로주문하기를 한 경우에는 장바구니 테이블에서 행들을 삭제할 작업은 없다. << 

	    // 6. 회원 테이블에서 로그인한 사용자의 coin 액을 sumtotalPrice 만큼 감하고, point 를 sumtotalPoint 만큼 더하기(update)(수동커밋처리) 
	    // 7. **** 모든처리가 성공되었을시 commit 하기(commit) **** 
	    // 8. **** SQL 장애 발생시 rollback 하기(rollback) **** 
		@Override
		public int orderAdd(Map<String, Object> paraMap) throws SQLException {
			
			int isSuccess = 0;
			
			int n1=0, n2=0, n3=0, n4=0;
			
			try {
				conn = ds.getConnection();
				
				conn.setAutoCommit(false);   // 수동커밋
				
				// 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
				String sql = " insert into tbl_order(odrcode, fk_userid, odrtotalPrice, odrtotalPoint, odrdate) "
						   + " values(?, ?, ?, ?, default) ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, (String)paraMap.get("odrcode"));
				pstmt.setString(2, (String)paraMap.get("userid"));
				pstmt.setInt(3, Integer.parseInt((String)paraMap.get("sumtotalPrice")) );
				pstmt.setInt(4, Integer.parseInt((String)paraMap.get("sumtotalPoint")) );
				
				n1 = pstmt.executeUpdate();
				System.out.println("~~~~~ n1 : " + n1);
				
				// 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
				if(n1 == 1) {
					
					String[] pnumArr = (String[])paraMap.get("pnumArr");
					String[] oqtyArr = (String[])paraMap.get("oqtyArr");
					String[] totalPriceArr = (String[])paraMap.get("totalPriceArr");
					
					int cnt = 0;
					for(int i=0; i<pnumArr.length; i++) {
						
						sql = " insert into tbl_orderdetail(odrseqnum, fk_odrcode, fk_pnum, oqty, odrprice, deliverStatus) "
							+ " values(seq_tbl_orderdetail.nextval, ?, to_number(?), to_number(?), to_number(?), default) ";
						
						
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, (String)paraMap.get("odrcode"));
						pstmt.setString(2, pnumArr[i]);
						pstmt.setString(3, oqtyArr[i]);
						pstmt.setString(4, totalPriceArr[i]);
						
						pstmt.executeUpdate();
						cnt++;
					}// end of for---------------------------
					
					
					if(cnt== pnumArr.length) {
						n2 = 1;
					}
					System.out.println("~~~~~ n2 : " + n2);	
				}// end of if(n1 == 1) 
				
				
			    // 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리) 
				if(n2 == 1) {
					String[] pnumArr = (String[])paraMap.get("pnumArr");
					String[] oqtyArr = (String[])paraMap.get("oqtyArr");
					
					int cnt = 0;
					for(int i=0; i<pnumArr.length; i++) {
						
						sql = " update tbl_product set pqty = pqty - ? "
							+ " where pnum = ? ";
						
						
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, Integer.parseInt(oqtyArr[i]) );
						pstmt.setString(2, pnumArr[i]);
						
						pstmt.executeUpdate();
						cnt++;
					}// end of for---------------------------
					
					
					if(cnt== pnumArr.length) {
						n3 = 1;
					}
					System.out.println("~~~~~ n3 : " + n3);	
				}// end of if(n2==1)--------------------------------
				
				// 5. 장바구니 테이블에서 cartnojoin 값에 해당하는 행들을 삭제(delete OR update)하기(수동커밋처리) 
			    // >> 장바구니에서 주문을 한 것이 아니라 특정제품을 바로주문하기를 한 경우에는 장바구니 테이블에서 행들을 삭제할 작업은 없다. << 
				
				if(paraMap.get("cartnojoin") != null && n3 == 1) {
					
					String cartnojoin = (String) paraMap.get("cartnojoin");
					
					sql = " delete from tbl_cart "
						+ " where cartno in ("+cartnojoin+") ";
					
				     //  !!! in 절은 위와 같이 직접 변수로 처리해야 함. !!! 
			         //  in 절에 사용되는 것들은 컬럼의 타입을 웬만하면 number 로 사용하는 것이 좋다. 
			         //  왜냐하면 varchar2 타입으로 되어지면 데이터 값에 앞뒤로 홑따옴표 ' 를 붙여주어야 하는데 이것을 만들수는 있지만 귀찮기 때문이다.    
			            
			         /*   
			            sql = " delete from tbl_cart "
			               + " where cartno in (?) ";
			            // !!! 위와 같이 위치홀더 ? 를 사용하면 하면 안됨. !!!       
			         */
					
					pstmt = conn.prepareStatement(sql);				
					n4 = pstmt.executeUpdate();
					
					System.out.println("~~~~~ n4 : " + n4);	
					// 만약에 장바구니 비우기를 할 행이 3개라면
					// ~~~~~ n4 : 3
					
				}// end of if(paraMap.get("cartnojoin") != null && n3 == 1) -----------------------
				
				if( paraMap.get("cartnojoin") == null && n3 == 1 ) {
					// "제품 상세 정보" 페이지에서 "바로주문하기"를 한 경우
					// 장바구니 번호인 paraMap.get("cartnojoin") 이 없는 것이다.
					
					n4 =1;
					
					System.out.println("~~~~~ 바로주문하기 인 경우 n4 : " + n4);	
					// ~~~~~ 바로주문하기 인 경우 n4 : 1
				}// end of if( paraMap.get("cartnojoin") == null && n3 == 1 ) ---------------------
				
			    // 6. 회원 테이블에서 로그인한 사용자의 coin 액을 sumtotalPrice 만큼 감하고, point 를 sumtotalPoint 만큼 더하기(update)(수동커밋처리) 
	//			if(n4>0) {
	//				sql = " update tbl_member set point = point + ? "
	//					+ " where userid = ? ";
					
	//				pstmt = conn.prepareStatement(sql);
					
	//				pstmt.setInt(1, Integer.parseInt((String)paraMap.get("sumtotalPoint")) );
	//				pstmt.setString(2, (String)paraMap.get("userid"));

	//				n5 = pstmt.executeUpdate();
	//				System.out.println("~~~~~ n5 : " + n5);	
	//
	//			}// end of if(n4>0)-----------------------------
				
			    // 7. **** 모든처리가 성공되었을시 commit 하기(commit) **** 
				if(n1*n2*n3*n4 >0) {
					
					conn.commit();
					conn.setAutoCommit(false);   // 자동커밋으로 전환

					System.out.println("n1*n2*n3*n4 = " + (n1*n2*n3*n4));
				
					isSuccess= 1;
				}
				
			}catch(SQLException e){
				e.printStackTrace();
				
				// 8. **** SQL 장애 발생시 rollback 하기(rollback) **** 
				conn.rollback();
				conn.setAutoCommit(false);   
				// 자동커밋으로 전환
				
				isSuccess = 0;
				
			}finally {
				close();
			}
			
			return isSuccess;
		}

		
		// 주문제품 보여주기 (select)
		@Override
		public List<OrderVO> selectOrderProduct(String odrcode) throws SQLException{
			
			List<OrderVO> odrList = new ArrayList<>();
			
			try {
				
				conn = ds.getConnection();
				
				String sql = " select odrcode, pnum, pname, pimage, saleprice, psize, oqty, odrtotalprice "
						+ " from "
						+ " (select * "
						+ " from tbl_order O join tbl_orderdetail D "
						+ " on O.odrcode = D.fk_odrcode  "
						+ " join tbl_product P "
						+ " on D.fk_pnum = P.pnum "
						+ " ) V "
						+ " where odrcode = ?  ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, odrcode);
						
						
				rs = pstmt.executeQuery();
						
				while(rs.next()) {
					
					OrderVO ovo = new OrderVO();
					ovo.setOdrcode(rs.getString(1));
					
					ProductVO pvo = new ProductVO(); // product.model.kimjieun.ProductVO "
					pvo.setPnum(rs.getInt(2));
					pvo.setPname(rs.getString(3));
					pvo.setPimage(rs.getString(4));
					pvo.setSaleprice(rs.getInt(5));
					pvo.setPsize(rs.getString(6));
				
					
					CartVO cvo = new CartVO();
					cvo.setOqty(rs.getInt(7));
					
					ovo.setOdrtotalprice(rs.getInt(8));
					
					ovo.setProd(pvo);
					ovo.setCart(cvo);
					
					odrList.add(ovo);
					
				}// end of while--------------------------------------
				

			}finally {
				close();
			}
			
			return odrList;
		}

		// 주문내역 총액합계 및 포인트 합계 알아오기
/*		@Override
		public Map<String, String> selectOrderPricePoint(String odrcode) throws SQLException {
			Map<String, String> resultMap = new HashMap<>();
		
			try {
				 conn = ds.getConnection();
				 
				 String sql = " select odrtotalprice, odrtotalpoint " +
		                     " from tbl_order "+
		                     " where odrcode= ?  ";
				  
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1, odrcode);
				 
				 rs = pstmt.executeQuery();
				 
				 rs.next();
				 
				 resultMap.put("odrtotalprice", rs.getString(1));
				 resultMap.put("odrtotalpoint", rs.getString(2));
				 
				 int DELIVERYPRICE = 0;
				 
				 if(Integer.parseInt(rs.getString(1)) < 50000 ) {
					DELIVERYPRICE = 5000;
				 }
				 
				 resultMap.put("DELIVERYPRICE", String.valueOf(DELIVERYPRICE));
				 
			} finally {
				close();
			}
			
			return resultMap;
		}
*/
		// 주문 내역 업데이트 (주문자관련정보)



		@Override
		public int orderDelte(String odrcode) throws SQLException {
			int n = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " delete from tbl_order "
						+ " where odrcode = ? ";
				sql = " delete from tbl_orderdetail "
						+ " where fk_odrcode = ? ";
				sql = " delete from tbl_ordermeminfo "
						+ " where fk_odrcode = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, odrcode);
				
				n = pstmt.executeUpdate();
				
			}finally{
				close();
			}
			
			return n;
		}


		@Override
		public int buyContentinsert(OrderVO ordmember, String odrcode, String userid) throws SQLException {
			
			int result = 0;
			
			try {
				
				conn = ds.getConnection();
				
				String sql =" insert into tbl_ordermeminfo (fk_userid, fk_odrcode, name, email, mobile, postcode, address, detailaddress, extraaddress, msg1, msg2 ) "
						+ " values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, odrcode);
				pstmt.setString(3, ordmember.getName());
				pstmt.setString(4,ordmember.getEmail());   // 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다.   
				pstmt.setString(5, ordmember.getMobile());
				pstmt.setString(6, ordmember.getPostcode());
				pstmt.setString(7, ordmember.getAddress());
				pstmt.setString(8, ordmember.getDetailaddress());
				pstmt.setString(9, ordmember.getExtraaddress());
				pstmt.setString(10, ordmember.getMsg1());
				pstmt.setString(11, ordmember.getMsg2());
				
				result = pstmt.executeUpdate();
				
			}finally {
				close();
			}
			
			return result;
		}

		
		

	
}
