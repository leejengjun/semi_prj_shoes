package starting_page.model;

import java.sql.SQLException;
import java.util.*;

public interface InterProductDAO {

	// 시작(메인)페이지에 보여주는 상품이미지 파일명으로 모두 조회(select)하는 메소드
	// DTO(Data Transfer Object) == VO(Value Obect)
	List<ImageVO> imageSelectAll() throws SQLException;

	// 시작(메인)페이지에 보여줄 상품 이미지 4개를 파일명으로 모두 조회하는 메소드
	List<ImageVO> imageShow() throws SQLException;
	
}
