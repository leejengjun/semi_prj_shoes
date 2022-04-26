package product.model.kimjieun;

public class Order_DetailVO {
	
	private String odrseqnum;		// 주문상세일련번호
	private String fk_odrcode;		// 주문코드
	private String oqty;			// 주문량
	private String odprice;			// 주문가격
	private String deliverstatus;	// 배송상태
	private String deliverdate;		// 배송완료일자
	private int fk_pnum;			// 제품번호
	
	public String getOdrseqnum() {
		return odrseqnum;
	}
	
	public void setOdrseqnum(String odrseqnum) {
		this.odrseqnum = odrseqnum;
	}
	
	public String getFk_odrcode() {
		return fk_odrcode;
	}
	
	public void setFk_odrcode(String fk_odrcode) {
		this.fk_odrcode = fk_odrcode;
	}
	
	public String getOqty() {
		return oqty;
	}
	
	public void setOqty(String oqty) {
		this.oqty = oqty;
	}
	
	public String getOdprice() {
		return odprice;
	}
	
	public void setOdprice(String odprice) {
		this.odprice = odprice;
	}
	
	public String getDeliverstatus() {
		return deliverstatus;
	}
	
	public void setDeliverstatus(String deliverstatus) {
		this.deliverstatus = deliverstatus;
	}
	
	public String getDeliverdate() {
		return deliverdate;
	}
	
	public void setDeliverdate(String deliverdate) {
		this.deliverdate = deliverdate;
	}
	
	public int getFk_pnum() {
		return fk_pnum;
	}
	
	public void setFk_pnum(int fk_pnum) {
		this.fk_pnum = fk_pnum;
	}

}
