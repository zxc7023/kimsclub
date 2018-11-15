package com.kimsclub.groupware.vo;

import java.util.List;

public class ApprovalPathVO {
	private int approval_path_no;
	private String approval_path_name;
	private EmployeeVO employee;
	private List<ApprovalPathDetailVO> apdlist;
	
	public ApprovalPathVO() {
		super();
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

	public List<ApprovalPathDetailVO> getApdlist() {
		return apdlist;
	}

	public void setApdlist(List<ApprovalPathDetailVO> apdlist) {
		this.apdlist = apdlist;
	}

	@Override
	public String toString() {
		return "ApprovalPathVO [approval_path_no=" + approval_path_no + ", approval_path_name=" + approval_path_name + ", employee=" + employee + "]";
	}

	
	
}
