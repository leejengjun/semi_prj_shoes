package product.model.kimjieun;

public class OrderVO {

	private String odrcode;			// 주문코드
	private String fk_userid;		// 회원아이디
	private int odrtotalprice;	// 추문총액
	private String odrtotalpoint;	// 주문총포인트
	private String odrdate;			// 주문일자
	

	private String address;			// 배송지주소
	private String postcode;		// 배송지우편번호
	private String detailaddress;	// 배송지상세주소
	private String extraaddress;	// 참고항목
	
	private String name;
	private String email;          	   // 이메일 (AES-256 암호화/복호화 대상)
	private String mobile;         	   // 연락처 (AES-256 암호화/복호화 대상) 
	
	private String msg1;
	private String msg2;
	
	private ProductVO prod;  //  제품정보객체 (오라클로 말하면 부모테이블)
	
	private CartVO cart;
	
	public OrderVO(){}
	
	public OrderVO(String userid, String name, String email, String mobile, String postcode, String address,
			String detailaddress, String extraaddress, String msg1, String msg2) {
		this.fk_userid = userid;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.postcode = postcode;
		this.address = address;
		this.detailaddress = detailaddress;
		this.extraaddress = extraaddress;
		this.msg1 = msg1;
		this.msg2 = msg2;
	}

	public CartVO getCart() {
		return cart;
	}

	public void setCart(CartVO cart) {
		this.cart = cart;
	}

	public ProductVO getProd() {
		return prod;
	}

	public void setProd(ProductVO prod) {
		this.prod = prod;
	}

	public String getOdrcode() {
		return odrcode;
	}
	
	public void setOdrcode(String odrcode) {
		this.odrcode = odrcode;
	}
	
	public String getFk_userid() {
		return fk_userid;
	}
	
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	
	public int getOdrtotalprice() {
		return odrtotalprice;
	}
	
	public void setOdrtotalprice(int odrtotalprice) {
		this.odrtotalprice = odrtotalprice;
	}
	
	public String getOdrtotalpoint() {
		return odrtotalpoint;
	}
	
	public void setOdrtotalpoint(String odrtotalpoint) {
		this.odrtotalpoint = odrtotalpoint;
	}
	
	public String getOdrdate() {
		return odrdate;
	}
	
	public void setOdrdate(String odrdate) {
		this.odrdate = odrdate;
	}
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getPostcode() {
		return postcode;
	}
	
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	
	public String getDetailaddress() {
		return detailaddress;
	}
	
	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}
	
	public String getExtraaddress() {
		return extraaddress;
	}
	
	public void setExtraaddress(String extraaddress) {
		this.extraaddress = extraaddress;
	}

	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getMsg1() {
		return msg1;
	}

	public void setMsg1(String msg1) {
		this.msg1 = msg1;
	}

	public String getMsg2() {
		return msg2;
	}

	public void setMsg2(String msg2) {
		this.msg2 = msg2;
	}
	
}
