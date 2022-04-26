package board.model.JeongKyeongEun;

public class BoardVO {
	
	private int notice_no;
	private String n_userid;
	private String n_title;
	private String n_contents;
	private String n_date;
	private String n_file;
	
	public BoardVO() {}  // 기본생성자!!

	public BoardVO(int notice_no, String n_userid, String n_title, String n_contents, String n_date, String n_file) {
		
		this.notice_no = notice_no;
		this.n_userid = n_userid;
		this.n_title = n_title;
		this.n_contents = n_contents;
		this.n_date = n_date;
		this.n_file = n_file;
	}

	
	public int getNotice_no() {
		return notice_no;
	}

	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}

	public String getN_userid() {
		return n_userid;
	}

	public void setN_userid(String n_userid) {
		this.n_userid = n_userid;
	}

	public String getN_title() {
		return n_title;
	}

	public void setN_title(String n_title) {
		this.n_title = n_title;
	}

	public String getN_contents() {
		return n_contents;
	}

	public void setN_contents(String n_contents) {
		this.n_contents = n_contents;
	}

	public String getN_date() {
		return n_date;
	}

	public void setN_date(String n_date) {
		this.n_date = n_date;
	}

	public String getN_file() {
		return n_file;
	}

	public void setN_file(String n_file) {
		this.n_file = n_file;
	}
	

	

}
