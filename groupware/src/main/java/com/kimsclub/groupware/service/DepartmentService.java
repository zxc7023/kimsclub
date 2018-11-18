package com.kimsclub.groupware.service;

import java.util.List;
import java.util.Map;

import com.kimsclub.groupware.vo.DepartmentVO;

public interface DepartmentService {

	public List<DepartmentVO> getDepartmentList();

	public int getDepartmentSeq();

	public void addDepartment(DepartmentVO vo);

	public void modifyDepartmentName(DepartmentVO vo);

	public void removeDepartment(DepartmentVO vo);

	public DepartmentVO checkChildren(Map<String, Object> map);

	public void changeParentDepartment(Map<String, Object> map);

}
