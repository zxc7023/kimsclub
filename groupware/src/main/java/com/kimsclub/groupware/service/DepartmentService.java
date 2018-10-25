package com.kimsclub.groupware.service;

import java.util.List;

import com.kimsclub.groupware.vo.DepartmentVO;

public interface DepartmentService {

	List<DepartmentVO> getDepartmentList();
	public int[] getMaxSize();
}
