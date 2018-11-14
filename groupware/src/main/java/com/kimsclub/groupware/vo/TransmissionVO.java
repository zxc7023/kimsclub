package com.kimsclub.groupware.vo;

import java.util.Date;

public class TransmissionVO {
	private int transmission_no;
	private EmployeeVO sender_emp;
	private EmployeeVO receiver_emp;
	private DocumentVO document;
	private Date transmission_sender_date;
	private Date transmission_receiver_date;	
	private int transmission_state;
	
	
	public TransmissionVO() {
		super();
	}
	public int getTransmission_no() {
		return transmission_no;
	}
	public void setTransmission_no(int transmission_no) {
		this.transmission_no = transmission_no;
	}
	
	public EmployeeVO getSender_emp() {
		return sender_emp;
	}
	public void setSender_emp(EmployeeVO sender_emp) {
		this.sender_emp = sender_emp;
	}
	public EmployeeVO getReceiver_emp() {
		return receiver_emp;
	}
	public void setReceiver_emp(EmployeeVO receiver_emp) {
		this.receiver_emp = receiver_emp;
	}
	public DocumentVO getDocument() {
		return document;
	}
	public void setDocument(DocumentVO document) {
		this.document = document;
	}
	public Date getTransmission_sender_date() {
		return transmission_sender_date;
	}
	public void setTransmission_sender_date(Date transmission_sender_date) {
		this.transmission_sender_date = transmission_sender_date;
	}
	public Date getTransmission_receiver_date() {
		return transmission_receiver_date;
	}
	public void setTransmission_receiver_date(Date transmission_receiver_date) {
		this.transmission_receiver_date = transmission_receiver_date;
	}
	public int getTransmission_state() {
		return transmission_state;
	}
	public void setTransmission_state(int transmission_state) {
		this.transmission_state = transmission_state;
	}
	@Override
	public String toString() {
		return "TransmissionVO [transmission_no=" + transmission_no + ", sender_emp=" + sender_emp + ", receiver_emp=" + receiver_emp + ", document=" + document + ", transmission_sender_date=" + transmission_sender_date + ", transmission_receiver_date=" + transmission_receiver_date + ", transmission_state=" + transmission_state + "]";
	}
	
	
	
}
