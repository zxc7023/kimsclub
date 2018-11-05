package com.kimsclub.groupware.vo;

import java.util.Date;

public class ApprovalVO {
	private int approval_no;
	private DocumentVO document;
	private int approval_approver_no;
	private Date approval_date;
	private String approval_state;
	private int approval_next_no;
	
	public ApprovalVO() {
		super();
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
	public int getApproval_approver_no() {
		return approval_approver_no;
	}
	public void setApproval_approver_no(int approval_approver_no) {
		this.approval_approver_no = approval_approver_no;
	}
	public Date getApproval_date() {
		return approval_date;
	}
	public void setApproval_date(Date approval_date) {
		this.approval_date = approval_date;
	}
	public String getApproval_state() {
		return approval_state;
	}
	public void setApproval_state(String approval_state) {
		this.approval_state = approval_state;
	}
	public int getApproval_next_no() {
		return approval_next_no;
	}
	public ApprovalVO(int approval_no, int approval_approver_no,int approval_next_no) {
		super();
		this.approval_no = approval_no;
		this.approval_approver_no = approval_approver_no;
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
	
}
