package com.human.app;

public class UpdateRec {
	private int bbs_id;
	private String title;
	private String content;
	private String writer;
	private String passcode;
	
	public UpdateRec() {}

	public UpdateRec(int bbs_id, String title, String content, String writer, String passcode) {
		this.bbs_id = bbs_id;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.passcode = passcode;
	}

	public int getBbs_id() {
		return bbs_id;
	}

	public void setBbs_id(int bbs_id) {
		this.bbs_id = bbs_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getPasscode() {
		return passcode;
	}

	public void setPasscode(String passcode) {
		this.passcode = passcode;
	}
	
}
