package product.model.leejeongjun;

import member.model.wonhyejin.MemberVO;

public class PurchaseReviewsVO {

	private int review_seq; 
    private String fk_userid;
    private int fk_pnum; 
    private String contents; 
    private String writeDate;
   
    private MemberVO mvo;
    private ProductVO pvo;
   
    public PurchaseReviewsVO() { }

    public PurchaseReviewsVO(int review_seq, String fk_userid, int fk_pnum, String contents, String writeDate,
         MemberVO mvo, ProductVO pvo) {
       this.review_seq = review_seq;
       this.fk_userid = fk_userid;
       this.fk_pnum = fk_pnum;
       this.contents = contents;
       this.writeDate = writeDate;
       this.mvo = mvo;
       this.pvo = pvo;
    }

    public int getReview_seq() {
       return review_seq;
    }

    public void setReview_seq(int review_seq) {
       this.review_seq = review_seq;
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

    public String getContents() {
       return contents;
    }

    public void setContents(String contents) {
       this.contents = contents;
    }

    public String getWriteDate() {
       return writeDate;
    }

    public void setWriteDate(String writeDate) {
       this.writeDate = writeDate;
    }

    public MemberVO getMvo() {
       return mvo;
    }

    public void setMvo(MemberVO mvo) {
       this.mvo = mvo;
    }

    public ProductVO getPvo() {
       return pvo;
    }

    public void setPvo(ProductVO pvo) {
       this.pvo = pvo;
    }
	
}
