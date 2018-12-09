package com.kimsclub.groupware.vo;

public class TreeVO {
	private String no;
	private String pNo;
	private String name;
	private int cnt;
	private boolean isParent;

	public TreeVO(EmployeeVO evo) {
		super();
		this.no = "e"+evo.getEmployee_no();
		this.pNo = "d"+evo.getDepartment().getDepartment_no();
		this.name = evo.getEmployee_name();
		
	}
	public TreeVO(DepartmentVO dvo) {
		super();
		this.no = "d"+dvo.getDepartment_no();
		this.pNo = "d"+dvo.getDepartment_parent_no();
		this.name = dvo.getDepartment_name();
		this.cnt = dvo.getDepartment_people_cnt();
		this.isParent = true;
	}
	
	public TreeVO() {
		super();
	}
	
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getpNo() {
		return pNo;
	}
	public void setpNo(String pNo) {
		this.pNo = pNo;
	}
	public boolean isParent() {
		return isParent;
	}
	public void setParent(boolean isParent) {
		this.isParent = isParent;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	@Override
	public String toString() {
		return "TreeVO [no=" + no + ", pNo=" + pNo + ", name=" + name + ", cnt=" + cnt + ", isParent=" + isParent + "]";
	}
	
	
	
}
