package board.model.kimminjeong;

import member.model.wonhyejin.MemberVO;

public class CommentVO {

	private int qna_commentno;
	private String fk_qna_num;    // tbl_qna_board 테이블과 데이터타입이 같다.
	private String fk_qna_cmtWriter;
	private String qna_cmtContent;
	private String qna_cmtRegDate;
	
	private MemberVO member;

	public int getQna_commentno() {
		return qna_commentno;
	}

	public void setQna_commentno(int qna_commentno) {
		this.qna_commentno = qna_commentno;
	}

	public String getFk_qna_num() {
		return fk_qna_num;
	}

	public void setFk_qna_num(String fk_qna_num) {
		this.fk_qna_num = fk_qna_num;
	}

	public String getFk_qna_cmtWriter() {
		return fk_qna_cmtWriter;
	}

	public void setFk_qna_cmtWriter(String fk_qna_cmtWriter) {
		this.fk_qna_cmtWriter = fk_qna_cmtWriter;
	}

	public String getQna_cmtContent() {
		return qna_cmtContent;
	}

	public void setQna_cmtContent(String qna_cmtContent) {
		this.qna_cmtContent = qna_cmtContent;
	}

	public String getQna_cmtRegDate() {
		return qna_cmtRegDate;
	}

	public void setQna_cmtRegDate(String qna_cmtRegDate) {
		this.qna_cmtRegDate = qna_cmtRegDate;
	}

	public MemberVO getMember() {
		return member;
	}

	public void setMember(MemberVO member) {
		this.member = member;
	}
	
}
