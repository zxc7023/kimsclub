package com.kimsclub.groupware.vo;

public class MessageVO {

	private int message_no;
	private int message_sender_no;
	private String message_sender_name;
	private int message_receiver_no;
	private String message_receiver_name;
	private String message_contents;
	private String message_date;
	private String message_read_state;
	private String message_sender_del;
	private String message_receiver_del;
	private String message_keep;
	
	public int getMessage_no() {
		return message_no;
	}
	public void setMessage_no(int message_no) {
		this.message_no = message_no;
	}
	public int getMessage_sender_no() {
		return message_sender_no;
	}
	public void setMessage_sender_no(int message_sender_no) {
		this.message_sender_no = message_sender_no;
	}
	public String getMessage_sender_name() {
		return message_sender_name;
	}
	public void setMessage_sender_name(String message_sender_name) {
		this.message_sender_name = message_sender_name;
	}
	public int getMessage_receiver_no() {
		return message_receiver_no;
	}
	public void setMessage_receiver_no(int message_receiver_no) {
		this.message_receiver_no = message_receiver_no;
	}
	public String getMessage_receiver_name() {
		return message_receiver_name;
	}
	public void setMessage_receiver_name(String message_receiver_name) {
		this.message_receiver_name = message_receiver_name;
	}
	public String getMessage_contents() {
		return message_contents;
	}
	public void setMessage_contents(String message_contents) {
		this.message_contents = message_contents;
	}
	public String getMessage_date() {
		return message_date;
	}
	public void setMessage_date(String message_date) {
		this.message_date = message_date;
	}
	public String getMessage_read_state() {
		return message_read_state;
	}
	public void setMessage_read_state(String message_read_state) {
		this.message_read_state = message_read_state;
	}
	public String getMessage_sender_del() {
		return message_sender_del;
	}
	public void setMessage_sender_del(String message_sender_del) {
		this.message_sender_del = message_sender_del;
	}
	public String getMessage_receiver_del() {
		return message_receiver_del;
	}
	public void setMessage_receiver_del(String message_receiver_del) {
		this.message_receiver_del = message_receiver_del;
	}
	public String getMessage_keep() {
		return message_keep;
	}
	public void setMessage_keep(String message_keep) {
		this.message_keep = message_keep;
	}
	@Override
	public String toString() {
		return "MessageVO [message_no=" + message_no + ", message_sender_no=" + message_sender_no
				+ ", message_sender_name=" + message_sender_name + ", message_receiver_no=" + message_receiver_no
				+ ", message_receiver_name=" + message_receiver_name + ", message_contents=" + message_contents
				+ ", message_date=" + message_date + ", message_read_state=" + message_read_state
				+ ", message_sender_del=" + message_sender_del + ", message_receiver_del=" + message_receiver_del
				+ ", message_keep=" + message_keep + "]";
	}
	
}
