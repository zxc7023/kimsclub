package com.kimsclub.groupware.vo;

import java.util.Date;
import java.util.List;

public class DocumentVO {
	private int document_no;
	private String document_title;
	private String document_contents;
	private EmployeeVO employee;
	private List<ApprovalVO> approval;
	private Date document_date;
	private int document_state;
	
	
	public List<ApprovalVO> getApproval() {
		return approval;
	}
	public void setApproval(List<ApprovalVO> approval) {
		this.approval = approval;
	}
	public void setEmployee(EmployeeVO employee) {
		this.employee = employee;
	}
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
	public int getDocument_state() {
		return document_state;
	}
	public void setDocument_state(int document_state) {
		this.document_state = document_state;
	}
	public DocumentVO() {
		super();
	}
	public DocumentVO(String document_title, String document_contents, EmployeeVO employee, int document_state) {
		super();
		this.document_title = document_title;
		this.document_contents = document_contents;
		this.employee = employee;
		this.document_state = document_state;
	}
	@Override
	public String toString() {
		return "DocumentVO [document_no=" + document_no + ", document_title=" + document_title + ", document_contents=" + document_contents + ", employee=" + employee + ", approval=" + approval + ", document_date=" + document_date
				+ ", document_state=" + document_state + "]";
	}
	
	
	
	
}
