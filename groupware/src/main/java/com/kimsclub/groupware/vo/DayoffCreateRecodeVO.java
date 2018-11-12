package com.kimsclub.groupware.vo;

import java.util.Date;

public class DayoffCreateRecodeVO {
	int employee_no;
	Date generation_date;
	int effect_day;
	int real_day;
	String dayoff_type;
	int dayoff_generator;
	String create_reason;

	public DayoffCreateRecodeVO() {

	}

	public DayoffCreateRecodeVO(int employee_no, Date generation_date, int effect_day, int real_day, String dayoff_type,
			int dayoff_generator, String create_reason) {
		super();
		this.employee_no = employee_no;
		this.generation_date = generation_date;
		this.effect_day = effect_day;
		this.real_day = real_day;
		this.dayoff_type = dayoff_type;
		this.dayoff_generator = dayoff_generator;
		this.create_reason = create_reason;
	}

	public int getEmployee_no() {
		return employee_no;
	}

	public void setEmployee_no(int employee_no) {
		this.employee_no = employee_no;
	}

	public Date getGeneration_date() {
		return generation_date;
	}

	public void setGeneration_date(Date generation_date) {
		this.generation_date = generation_date;
	}

	public int getEffect_day() {
		return effect_day;
	}

	public void setEffect_day(int effect_day) {
		this.effect_day = effect_day;
	}

	public int getReal_day() {
		return real_day;
	}

	public void setReal_day(int real_day) {
		this.real_day = real_day;
	}

	public String getDayoff_type() {
		return dayoff_type;
	}

	public void setDayoff_type(String dayoff_type) {
		this.dayoff_type = dayoff_type;
	}

	public int getDayoff_generator() {
		return dayoff_generator;
	}

	public void setDayoff_generator(int dayoff_generator) {
		this.dayoff_generator = dayoff_generator;
	}

	public String getCreate_reason() {
		return create_reason;
	}

	public void setCreate_reason(String create_reason) {
		this.create_reason = create_reason;
	}

	@Override
	public String toString() {
		return "DayoffCreateRecodeVO [employee_no=" + employee_no + ", generation_date=" + generation_date
				+ ", effect_day=" + effect_day + ", real_day=" + real_day + ", dayoff_type=" + dayoff_type
				+ ", dayoff_generator=" + dayoff_generator + ", create_reason=" + create_reason + "]";
	}

	

}
