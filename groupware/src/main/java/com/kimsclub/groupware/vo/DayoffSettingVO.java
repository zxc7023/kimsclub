package com.kimsclub.groupware.vo;

public class DayoffSettingVO {
	int dayoffTypeCode;
	String dayoffName;
	String useSetting;
	String minusSetting;
	public DayoffSettingVO() {
		super();
	}
	public DayoffSettingVO(int dayoffTypeCode, String dayoffName, String useSetting, String minusSetting) {
		super();
		this.dayoffTypeCode = dayoffTypeCode;
		this.dayoffName = dayoffName;
		this.useSetting = useSetting;
		this.minusSetting = minusSetting;
	}
	public int getDayoffTypeCode() {
		return dayoffTypeCode;
	}
	public void setDayoffTypeCode(int dayoffTypeCode) {
		this.dayoffTypeCode = dayoffTypeCode;
	}
	public String getDayoffName() {
		return dayoffName;
	}
	public void setDayoffName(String dayoffName) {
		this.dayoffName = dayoffName;
	}
	public String getUseSetting() {
		return useSetting;
	}
	public void setUseSetting(String useSetting) {
		this.useSetting = useSetting;
	}
	public String getMinusSetting() {
		return minusSetting;
	}
	public void setMinusSetting(String minusSetting) {
		this.minusSetting = minusSetting;
	}
	@Override
	public String toString() {
		return "DayoffSettingVO [dayoffTypeCode=" + dayoffTypeCode + ", dayoffName=" + dayoffName + ", useSetting=" + useSetting + ", minusSetting=" + minusSetting + "]";
	}
	
}
