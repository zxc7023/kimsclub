package com.kimsclub.groupware.vo;

import java.util.Date;

public class WorkRecodeVO {

	String work_date;
	EmployeeVO employee;
	Date attendance_time;
	Date leave_time;
	DayoffApplyVO dayoffApply;

	public WorkRecodeVO() {
	}

	public WorkRecodeVO(String work_date, EmployeeVO employee, Date attendance_time, Date leave_time,
			DayoffApplyVO dayoffApply) {
		super();
		this.work_date = work_date;
		this.employee = employee;
		this.attendance_time = attendance_time;
		this.leave_time = leave_time;
		this.dayoffApply = dayoffApply;
	}

	public String getWork_date() {
		return work_date;
	}

	public void setWork_date(String work_date) {
		this.work_date = work_date;
	}

	public EmployeeVO getEmployee() {
		return employee;
	}

	public void setEmployee(EmployeeVO employee) {
		this.employee = employee;
	}

	public Date getAttendance_time() {
		return attendance_time;
	}

	public void setAttendance_time(Date attendance_time) {
		this.attendance_time = attendance_time;
	}

	public Date getLeave_time() {
		return leave_time;
	}

	public void setLeave_time(Date leave_time) {
		this.leave_time = leave_time;
	}

	public DayoffApplyVO getDayoffApply() {
		return dayoffApply;
	}

	public void setDayoffApply(DayoffApplyVO dayoffApply) {
		this.dayoffApply = dayoffApply;
	}

	@Override
	public String toString() {
		return "WorkRecodeVO [work_date=" + work_date + ", employee=" + employee + ", attendance_time="
				+ attendance_time + ", leave_time=" + leave_time + ", dayoffApply=" + dayoffApply + "]";
	}

}
