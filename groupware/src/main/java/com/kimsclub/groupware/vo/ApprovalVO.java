package com.kimsclub.groupware.vo;

import java.util.Date;

public class ApprovalVO {
	private int approval_no;
	private DocumentVO document;
	private EmployeeVO employee;
	private Date approval_date;
	private int approval_state;
	private int approval_next_no;
	
	public ApprovalVO() {
	}
	public int getApproval_no() {
		return approval_no;
	}
	public void setApproval_no(int approval_no) {
		this.approval_no = approval_no;
	}
	public DocumentVO getDocument() {
		return document;
	}
	public void setDocument(DocumentVO document) {
		this.document = document;
	}
	
	public Date getApproval_date() {
		return approval_date;
	}
	public void setApproval_date(Date approval_date) {
		this.approval_date = approval_date;
	}
	public int getApproval_state() {
		return approval_state;
	}
	public void setApproval_state(int approval_state) {
		this.approval_state = approval_state;
	}
	public int getApproval_next_no() {
		return approval_next_no;
	}
	public ApprovalVO(int approval_no, EmployeeVO employee,int approval_next_no) {
		super();
		this.approval_no = approval_no;
		this.employee = employee;
		this.approval_next_no = approval_next_no;
	}
	public ApprovalVO(int approval_no,int approval_next_no) {
		super();
		this.approval_no = approval_no;
		this.approval_next_no = approval_next_no;
	}
	public void setApproval_next_no(int approval_next_no) {
		this.approval_next_no = approval_next_no;
	}
	public EmployeeVO getEmployee() {
		return employee;
	}
	public void setEmployee(EmployeeVO employee) {
		this.employee = employee;
	}
	@Override
	public String toString() {
		return "ApprovalVO [approval_no=" + approval_no + ", document=" + document + ", employee=" + employee + ", approval_date=" + approval_date + ", approval_state=" + approval_state + ", approval_next_no=" + approval_next_no + "]";
	}
	
	
}
