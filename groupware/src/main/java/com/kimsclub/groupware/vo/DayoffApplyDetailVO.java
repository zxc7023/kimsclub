package com.kimsclub.groupware.vo;

import java.util.Date;

public class DayoffApplyDetailVO {
	int dayoff_no;
	Date dayoff_day;
	double days;
	String oneorhalf;
	public DayoffApplyDetailVO() {
		super();
	}
	public DayoffApplyDetailVO(int dayoff_no, Date dayoff_day, double days, String oneorhalf) {
		super();
		this.dayoff_no = dayoff_no;
		this.dayoff_day = dayoff_day;
		this.days = days;
		this.oneorhalf = oneorhalf;
	}
	public int getDayoff_no() {
		return dayoff_no;
	}
	public void setDayoff_no(int dayoff_no) {
		this.dayoff_no = dayoff_no;
	}
	public Date getDayoff_day() {
		return dayoff_day;
	}
	public void setDayoff_day(Date dayoff_day) {
		this.dayoff_day = dayoff_day;
	}
	public double getDays() {
		return days;
	}
	public void setDays(double days) {
		this.days = days;
	}
	public String getOneorhalf() {
		return oneorhalf;
	}
	public void setOneorhalf(String oneorhalf) {
		this.oneorhalf = oneorhalf;
	}
	@Override
	public String toString() {
		return "DayoffApplyDetailVO [dayoff_no=" + dayoff_no + ", dayoff_day=" + dayoff_day + ", days=" + days + ", oneorhalf=" + oneorhalf + "]";
	}
	
}
