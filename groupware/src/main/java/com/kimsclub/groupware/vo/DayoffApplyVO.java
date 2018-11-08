package com.kimsclub.groupware.vo;

import java.util.Date;
import java.util.List;

public class DayoffApplyVO {
	int dayoff_no;
	double total_days;
	Date start_date;
	Date end_date;
	EmployeeVO employee;
	DayoffKindsVO dayoff_kind;
	List<DayoffApplyDetailVO> dayoff_apply_detail;
	DocumentVO document;
	String dayoff_reason;

	public DayoffApplyVO() {
		super();
	}

	public DayoffApplyVO(int dayoff_no, double total_days, Date start_date, Date end_date, EmployeeVO employee, DayoffKindsVO dayoff_kind, List<DayoffApplyDetailVO> dayoff_apply_detail, DocumentVO document, String dayoff_reason) {
		super();
		this.dayoff_no = dayoff_no;
		this.total_days = total_days;
		this.start_date = start_date;
		this.end_date = end_date;
		this.employee = employee;
		this.dayoff_kind = dayoff_kind;
		this.dayoff_apply_detail = dayoff_apply_detail;
		this.document = document;
		this.dayoff_reason = dayoff_reason;
	}

	public int getDayoff_no() {
		return dayoff_no;
	}

	public void setDayoff_no(int dayoff_no) {
		this.dayoff_no = dayoff_no;
	}

	public double getTotal_days() {
		return total_days;
	}

	public void setTotal_days(double total_days) {
		this.total_days = total_days;
	}

	public Date getStart_date() {
		return start_date;
	}

	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}

	public Date getEnd_date() {
		return end_date;
	}

	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}

	public EmployeeVO getEmployee() {
		return employee;
	}

	public void setEmployee(EmployeeVO employee) {
		this.employee = employee;
	}

	public DayoffKindsVO getDayoff_kind() {
		return dayoff_kind;
	}

	public void setDayoff_kind(DayoffKindsVO dayoff_kind) {
		this.dayoff_kind = dayoff_kind;
	}

	public List<DayoffApplyDetailVO> getDayoff_apply_detail() {
		return dayoff_apply_detail;
	}

	public void setDayoff_apply_detail(List<DayoffApplyDetailVO> dayoff_apply_detail) {
		this.dayoff_apply_detail = dayoff_apply_detail;
	}

	public DocumentVO getDocument() {
		return document;
	}

	public void setDocument(DocumentVO document) {
		this.document = document;
	}

	public String getDayoff_reason() {
		return dayoff_reason;
	}

	public void setDayoff_reason(String dayoff_reason) {
		this.dayoff_reason = dayoff_reason;
	}

	@Override
	public String toString() {
		return "DayoffApplyVO [dayoff_no=" + dayoff_no + ", total_days=" + total_days + ", start_date=" + start_date + ", end_date=" + end_date + ", employee=" + employee + ", dayoff_kind=" + dayoff_kind + ", dayoff_apply_detail="
				+ dayoff_apply_detail + ", document=" + document + ", dayoff_reason=" + dayoff_reason + "]";
	}
	
	

	
}
