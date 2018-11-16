package com.kimsclub.groupware.vo;

import java.util.Date;

public class WorkRecodeVO {
	int employee_no;
	Date occurence_date;
	String work_type;

	public WorkRecodeVO() {
	}

	public WorkRecodeVO(int employee_no, Date occurence_date, String work_type) {
		super();
		this.employee_no = employee_no;
		this.occurence_date = occurence_date;
		this.work_type = work_type;
	}

	public int getEmployee_no() {
		return employee_no;
	}

	public void setEmployee_no(int employee_no) {
		this.employee_no = employee_no;
	}

	public Date getOccurence_date() {
		return occurence_date;
	}

	public void setOccurence_date(Date occurence_date) {
		this.occurence_date = occurence_date;
	}

	public String getWork_type() {
		return work_type;
	}

	public void setWork_type(String work_type) {
		this.work_type = work_type;
	}

	@Override
	public String toString() {
		return "WorkRecode [employee_no=" + employee_no + ", occurence_date=" + occurence_date + ", work_type=" + work_type + "]";
	}
	
	
}
