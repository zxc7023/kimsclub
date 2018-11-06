package com.kimsclub.groupware.vo;

public class BoardVO {

	private int board_no; //게시글 번호
	private int board_writer_no; //게시글 작성자 사원번호
	private String board_writer; //게시글 작성자 이름
	private String board_title; //게시글 제목
	private String board_contents; //게시글 내용
	private String board_date; //게시글 작성 일자
	private int board_viewcount; //게시글 조회수
	private String board_type; //게시글 타입(커뮤니티:c, 공지사항:n)
	private int reply_count; //게시글 댓글 조회수
	
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public int getBoard_writer_no() {
		return board_writer_no;
	}
	public void setBoard_writer_no(int board_writer_no) {
		this.board_writer_no = board_writer_no;
	}
	public String getBoard_writer() {
		return board_writer;
	}
	public void setBoard_writer(String board_writer) {
		this.board_writer = board_writer;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_contents() {
		return board_contents;
	}
	public void setBoard_contents(String board_contents) {
		this.board_contents = board_contents;
	}
	public String getBoard_date() {
		return board_date;
	}
	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}
	public int getBoard_viewcount() {
		return board_viewcount;
	}
	public void setBoard_viewcount(int board_viewcount) {
		this.board_viewcount = board_viewcount;
	}
	public String getBoard_type() {
		return board_type;
	}
	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}
	public int getReply_count() {
		return reply_count;
	}
	public void setReply_count(int reply_count) {
		this.reply_count = reply_count;
	}

	@Override
	public String toString() {
		return "BoardVO [board_no=" + board_no + ", board_writer=" + board_writer + ", board_title=" + board_title
				+ ", board_contents=" + board_contents + ", board_date=" + board_date + ", board_viewcount="
				+ board_viewcount + ", board_type=" + board_type + "]";
	}
	
	
	
	
}
