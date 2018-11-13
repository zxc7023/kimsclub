package com.kimsclub.groupware.service;

import java.util.List;

import com.kimsclub.groupware.vo.DepartmentVO;

public interface DepartmentService {

	public List<DepartmentVO> getDepartmentList();

	public int getDepartmentSeq();

	public void addDepartment(DepartmentVO vo);

	public void modifyDepartmentName(DepartmentVO vo);

	public void removeDepartment(DepartmentVO vo);

}
