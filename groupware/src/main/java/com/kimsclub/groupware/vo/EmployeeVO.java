package com.kimsclub.groupware.vo;

import java.util.Date;

public class EmployeeVO {
	private int employee_no;
	private String employee_name;
	private String password;
	private Date hiredate;
	private String usertype;
	private DepartmentVO department;
	private String email;
	private String position;
	private String phonenumber;
	public int getEmployee_no() {
		return employee_no;
	}
	public void setEmployee_no(int employee_no) {
		this.employee_no = employee_no;
	}
	public String getEmployee_name() {
		return employee_name;
	}
	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Date getHiredate() {
		return hiredate;
	}
	public void setHiredate(Date hiredate) {
		this.hiredate = hiredate;
	}
	public String getUsertype() {
		return usertype;
	}
	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
	public DepartmentVO getDepartment() {
		return department;
	}
	public void setDepartment(DepartmentVO department) {
		this.department = department;
	}
	@Override
	public String toString() {
		return "EmployeeVO [employee_no=" + employee_no + ", employee_name=" + employee_name + ", password=" + password + ", hiredate=" + hiredate + ", usertype=" + usertype + ", department=" + department + ", email=" + email + ", position=" + position + ", phonenumber=" + phonenumber + "]";
	}
	
	
	
	
}
