package product.model.kimjieun;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InterProductDAO_kje {

	// DTO(Data Transfer Object) == VO(Value Obect)
	

	// 카테고리 
	List<HashMap<String, String>> getCategoryList() throws SQLException;
	List<ProductVO> cateProductSelect(String cnum) throws SQLException;
	
	
	// === 전체 상품 목록 === // 
	// 모든제품 조회
	List<ProductVO> allProductSelect(Map<String, String> paraMap, Map<String, String> cateMap, String check) throws SQLException;
	// Ajax(JSON)를 사용하여 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라서 (start ~ end) 조회해오기 //
	List<ProductVO> selectBySpecName(Map<String,String> paraMap) throws SQLException;
    // Ajax(JSON)를 사용하여 상품목록을 "더보기" 방식으로 페이징처리 해주기 위해  스펙별로 제품의 전체개수 알아오기 //
	int totalPspecCount(String string) throws SQLException;


	// === 장바구니 === //
	// 장바구니 제품 조회
	List<CartVO> selectProductCart(String userid) throws SQLException;
	// 장바구니 테이블에서 특정제품을 주문량 변경하기
	int updateCart(Map<String, String> paraMap) throws SQLException;
	// 로그인한 사용자의 장바구니에 담긴 주문총액합계 및 총포인트 합계 알아오기
	Map<String, String> selectCartSumPricePoint(String userid) throws SQLException;
	// 장바구니에 담긴 물건 갯수알아오기 select
	int getCartCount(String userid) throws SQLException;
	// 장바구니 제품 delete
	int delCart(String cartno) throws SQLException;
	
	// 주문번호(시퀀스 seq_tbl_order 값)을 채번해오는 것.
	int getSeq_tbl_order() throws SQLException;
	
	// ===== Transaction 처리하기 ===== // 
    // 1. 주문 테이블에 입력되어야할 주문전표를 채번(select)하기 
    // 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
    // 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
    // 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리) 
    
    // 5. 장바구니 테이블에서 cartnojoin 값에 해당하는 행들을 삭제(delete OR update)하기(수동커밋처리) 
    // >> 장바구니에서 주문을 한 것이 아니라 특정제품을 바로주문하기를 한 경우에는 장바구니 테이블에서 행들을 삭제할 작업은 없다. << 

    // 6. 회원 테이블에서 로그인한 사용자의 coin 액을 sumtotalPrice 만큼 감하고, point 를 sumtotalPoint 만큼 더하기(update)(수동커밋처리) 
    // 7. **** 모든처리가 성공되었을시 commit 하기(commit) **** 
    // 8. **** SQL 장애 발생시 rollback 하기(rollback) **** 
	int orderAdd(Map<String, Object> paraMap) throws SQLException;
	
	
	// 주문제품 보여주기
	List<OrderVO> selectOrderProduct(String odrcode) throws SQLException;
	// 주문내역 총액합계 및 포인트 합계 알아오기
	//Map<String, String> selectOrderPricePoint(String userid) throws SQLException;
	// 주문 내역 업데이트 (주문자관련정보)
	int buyContentinsert(OrderVO ordmember, String odrcode, String userid) throws SQLException;
	int orderDelte(String odrcode) throws SQLException;
	
	
	





	

	

	
	

	
}
