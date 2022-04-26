package board.model.JeongKyeongEun;

public class BoardEventVO {
	
	private int event_no;
	private String e_userid;
	private String e_title;
	private String e_contents;
	private String e_date;
	private String e_file;
	
	public BoardEventVO() {}  // 기본생성자!!

	public BoardEventVO(int event_no, String e_userid, String e_title, String e_contents, String e_date, String e_file) {
		
		this.event_no = event_no;
		this.e_userid = e_userid;
		this.e_title = e_title;
		this.e_contents = e_contents;
		this.e_date = e_date;
		this.e_file = e_file;
	}

	
	public int getEvent_no() {
		return event_no;
	}

	public void setEvent_no(int event_no) {
		this.event_no = event_no;
	}

	public String getE_userid() {
		return e_userid;
	}

	public void setE_userid(String e_userid) {
		this.e_userid = e_userid;
	}

	public String getE_title() {
		return e_title;
	}

	public void setE_title(String e_title) {
		this.e_title = e_title;
	}

	public String getE_contents() {
		return e_contents;
	}

	public void setE_contents(String e_contents) {
		this.e_contents = e_contents;
	}

	public String getE_date() {
		return e_date;
	}

	public void setE_date(String e_date) {
		this.e_date = e_date;
	}

	public String getE_file() {
		return e_file;
	}

	public void setE_file(String e_file) {
		this.e_file = e_file;
	}
	
	
	
	
}