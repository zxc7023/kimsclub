package com.kimsclub.groupware.vo;

public class DayoffCreateTermsVO {
	int year_in_office;
	int dayoff_days;

	public DayoffCreateTermsVO() {
	}

	public DayoffCreateTermsVO(int year_in_office, int dayoff_days) {
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

	@Override
	public String toString() {
		return "DayoffCreateTermsVO [year_in_office=" + year_in_office + ", dayoff_days=" + dayoff_days + "]";
	}


}
