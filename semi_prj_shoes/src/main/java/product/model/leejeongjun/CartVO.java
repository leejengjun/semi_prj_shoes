package product.model.leejeongjun;

public class CartVO {
	private int cartno;
	private String fk_userid;
	private int fk_pnum;
	private String fk_ccode;
	private int fk_psize;
	private int oqty;
	private String registerday;
	
	private int price;
	private String pimage1;
	private String pname;
	
	
	public CartVO() {
		
	}

	
	public CartVO(String color, String size) {
		this.fk_ccode = color;
		this.fk_psize = Integer.parseInt(size);
		
	}
	
	
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getCartno() {
		return cartno;
	}
	public String getFk_ccode() {
		return fk_ccode;
	}
	public void setFk_ccode(String fk_ccode) {
		this.fk_ccode = fk_ccode;
	}
	public int getFk_psize() {
		return fk_psize;
	}
	public void setFk_psize(int fk_psize) {
		this.fk_psize = fk_psize;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getPimage1() {
		return pimage1;
	}
	public void setPimage1(String pimage1) {
		this.pimage1 = pimage1;
	}
	public void setCartno(int cartno) {
		this.cartno = cartno;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public int getFk_pnum() {
		return fk_pnum;
	}
	public void setFk_pnum(int fk_pnum) {
		this.fk_pnum = fk_pnum;
	}
	public int getOqty() {
		return oqty;
	}
	public void setOqty(int oqty) {
		this.oqty = oqty;
	}
	public String getRegisterday() {
		return registerday;
	}
	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}
}
