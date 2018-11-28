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
	private String document_state;
	private int rn;
	private TransmissionVO transmission;
	private int cooperation_no;
	private int cooIndex;
	

	public DocumentVO() {
		super();
	}

	public DocumentVO(int document_no, String document_title, String document_contents, EmployeeVO employee, List<ApprovalVO> approval, Date document_date, String document_state, int rn) {
		super();
		this.document_no = document_no;
		this.document_title = document_title;
		this.document_contents = document_contents;
		this.employee = employee;
		this.approval = approval;
		this.document_date = document_date;
		this.document_state = document_state;
		this.rn = rn;
	}

	
	
	public TransmissionVO getTransmission() {
		return transmission;
	}

	public void setTransmission(TransmissionVO transmission) {
		this.transmission = transmission;
	}

	public DocumentVO(int document_no) {
		super();
		this.document_no = document_no;
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

	public void setEmployee(EmployeeVO employee) {
		this.employee = employee;
	}

	public List<ApprovalVO> getApproval() {
		return approval;
	}

	public void setApproval(List<ApprovalVO> approval) {
		this.approval = approval;
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

	public int getRn() {
		return rn;
	}

	public void setRn(int rn) {
		this.rn = rn;
	}
	
	
	public int getCooperation_no() {
		return cooperation_no;
	}

	public void setCooperation_no(int cooperation_no) {
		this.cooperation_no = cooperation_no;
	}
	
	
	public int getCooIndex() {
		return cooIndex;
	}

	public void setCooIndex(int cooIndex) {
		this.cooIndex = cooIndex;
	}

	@Override
	public String toString() {
		return "DocumentVO [document_no=" + document_no + ", document_title=" + document_title + ", document_contents=" + document_contents + ", employee=" + employee + ", approval=" + approval + ", document_date=" + document_date + ", document_state=" + document_state + ", rn=" + rn + ", transmission=" + transmission + ", cooperation_no=" + cooperation_no + "]";
	}
	
	
	
	

	
	
}
