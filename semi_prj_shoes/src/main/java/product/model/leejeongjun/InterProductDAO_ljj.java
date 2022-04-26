package product.model.leejeongjun;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import member.model.wonhyejin.MemberVO;

public interface InterProductDAO_ljj {

	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체상품에 대한 총페이지 알아오기
	int getTotalPage(Map<String, String> paraMap) throws SQLException;

	// 페이징 처리가 되어진 모든 상품 또는 검색한 상품 목록 보여주기
	List<ProductVO> selectPagingProduct(Map<String, String> paraMap) throws SQLException;

	// tbl_category 테이블에서 카테고리 대분류 번호(cnum), 카테고리코드(code), 카테고리명(cname)을 조회해오기 
	List<HashMap<String, String>> getCategoryList() throws SQLException;

	// spec 목록을 보여주고자 한다.
	List<SpecVO> selectSpecList() throws SQLException;

	// 제품번호 채번 해오기
	int getPnumOfProduct() throws SQLException;

	// tbl_product 테이블에 제품정보 insert
	int productInsert(ProductVO pvo) throws SQLException;

	// tbl_product_imagefile 테이블에 insert
	int product_addimagefile_Insert(Map<String, String> paraMap) throws SQLException;

	// 제품번호를 가지고서 해당 제품의 정보를 조회해오기
	ProductVO selectOneProductByPnum(String pnum) throws SQLException;

	// 제품번호를 가지고서 해당 제품의 추가된 이미지 정보를 조회해오기
	List<String> getImagesByPnum(String pnum) throws SQLException;

	// 제품번호를 가지고 해당 제품을 삭제하기
	int deleteProduct(String pnum) throws SQLException;

	// 장바구니에 제품 담기
	int addCart(Map<String, String> paraMap) throws SQLException;

	// *** 주문내역에 대한 페이징 처리를 위해 주문 갯수를 알아오기 위한 것으로
	//     관리자가 아닌 일반사용자로 로그인 했을 경우에는 자신이 주문한 갯수만 알아오고,
	//     관리자로 로그인을 했을 경우에는 모든 사용자들이 주문한 갯수를 알아온다.
	int getTotalCountOrder(String userid) throws SQLException;

	// *** 관리자가 아닌 일반사용자로 로그인 했을 경우에는 자신이 주문한 내역만 페이징 처리하여 조회를 해오고,
    //     관리자로 로그인을 했을 경우에는 모든 사용자들의 주문내역을 페이징 처리하여 조회해온다.
	List<Map<String, String>> getOrderList(String userid, int currentShowPageNo, int sizePerPage) throws SQLException;

	// Ajax 를 이용한 제품후기를 작성하기전 해당 제품을 사용자가 실제 구매했는지 여부를 알아오는 것임. 구매했다라면 true, 구매하지 않았다면 false 를 리턴함.
	boolean isOrder(Map<String, String> paraMap) throws SQLException;

	// 특정 회원이 특정 제품에 대해 좋아요에 투표하기(insert) 
	int likeAdd(Map<String, String> paraMap) throws SQLException;

	// 특정 회원이 특정 제품에 대해 싫어요에 투표하기(insert) 
	int dislikeAdd(Map<String, String> paraMap) throws SQLException;

	// 특정 제품에 대한 좋아요,싫어요의 투표결과(select)
	Map<String, Integer> getLikeDislikeCnt(String pnum) throws SQLException;

	// Ajax 를 이용한 특정 제품의 상품후기를 입력(insert)하기 
	int addComment(PurchaseReviewsVO reviewsvo) throws SQLException;
	
	// Ajax 를 이용한 특정 제품의 상품후기를 조회(select)하기
	List<PurchaseReviewsVO> commentList(String fk_pnum) throws SQLException;

	// Ajax 를 이용한 특정 제품의 상품후기를 삭제(delete)하기
	int reviewDel(String review_seq) throws SQLException;

	// Ajax 를 이용한 특정 제품의 상품후기를 수정(update)하기
	int reviewUpdate(Map<String, String> paraMap) throws SQLException;

	// 영수증전표(odrcode) 소유주에 대한 사용자 정보를 조회해오는 것.
	MemberVO odrcodeOwnerMemberInfo(String odrcode) throws SQLException;

	// tbl_orderdetail 테이블의 deliverstatus(배송상태) 컬럼의 값을 2(배송시작)로 변경하기
	int updateDeliverStart(String odrcodePnum) throws SQLException;

	// tbl_orderdetail 테이블의 deliverstatus(배송상태) 컬럼의 값을 3(배송완료)로 변경하기
	int updateDeliverEnd(String odrcodePnum) throws SQLException;

	


}
