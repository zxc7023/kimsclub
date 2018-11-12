package com.kimsclub.groupware.vo;

public class ApprovalLineVO {
	private int approval_path_no;
	private String approval_path_name;
	private int approval_path_order;
	private EmployeeVO employee; 
		
	
	
	public ApprovalLineVO() {
		super();
	}
	public int getApproval_path_order() {
		return approval_path_order;
	}
	public void setApproval_path_order(int approval_path_order) {
		this.approval_path_order = approval_path_order;
	}
	public int getApproval_path_no() {
		return approval_path_no;
	}
	public void setApproval_path_no(int approval_path_no) {
		this.approval_path_no = approval_path_no;
	}
	public String getApproval_path_name() {
		return approval_path_name;
	}
	public void setApproval_path_name(String approval_path_name) {
		this.approval_path_name = approval_path_name;
	}
	public EmployeeVO getEmployee() {
		return employee;
	}
	public void setEmployee(EmployeeVO employee) {
		this.employee = employee;
	}
	@Override
	public String toString() {
		return "ApprovalLineVO [approval_path_no=" + approval_path_no + ", approval_path_name=" + approval_path_name + ", approval_path_order=" + approval_path_order + ", employee=" + employee + "]";
	}
	
	
	
}
