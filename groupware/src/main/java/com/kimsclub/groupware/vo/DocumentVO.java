package com.kimsclub.groupware.vo;

import java.util.Date;

public class DocumentVO {
	private int document_no;
	private String document_title;
	private String document_contents;
	private EmployeeVO employee;
	private Date document_date;
	private String document_state;
	public int getDocument_no() {
		return document_no;
	}
	public void setDocument_no(int document_no) {
		this.document_no = document_no;
	}
	public String getDocument_title() {
		return document_title;
	}
	public void setDocument_title(String document_title) {
		this.document_title = document_title;
	}
	public String getDocument_contents() {
		return document_contents;
	}
	public void setDocument_contents(String document_contents) {
		this.document_contents = document_contents;
	}
	public EmployeeVO getEmployee() {
		return employee;
	}
	public void setDocument_writer_no(EmployeeVO employee) {
		this.employee = employee;
	}
	public Date getDocument_date() {
		return document_date;
	}
	public void setDocument_date(Date document_date) {
		this.document_date = document_date;
	}
	public String getDocument_state() {
		return document_state;
	}
	public void setDocument_state(String document_state) {
		this.document_state = document_state;
	}
	public DocumentVO(String document_title, String document_contents, EmployeeVO employee, String document_state) {
		super();
		this.document_title = document_title;
		this.document_contents = document_contents;
		this.employee = employee;
		this.document_state = document_state;
	}
	public DocumentVO() {
		super();
	}
	
}
