package com.kimsclub.groupware.vo;

public class DayoffMyRecodeVO {
	EmployeeVO employee;
	int annual_dayoff;
	int reward_dayoff;
	int previous_dayoff;
	public DayoffMyRecodeVO() {
		super();
	}
	public DayoffMyRecodeVO(EmployeeVO employee, int annual_dayoff, int reward_dayoff, int previous_dayoff) {
		super();
		this.employee = employee;
		this.annual_dayoff = annual_dayoff;
		this.reward_dayoff = reward_dayoff;
		this.previous_dayoff = previous_dayoff;
	}
	public EmployeeVO getEmployee() {
		return employee;
	}
	public void setEmployee(EmployeeVO employee) {
		this.employee = employee;
	}
	public int getAnnual_dayoff() {
		return annual_dayoff;
	}
	public void setAnnual_dayoff(int annual_dayoff) {
		this.annual_dayoff = annual_dayoff;
	}
	public int getReward_dayoff() {
		return reward_dayoff;
	}
	public void setReward_dayoff(int reward_dayoff) {
		this.reward_dayoff = reward_dayoff;
	}
	public int getPrevious_dayoff() {
		return previous_dayoff;
	}
	public void setPrevious_dayoff(int previous_dayoff) {
		this.previous_dayoff = previous_dayoff;
	}
	@Override
	public String toString() {
		return "DayoffMyRecode [employee=" + employee + ", annual_dayoff=" + annual_dayoff + ", reward_dayoff="
				+ reward_dayoff + ", previous_dayoff=" + previous_dayoff + "]";
	}
	
	
}
