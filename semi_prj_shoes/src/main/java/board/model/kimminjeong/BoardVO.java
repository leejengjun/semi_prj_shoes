package board.model.kimminjeong;

public class BoardVO {
	private int qna_num; 			// 글번호
	private String qna_writer; 		// 작성자 
	private String qna_subject; 	// 글제목
	private String qna_content; 	// 글내용
	private String qna_file; 		// 첨부파일 이름
	private int qna_re_ref; 		// 글 그룹번호
	private int qna_re_lev; 		// 답변글 깊이
	private int qna_re_seq; 		// 답변글 순서
	private String qna_regDate; 	// 글 작성일
	private int qna_viewCnt; 	// 글 조회수
	
	public BoardVO() {
		
	}
	
	
	public BoardVO(int qna_num, String qna_writer, String qna_subject, String qna_content, String qna_file,
			int qna_re_ref, int qna_re_lev, int qna_re_seq, String qna_regDate, int qna_viewCnt) {
		super();
		this.qna_num = qna_num;
		this.qna_writer = qna_writer;
		this.qna_subject = qna_subject;
		this.qna_content = qna_content;
		this.qna_file = qna_file;
		this.qna_re_ref = qna_re_ref;
		this.qna_re_lev = qna_re_lev;
		this.qna_re_seq = qna_re_seq;
		this.qna_regDate = qna_regDate;
		this.qna_viewCnt = qna_viewCnt;
	}



	public int getQna_num() {
		return qna_num;
	}

	public void setQna_num(int qna_num) {
		this.qna_num = qna_num;
	}

	public String getQna_writer() {
		return qna_writer;
	}

	public void setQna_writer(String qna_writer) {
		this.qna_writer = qna_writer;
	}

	public String getQna_subject() {
		return qna_subject;
	}

	public void setQna_subject(String qna_subject) {
		this.qna_subject = qna_subject;
	}

	public String getQna_content() {
		return qna_content;
	}

	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}

	public String getQna_file() {
		return qna_file;
	}

	public void setQna_file(String qna_file) {
		this.qna_file = qna_file;
	}

	public int getQna_re_ref() {
		return qna_re_ref;
	}

	public void setQna_re_ref(int qna_re_ref) {
		this.qna_re_ref = qna_re_ref;
	}

	public int getQna_re_lev() {
		return qna_re_lev;
	}

	public void setQna_re_lev(int qna_re_lev) {
		this.qna_re_lev = qna_re_lev;
	}

	public int getQna_re_seq() {
		return qna_re_seq;
	}

	public void setQna_re_seq(int qna_re_seq) {
		this.qna_re_seq = qna_re_seq;
	}

	public String getQna_regDate() {
		return qna_regDate;
	}

	public void setQna_regDate(String qna_regDate) {
		this.qna_regDate = qna_regDate;
	}

	public int getQna_viewCnt() {
		return qna_viewCnt;
	}

	public void setQna_viewCnt(int qna_viewCnt) {
		this.qna_viewCnt = qna_viewCnt;
	}
	
}
