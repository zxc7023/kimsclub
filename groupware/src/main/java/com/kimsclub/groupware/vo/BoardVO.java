package com.kimsclub.groupware.vo;

public class BoardVO {

	int board_no;
	String board_writer;
	String board_title;
	String board_contents;
	String board_date;
	int board_viewcount;
	String board_type;
	
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
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
	
	@Override
	public String toString() {
		return "BoardVO [board_no=" + board_no + ", board_writer=" + board_writer + ", board_title=" + board_title
				+ ", board_contents=" + board_contents + ", date=" + board_date + ", viewcount=" + board_viewcount + "]";
	}
	
	
}
