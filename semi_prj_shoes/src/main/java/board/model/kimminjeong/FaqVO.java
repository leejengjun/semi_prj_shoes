package board.model.kimminjeong;

import member.model.wonhyejin.MemberVO;

public class FaqVO {

    private int faq_num;            
    private String faq_userid;    	
    private String faq_question;   
    private String faq_answer;
    
	private MemberVO member;

	public int getFaq_num() {
		return faq_num;
	}
	public void setFaq_num(int faq_num) {
		this.faq_num = faq_num;
	}
	public String getFaq_userid() {
		return faq_userid;
	}
	public void setFaq_userid(String faq_userid) {
		this.faq_userid = faq_userid;
	}
	public String getFaq_question() {
		return faq_question;
	}
	public void setFaq_question(String faq_question) {
		this.faq_question = faq_question;
	}
	public String getFaq_answer() {
		return faq_answer;
	}
	public void setFaq_answer(String faq_answer) {
		this.faq_answer = faq_answer;
	}
    
	public MemberVO getMember() {
		return member;
	}
	public void setMember(MemberVO member) {
		this.member = member;
	}       
	
}
