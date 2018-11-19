package com.kimsclub.groupware.vo;

public class WorkSettingVO {
	String sun;
	String mon;
	String tue;
	String wen;
	String tur;
	String fri;
	String sat;
	int start_hour;
	int start_minute;
	int end_hour;
	int end_minute;

	public WorkSettingVO() {
		super();
	}

	public WorkSettingVO(String sun, String mon, String tue, String wen, String tur, String fri, String sat,
			int start_hour, int start_minute, int end_hour, int end_minute) {
		super();
		this.sun = sun;
		this.mon = mon;
		this.tue = tue;
		this.wen = wen;
		this.tur = tur;
		this.fri = fri;
		this.sat = sat;
		this.start_hour = start_hour;
		this.start_minute = start_minute;
		this.end_hour = end_hour;
		this.end_minute = end_minute;
	}

	public String getSun() {
		return sun;
	}

	public void setSun(String sun) {
		this.sun = sun;
	}

	public String getMon() {
		return mon;
	}

	public void setMon(String mon) {
		this.mon = mon;
	}

	public String getTue() {
		return tue;
	}

	public void setTue(String tue) {
		this.tue = tue;
	}

	public String getWen() {
		return wen;
	}

	public void setWen(String wen) {
		this.wen = wen;
	}

	public String getTur() {
		return tur;
	}

	public void setTur(String tur) {
		this.tur = tur;
	}

	public String getFri() {
		return fri;
	}

	public void setFri(String fri) {
		this.fri = fri;
	}

	public String getSat() {
		return sat;
	}

	public void setSat(String sat) {
		this.sat = sat;
	}

	public int getStart_hour() {
		return start_hour;
	}

	public void setStart_hour(int start_hour) {
		this.start_hour = start_hour;
	}

	public int getStart_minute() {
		return start_minute;
	}

	public void setStart_minute(int start_minute) {
		this.start_minute = start_minute;
	}

	public int getEnd_hour() {
		return end_hour;
	}

	public void setEnd_hour(int end_hour) {
		this.end_hour = end_hour;
	}

	public int getEnd_minute() {
		return end_minute;
	}

	public void setEnd_minute(int end_minute) {
		this.end_minute = end_minute;
	}

	@Override
	public String toString() {
		return "WorkSettingVO [sun=" + sun + ", mon=" + mon + ", tue=" + tue + ", wen=" + wen + ", tur=" + tur
				+ ", fri=" + fri + ", sat=" + sat + ", start_hour=" + start_hour + ", start_minute=" + start_minute
				+ ", end_hour=" + end_hour + ", end_minute=" + end_minute + "]";
	}

}
