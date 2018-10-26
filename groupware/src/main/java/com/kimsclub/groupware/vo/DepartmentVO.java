package com.kimsclub.groupware.vo;

public class DepartmentVO {
	private String department_name;
	private int department_no;
	private int department_parent_no;
	private int department_people_cnt;

	public DepartmentVO() {
		super();
	}

	public DepartmentVO(String department_name, int department_no, int department_parent_no, int department_people_cnt) {
		super();
		this.department_name = department_name;
		this.department_no = department_no;
		this.department_parent_no = department_parent_no;
		this.department_people_cnt = department_people_cnt;
	}

	public int getDepartment_people_cnt() {
		return department_people_cnt;
	}

	public void setDepartment_people_cnt(int department_people_cnt) {
		this.department_people_cnt = department_people_cnt;
	}

	public String getDepartment_name() {
		return department_name;
	}

	public void setDepartment_name(String department_name) {
		this.department_name = department_name;
	}

	public int getDepartment_no() {
		return department_no;
	}

	public void setDepartment_no(int department_no) {
		this.department_no = department_no;
	}

	public int getDepartment_parent_no() {
		return department_parent_no;
	}

	public void setDepartment_parent_no(int department_parent_no) {
		this.department_parent_no = department_parent_no;
	}

}
