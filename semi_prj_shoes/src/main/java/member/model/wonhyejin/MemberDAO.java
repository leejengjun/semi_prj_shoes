package member.model.wonhyejin;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.*;
import javax.sql.DataSource;

import util.security.*;


public class MemberDAO implements InterMemberDAO {

	private DataSource ds;   
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
// 기본생성자
	public MemberDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semi_prj_shoes_oracle");
		    
		    aes = new AES256(SecretMyKey.KEY);  
		    //SecretMyKey.KEY 은 우리가 만든 비밀키
		    
		} catch(NamingException e) {
			e.printStackTrace();
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
	
// 반납 메소드
	private void close() {
		
		try {
			if(rs != null)    {rs.close();	  rs = null;}
			if(pstmt != null) {pstmt.close(); pstmt = null;}
			if(conn != null)  {conn.close();  conn = null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
	}// end of private void close()-------------------------------------
	
	
// ID 중복검사 
	@Override
	public boolean idDuplicateCheck(String userid) throws SQLException {
		
		boolean isExist = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select * "
					   + " from tbl_member"
					   + " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			isExist = rs.next();  // 행이 있으면(중복된 userid)     true,
			                      // 행이 없으면(사용가능한 userid)  false
			
		} finally {
			close();
		}
		
		return isExist;
	}


// email 중복검사 
	@Override
	public boolean emailDuplicateCheck(String email) throws SQLException {
	
		boolean isExist = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select * "
					   + " from tbl_member"
					   + " where email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, aes.encrypt(email));
			
			rs = pstmt.executeQuery();
			
			isExist = rs.next();  
			                     
		
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
				e.printStackTrace();
				
		} finally {
			close();
		}
		
		return isExist;
	}


// 회원가입을 해주는 메소드 
		@Override
		public int registerMember(MemberVO member) throws SQLException {
			
			int result = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday) "  
						   + " values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";  
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1,  member.getUserid());
				pstmt.setString(2,  Sha256.encrypt(member.getPwd()));  
				pstmt.setString(3,  member.getName());
				pstmt.setString(4,  aes.encrypt(member.getEmail()));     // 양방향 암호화
				pstmt.setString(5,  aes.encrypt(member.getMobile()));    // 양방향 암호화 
				pstmt.setString(6,  member.getPostcode());
				pstmt.setString(7,  member.getAddress());
				pstmt.setString(8,  member.getDetailaddress());
				pstmt.setString(9,  member.getExtraaddress());
				pstmt.setString(10, member.getGender());
				pstmt.setString(11, member.getBirthday());
				
				result = pstmt.executeUpdate();
				
			} catch(GeneralSecurityException | UnsupportedEncodingException e) {
				e.printStackTrace();
			}finally {
				close();
			}
			
			return result;
		}
		
	
// 입력받은 paraMap 을 가지고 1명의 회원정보를 리턴시켜주는 메소드(로그인 처리)
		@Override
		public MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException {
			
        MemberVO member = null;
			
			try {
				
				conn = ds.getConnection();
				String sql =  "SELECT  userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, "+
						"        birthyyyy, birthmm, birthdd, point, registerday, pwdchangegap, "+
						"        nvl(lastlogingap, trunc(months_between(sysdate, registerday) ) ) AS lastlogingap "+
						"FROM "+
						"( "+
						"select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender "+
						"      , substr(birthday,1,4) AS birthyyyy, substr(birthday,6,2) AS birthmm, substr(birthday,9) AS birthdd "+
						"      , point, to_char(registerday, 'yyyy-mm-dd') AS registerday "+
						"      , trunc( months_between(sysdate, lastpwdchangedate) ) AS pwdchangegap "+
						"from tbl_member "+
						"where status = 1 and userid = ? and pwd = ? "+
						") M "+
						"CROSS JOIN "+
						"( "+
						"select trunc(months_between(sysdate, max(logindate)) ) AS lastlogingap "+
						"from tbl_loginhistory "+
						"where fk_userid = ? "+
						") H";
						
					
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setString(2, Sha256.encrypt(paraMap.get("pwd")) );
				pstmt.setString(3, paraMap.get("userid"));
				
				rs = pstmt.executeQuery();
				if(rs.next()) {
					member = new MemberVO();
					
					member.setUserid(rs.getString(1));
					member.setName(rs.getString(2));
					member.setEmail(aes.decrypt(rs.getString(3)) ); //복호화
					member.setMobile(aes.decrypt(rs.getString(4)) ); //복호화
					member.setPostcode(rs.getString(5));
		            member.setAddress(rs.getString(6));
		            member.setDetailaddress(rs.getString(7));
		            member.setExtraaddress(rs.getString(8));
		            member.setGender(rs.getString(9));
		            member.setBirthday(rs.getString(10) + rs.getString(11) + rs.getString(12));
		            member.setPoint(rs.getInt(13));
		            member.setRegisterday(rs.getString(14));
		            
		            if(rs.getInt(15) >=3) {
		            	 // 마지막으로 비밀번호를 변경한 날짜가 현재시각으로 부터 3개월 이내면 false 경과됬으면 true 
			            	member.setRequirePwdChange(true);             	
			            }
			            if(rs.getInt(16) >= 12) {
			            	// 마지막으로 로그인한 날짜시간이 현재시각으로 부터 1년이 경과되면 휴면으로 처리
			             member.setIdle(1);
			             
			             // == tbl_member 테이블의 idle 컬럼의 값을 1로 변경하기 === //
			             sql = " update tbl_member set idle = 1 "
			            		 + "where userid = ? ";
			             
			             pstmt = conn.prepareStatement(sql);
			             pstmt.setString(1, paraMap.get("userid"));
			             
			             pstmt.executeUpdate();
			             
			            }
			            
			            // === tbl_tbl_loginhistory(로그인기록) 테이블에 insert 하기 == //
			            if(member.getIdle() != 1) {
			            	sql = " insert into tbl_loginhistory(fk_userid) "
			            	    + " values(?) ";
			            	
			            	pstmt = conn.prepareStatement(sql);
			            	pstmt.setString(1, paraMap.get("userid"));
			            
			            	
			            	pstmt.executeUpdate();
			            	
			            }
			          }
					
				} catch(GeneralSecurityException | UnsupportedEncodingException e) {
					e.printStackTrace();
				} finally {
					close();
				}
				return member;
			}

		// 아이디 찾기(성명, 이메일을 입력받아서 해당사용자의 아이디를 알려준다)
		@Override
		public String findUserid(Map<String, String> paraMap) throws SQLException {

			String userid = null;
			
		    try {
		    	conn = ds.getConnection();
		    	
		    	String sql = " select userid "
		    			     + " from tbl_member"
		    			     + " where status = 1 and name = ? and email = ? ";   //1은 탈퇴한 회원
		    	
		    	pstmt = conn.prepareStatement(sql);
		    	pstmt.setString(1, paraMap.get("name") );
		        pstmt.setString(2, aes.encrypt(paraMap.get("email")));
		    	rs = pstmt.executeQuery();
		    
		    	if(rs.next()) {
		    		userid = rs.getString(1);  //select 된 결과물을 userid에 넣어서 리턴
		    	}
		    	
		    } catch(GeneralSecurityException | UnsupportedEncodingException e) {
				e.printStackTrace();	
		    } finally {
		    	close();
		    }
			return userid;
		}


		
		// 비밀번호 찾기(아이디, 이메일을 입력받아서 해당사용자가 존재하는지 유무를 알려준다)
		@Override
		public boolean isUserExist(Map<String, String> paraMap) throws SQLException {

			boolean isUserExist  = false;  
			
			try {
		    	conn = ds.getConnection();
		    	
		    	String sql = " select userid "
	    			       + " from tbl_member"
	    			       + " where status = 1 and userid = ? and email = ? ";   //1은 탈퇴한 회원
		    	
		    	pstmt = conn.prepareStatement(sql);
		    	pstmt.setString(1, paraMap.get("userid") );
		    	pstmt.setString(2, aes.encrypt(paraMap.get("email")));
		    	
		    	rs = pstmt.executeQuery();
		    
		    	isUserExist = rs.next();    
		    	
		    } catch(GeneralSecurityException | UnsupportedEncodingException e) {
				e.printStackTrace();	
		    } finally {
		    	close();
		    }
			
			return isUserExist;
		}

		// 비밀번호 변경하기 
		@Override
		public int pwdUpdate(Map<String, String> paraMap) throws SQLException {

			int result = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " update tbl_member set pwd = ? "
						    + "                      , lastpwdchangedate = sysdate "           
						    + " where userid = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, Sha256.encrypt(paraMap.get("pwd")) ); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다.
				pstmt.setString(2, paraMap.get("userid") );
				
				result = pstmt.executeUpdate();
			} finally {
				close();
			}
			return result;
		}
		
		
		// 회원의 개인 정보 변경하기 
		@Override
		public int updateMember(MemberVO member) throws SQLException {

			int result = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " update tbl_member set name = ? "
						   + "                     , pwd = ? "
						   + "                     , email = ? "
						   + "                     , mobile = ? "
						   + "                     , postcode = ? "
						   + "                     , address = ? "
						   + "                     , detailaddress = ? "
						   + "                     , extraaddress = ? "
						   + "                     , lastpwdchangedate = sysdate "
						   + " where userid = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1,  member.getName());
				pstmt.setString(2,  Sha256.encrypt(member.getPwd()));  // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다.   
				pstmt.setString(3,  aes.encrypt(member.getEmail()));   // 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다. 
				pstmt.setString(4,  aes.encrypt(member.getMobile()));  // 휴대폰번호를 AES256 알고리즘으로 양방향 암호화 시킨다.     
				pstmt.setString(5,  member.getPostcode());  
				pstmt.setString(6,  member.getAddress());
				pstmt.setString(7,  member.getDetailaddress());
				pstmt.setString(8,  member.getExtraaddress());
				pstmt.setString(9,  member.getUserid());
							
				result = pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			
			return result;
		}

		// 모든 회원 또는 검색한 회원 목록 보여주기
		@Override
		public List<MemberVO> selectPagingMember(Map<String, String> paraMap) throws SQLException {
			List<MemberVO> memberList = new ArrayList<>();
			
			try {
				conn = ds.getConnection();
				
				String sql = " select userid, name, email, gender "
						+ " from "
						+ " ( "
						+ "    select rownum AS rno, userid, name, email, gender "
						+ "    from "
						+ "    ( "
						+ "        select userid, name, email, gender "
						+ "        from tbl_member "
						+ "        where userid != 'admin' ";
				
				String colname = paraMap.get("searchType");
				String searchWord = paraMap.get("searchWord");

				
				if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
					sql += " and "+colname+" like '%'|| ? ||'%' ";

				}
				
				sql += "        order by registerday desc "
					+ "    ) V "
					+ " ) T "
					+ " where rno between ? and ? ";
				
				
				pstmt = conn.prepareStatement(sql);
				
				int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			 	int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));

				
			 	if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
			 		
			 		if("email".equals(colname)) {
			 			pstmt.setString(1, aes.encrypt(searchWord));
					}
					else {
						pstmt.setString(1, searchWord);	
					}
			 		
			 		pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
					pstmt.setInt(3, (currentShowPageNo * sizePerPage));	
			 	}
			 	else {
			 		pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
					pstmt.setInt(2, (currentShowPageNo * sizePerPage));	
			 	}
			 	
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					MemberVO mvo = new MemberVO();
					mvo.setUserid(rs.getString(1));
					mvo.setName(rs.getString(2));
					mvo.setEmail(aes.decrypt(rs.getString(3))); // 복호화 
					mvo.setGender(rs.getString(4));
					
					memberList.add(mvo);
				}// end of while--------------------------------
			
			} catch(GeneralSecurityException | UnsupportedEncodingException e) { 
			    e.printStackTrace();	
			} finally {
				close();
			}
			
			return memberList;
		}


		// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체회원에 대한 총페이지 알아오기 
		@Override
		public int getTotalPage(Map<String, String> paraMap) throws SQLException {
			
			int totalPage = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " select ceil( count(*)/? ) "
						   + " from tbl_member"
						   + " where userid != 'admin' ";
				
				String colname = paraMap.get("searchType");
				String searchWord = paraMap.get("searchWord");

				
				if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
					sql += " and "+colname+" like '%'|| ? ||'%' ";

				}
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("sizePerPage"));
				
				if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
					
					if("email".equals(colname)) {
						pstmt.setString(2, aes.encrypt(paraMap.get("searchWord")) );
					}
					else {
						pstmt.setString(2, paraMap.get("searchWord"));	
					}
					
				}
				
				rs = pstmt.executeQuery();
				
				rs.next();
				
				totalPage = rs.getInt(1);
			
			} catch(GeneralSecurityException | UnsupportedEncodingException e) { 
			    e.printStackTrace();	
			} finally {
				close();
			}
			
			return totalPage;
		}


		// userid 값을 입력받아서 회원1명에 대한 상세정보를 알아오기
		@Override
		public MemberVO memberOneDetail(String userid) throws SQLException {
			
			MemberVO mvo = null;
			
			try {
				 conn = ds.getConnection();
				 
				 String sql = " select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender "+
						      "     , substr(birthday,1,4) AS birthyyyy, substr(birthday,6,2) AS birthmm, substr(birthday,9) AS birthdd "+
						      "     , point, to_char(registerday, 'yyyy-mm-dd') AS registerday "+
						      " from tbl_member "+
						      " where userid = ? ";
				 
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1, userid);
				 			 
				 rs = pstmt.executeQuery();
				 
				 if(rs.next()) {
					 mvo = new MemberVO();
					 
					 mvo.setUserid(rs.getString(1));
					 mvo.setName(rs.getString(2));
					 mvo.setEmail( aes.decrypt(rs.getString(3)) );  // 복호화 
					 mvo.setMobile( aes.decrypt(rs.getString(4)) ); // 복호화 
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
		}		
		
}
		
		