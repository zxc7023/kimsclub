package com.kimsclub.groupware.vo;

public class BoardReplyVO {
	
	private int board_no; //게시글 번호
	private int reply_no; //댓글번호
	private int reply_group; //댓글 그룹
	private int reply_order; //댓글 순서
	private int reply_depth; //댓글 깊이
	private int reply_writer_no; //댓글 작성자 번호
	private String reply_writer; //댓글 작성자 이름
	private String reply_contents; //댓글 내용
	private String reply_date; //댓글 작성일자
	private String reply_board_type; //게시판 댓글 타입(커뮤니티:c,공지사항:n)
	private int reply_count; //댓글 조회수
	
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public int getReply_no() {
		return reply_no;
	}
	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}
	public int getReply_group() {
		return reply_group;
	}
	public void setReply_group(int reply_group) {
		this.reply_group = reply_group;
	}
	public int getReply_order() {
		return reply_order;
	}
	public void setReply_order(int reply_order) {
		this.reply_order = reply_order;
	}
	public int getReply_depth() {
		return reply_depth;
	}
	public void setReply_depth(int reply_depth) {
		this.reply_depth = reply_depth;
	}
	public int getReply_writer_no() {
		return reply_writer_no;
	}
	public void setReply_writer_no(int reply_writer_no) {
		this.reply_writer_no = reply_writer_no;
	}
	public String getReply_writer() {
		return reply_writer;
	}
	public void setReply_writer(String reply_writer) {
		this.reply_writer = reply_writer;
	}
	public String getReply_contents() {
		return reply_contents;
	}
	public void setReply_contents(String reply_contents) {
		this.reply_contents = reply_contents;
	}
	public String getReply_date() {
		return reply_date;
	}
	public void setReply_date(String reply_date) {
		this.reply_date = reply_date;
	}
	public String getReply_board_type() {
		return reply_board_type;
	}
	public void setReply_board_type(String reply_board_type) {
		this.reply_board_type = reply_board_type;
	}
	public int getReply_count() {
		return reply_count;
	}
	public void setReply_count(int reply_count) {
		this.reply_count = reply_count;
	}
	
	
}
