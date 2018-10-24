package com.kimsclub.groupware.vo;

public class DayoffKindsVO {
	int dayoff_type_code;
	String dayoff_name;
	String dayoff_deduction;
	
	
	public DayoffKindsVO() {
		super();
	}


	public DayoffKindsVO(int dayoff_type_code, String dayoff_name, String dayoff_deduction) {
		super();
		this.dayoff_type_code = dayoff_type_code;
		this.dayoff_name = dayoff_name;
		this.dayoff_deduction = dayoff_deduction;
	}


	public int getDayoff_type_code() {
		return dayoff_type_code;
	}


	public void setDayoff_type_code(int dayoff_type_code) {
		this.dayoff_type_code = dayoff_type_code;
	}


	public String getDayoff_name() {
		return dayoff_name;
	}


	public void setDayoff_name(String dayoff_name) {
		this.dayoff_name = dayoff_name;
	}


	public String getDayoff_deduction() {
		return dayoff_deduction;
	}


	public void setDayoff_deduction(String dayoff_deduction) {
		this.dayoff_deduction = dayoff_deduction;
	}


	@Override
	public String toString() {
		return "DayoffKindsVO [dayoff_type_code=" + dayoff_type_code + ", dayoff_name=" + dayoff_name
				+ ", dayoff_deduction=" + dayoff_deduction + "]";
	}
	

}
