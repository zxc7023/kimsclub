package com.kimsclub.groupware.vo;

public class DayoffCreateConditionVO {
	int year_in_office;
	int dayoff_days;
	
	public DayoffCreateConditionVO() {
		
	}
	
	
	public DayoffCreateConditionVO(int year_in_office, int dayoff_days) {
		super();
		this.year_in_office = year_in_office;
		this.dayoff_days = dayoff_days;
	}


	public int getYear_in_office() {
		return year_in_office;
	}

	public void setYear_in_office(int year_in_office) {
		this.year_in_office = year_in_office;
	}

	public int getDayoff_days() {
		return dayoff_days;
	}

	public void setDayoff_days(int dayoff_days) {
		this.dayoff_days = dayoff_days;
	}
	
		
}
