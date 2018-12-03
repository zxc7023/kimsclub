package com.kimsclub.groupware.vo;

public class WorkdaySettingVO {
	String workday;
	String iswork;

	public WorkdaySettingVO() {
		super();
	}

	public WorkdaySettingVO(String workday, String iswork) {
		super();
		this.workday = workday;
		this.iswork = iswork;
	}

	public String getWorkday() {
		return workday;
	}

	public void setWorkday(String workday) {
		this.workday = workday;
	}

	public String getIswork() {
		return iswork;
	}

	public void setIswork(String iswork) {
		this.iswork = iswork;
	}

	@Override
	public String toString() {
		return "WorkdaySetting [workday=" + workday + ", iswork=" + iswork + "]";
	}

}
