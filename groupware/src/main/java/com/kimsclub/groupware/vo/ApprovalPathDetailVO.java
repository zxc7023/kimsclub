package com.kimsclub.groupware.vo;

public class ApprovalPathDetailVO {
	private int approval_path_no;
	private int approval_path_order;
	private EmployeeVO employee;
	public ApprovalPathDetailVO() {
		super();
	}
	public int getApproval_path_no() {
		return approval_path_no;
	}
	public void setApproval_path_no(int approval_path_no) {
		this.approval_path_no = approval_path_no;
	}
	public int getApproval_path_order() {
		return approval_path_order;
	}
	public void setApproval_path_order(int approval_path_order) {
		this.approval_path_order = approval_path_order;
	}
	public EmployeeVO getEmployee() {
		return employee;
	}
	public void setEmployee(EmployeeVO employee) {
		this.employee = employee;
	}
	@Override
	public String toString() {
		return "ApprovalPathDetailVO [approval_path_no=" + approval_path_no + ", approval_path_order=" + approval_path_order + ", employee=" + employee + "]";
	}
	
}
