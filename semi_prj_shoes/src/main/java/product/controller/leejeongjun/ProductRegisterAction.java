package product.controller.leejeongjun;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.AbstractController;
import member.model.wonhyejin.*;
import product.model.leejeongjun.*;

public class ProductRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		super.goBackURL(request);
		
		// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 해야 한다. == //
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser == null || !"admin".equals(loginuser.getUserid()) ) {	
			// 로그인을 안 한 경우 또는 일반사용자로 로그인 한 경우
			String message = "관리자만 접근이 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		else {
			// 관리자(admin)로 로그인 했을 경우
			
			String method = request.getMethod();
			
			if(!"POST".equalsIgnoreCase(method)) {	// GET 이라면
			
				// 카테고리 목록을 조회해오기
				super.getCategoryList(request);
				
				// spec 목록을 보여주고자 한다.
				InterProductDAO_ljj pdao = new ProductDAO_ljj();
				List<SpecVO> specList = pdao.selectSpecList();
				request.setAttribute("specList", specList);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/n01_leejeongjun/adminPage/admin_productRegister.jsp");
			}
			else {	
				// POST 이라면
				
				/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		           파일을 첨부해서 보내는 폼태그가 enctype="multipart/form-data" 으로 되어었다라면
		           HttpServletRequest request 을 사용해서는 데이터값을 받아올 수 없다.
		           이때는 cos.jar 라이브러리를 다운받아 사용하도록 한 후  
		           아래의 객체를 사용해서 데이터 값 및 첨부되어진 파일까지 받아올 수 있다.
		           !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!    
		       */
				
				MultipartRequest mtrequest = null;
				/*
		             MultipartRequest mtrequest 은 
		             HttpServletRequest request 가 하던일을 그대로 승계받아서 일처리를 해주고 
		             동시에 파일을 받아서 업로드, 다운로드까지 해주는 기능이 있다.      
		        */
				
				// 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다.
				ServletContext svlCtx = session.getServletContext();
				String uploadFileDir = svlCtx.getRealPath("/images/kimjieun/product_img");	// 업로드할 경로.
				
			//	System.out.println("=== 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> " + uploadFileDir);
				// === 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> C:\NCS\workspace(jsp)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\MyMVC\images

			/*
	             MultipartRequest의 객체가 생성됨과 동시에 파일 업로드가 이루어 진다.
	                   
	             MultipartRequest(HttpServletRequest request,
	                               String saveDirectory, -- 파일이 저장될 경로
	                            int maxPostSize,      -- 업로드할 파일 1개의 최대 크기(byte)
	                            String encoding,
	                            FileRenamePolicy policy) -- 중복된 파일명이 올라갈 경우 파일명다음에 자동으로 숫자가 붙어서 올라간다.   
	                  
	             파일을 저장할 디렉토리를 지정할 수 있으며, 업로드제한 용량을 설정할 수 있다.(바이트단위). 
	             이때 업로드 제한 용량을 넘어서 업로드를 시도하면 IOException 발생된다. 
	             또한 국제화 지원을 위한 인코딩 방식을 지정할 수 있으며, 중복 파일 처리 인터페이스를사용할 수 있다.
	                        
	             이때 업로드 파일 크기의 최대크기를 초과하는 경우이라면 
	             IOException 이 발생된다.
	             그러므로 Exception 처리를 해주어야 한다.                
			 */
				
				// ==== 파일을 업로드 해준다. ==== //
				try {
					mtrequest = new MultipartRequest(request, uploadFileDir,10*1024*1024 , "UTF-8", new DefaultFileRenamePolicy() );
				}catch(IOException e) {
					e.printStackTrace();
					
					request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대용량 10MB를 초과했으므로 파일업로드 실패함!!");
		            request.setAttribute("loc", request.getContextPath()+"/admin/productRegister.shoes"); 
		              
		            super.setViewPage("/WEB-INF/msg.jsp");
		            return; // 종료
				}
				// ==== 파일을 업로드 해준다. 끝 ==== //
				
				// === 첨부 이미지 파일을 올렸으니 그 다음으로 제품정보를 (제품명, 정가, 제품수량,...) DB의 tbl_product 테이블에 insert 를 해주어야 한다.  ===
				
				// 새로운 제품 등록시 form 태그에서 입력한 값들을 얻어오기
				String fk_cnum = mtrequest.getParameter("fk_cnum");
				String pname = mtrequest.getParameter("pname");
				String pcompany = mtrequest.getParameter("pcompany");
				
				String pimage = mtrequest.getFilesystemName("pimage");
				
				String prdmanual_systemFileName = mtrequest.getFilesystemName("prdmanualFile");
				String prdmanual_originFileName = mtrequest.getOriginalFileName("prdmanualFile");
				
				String pqty = mtrequest.getParameter("pqty");
				String price = mtrequest.getParameter("price");
				String saleprice = mtrequest.getParameter("saleprice");
				String fk_snum = mtrequest.getParameter("fk_snum");
				
				// !!!! 크로스 사이트 스트립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!!! //
				String pcontent = mtrequest.getParameter("pcontent");
				String summary_pcontent = mtrequest.getParameter("summary_pcontent");
				
				pcontent = pcontent.replaceAll("<", "&lt");
				pcontent = pcontent.replaceAll(">", "&gt");
				pcontent = pcontent.replaceAll("\r\n", "<br>");
				
				summary_pcontent = summary_pcontent.replaceAll("<", "&lt");
				summary_pcontent = summary_pcontent.replaceAll(">", "&gt");
				summary_pcontent = summary_pcontent.replaceAll("\r\n", "<br>");
				
				String psize = mtrequest.getParameter("psize");
				String point = mtrequest.getParameter("point");
				
				InterProductDAO_ljj pdao = new ProductDAO_ljj();
				
				// 제품번호 채번 해오기
				int pnum = pdao.getPnumOfProduct();
				
				ProductVO pvo = new ProductVO();
				pvo.setPnum(pnum);
				pvo.setFk_cnum(Integer.parseInt(fk_cnum));
				pvo.setPname(pname);
	            pvo.setPcompany(pcompany);
	            pvo.setPimage(pimage);
	            pvo.setPrdmanual_systemFileName(prdmanual_systemFileName);
	            pvo.setPrdmanual_orginFileName(prdmanual_originFileName);
	            pvo.setPqty(Integer.parseInt(pqty));
	            pvo.setPrice(Integer.parseInt(price));
	            pvo.setSaleprice(Integer.parseInt(saleprice));
	            pvo.setFk_snum(Integer.parseInt(fk_snum));
	            pvo.setPcontent(pcontent);
	            pvo.setSummary_pcontent(summary_pcontent);
	            pvo.setPsize(psize);
	            pvo.setPoint(Integer.parseInt(point));
				
	            String message = "";
	            String loc = "";
	            
	            try {
	            	// tbl_product 테이블에 제품정보 insert 하기
	            	pdao.productInsert(pvo);
	            	
	            	String str_attachCount = mtrequest.getParameter("attachCount");
	            	
	            	int attachCount = 0;
		            
		            if( !"".equals(str_attachCount) ) {
		            	attachCount = Integer.parseInt(str_attachCount);
		            }
	            	
		            for(int i=0; i<attachCount; i++) {
		            	String attachFileName = mtrequest.getFilesystemName("attach"+i);
		            
		            	// tbl_product_imagefile 테이블에 insert
		            	Map<String,String> paraMap = new HashMap<>();
		            	paraMap.put("pnum", String.valueOf(pnum));
		            	paraMap.put("attachFileName", attachFileName);
		            	
		            	pdao.product_addimagefile_Insert(paraMap);
		            }// end of for------------------------------
				
		            message = "제품등록 성공!!";
		            loc = request.getContextPath()+"/admin/productList.shoes";
		            
	            } catch(SQLException e) {
	            	e.printStackTrace();
	            	
	            	message = "제품등록 실패!!";
	            	loc = request.getContextPath()+"/admin/productRegister.shoes";
	            }
	            
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
	            
	            super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}
				
				
	}

}
