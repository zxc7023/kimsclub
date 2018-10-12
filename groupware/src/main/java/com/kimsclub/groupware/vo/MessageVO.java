package com.kimsclub.groupware.vo;

public class MessageVO {

	String message_sender;
	String message_receiver;
	String message_contents;
	String message_date;
	String message_read_state;
	
	public String getMessage_sender() {
		return message_sender;
	}
	public void setMessage_sender(String message_sender) {
		this.message_sender = message_sender;
	}
	public String getMessage_receiver() {
		return message_receiver;
	}
	public void setMessage_receiver(String message_receiver) {
		this.message_receiver = message_receiver;
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
	
}
