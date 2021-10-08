package com.human.app;

public class BBSrec {
	// DB에 등록된 게시글을 ArrayList에 넣어주기 위한 클래스 (5가지만 가져올 예정)
	// 게시글 번호, 제목, 내용, 작성자, 작성일자 변수 선언 해주고
	// 생성자 2개 만들기 - 기본 생성자1개 , 모든 필드를 포함한 생성자 1개
	// private변수를 사용하기 위해 getter/setter 메서드 작성해주기
	private int bbs_id;
	private String writer;
	private String title;
	private String content;
	private String img_loc;
	private String created;
	private String updated;
	
	public BBSrec() {}

	public BBSrec(int bbs_id, String writer, String title, String content, String img_loc, String created,
			String updated) {
		this.bbs_id = bbs_id;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.img_loc = img_loc;
		this.created = created;
		this.updated = updated;
	}

	public int getBbs_id() {
		return bbs_id;
	}

	public void setBbs_id(int bbs_id) {
		this.bbs_id = bbs_id;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
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

	public String getImg_loc() {
		return img_loc;
	}

	public void setImg_loc(String img_loc) {
		this.img_loc = img_loc;
	}

	public String getCreated() {
		return created;
	}

	public void setCreated(String created) {
		this.created = created;
	}

	public String getUpdated() {
		return updated;
	}

	public void setUpdated(String updated) {
		this.updated = updated;
	}

	

}
