package com.kimsclub.groupware.vo;

public class WorkhourSettingVO {
	String start_hour;
	String start_minute;
	String end_hour;
	String end_minute;
	public WorkhourSettingVO() {
		super();
	}
	public WorkhourSettingVO(String start_hour, String start_minute, String end_hour, String end_minute) {
		super();
		this.start_hour = start_hour;
		this.start_minute = start_minute;
		this.end_hour = end_hour;
		this.end_minute = end_minute;
	}
	public String getStart_hour() {
		return start_hour;
	}
	public void setStart_hour(String start_hour) {
		this.start_hour = start_hour;
	}
	public String getStart_minute() {
		return start_minute;
	}
	public void setStart_minute(String start_minute) {
		this.start_minute = start_minute;
	}
	public String getEnd_hour() {
		return end_hour;
	}
	public void setEnd_hour(String end_hour) {
		this.end_hour = end_hour;
	}
	public String getEnd_minute() {
		return end_minute;
	}
	public void setEnd_minute(String end_minute) {
		this.end_minute = end_minute;
	}
	@Override
	public String toString() {
		return "WorkhourSettingVO [start_hour=" + start_hour + ", start_minute=" + start_minute + ", end_hour="
				+ end_hour + ", end_minute=" + end_minute + "]";
	}
	
	
}
