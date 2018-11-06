package com.kimsclub.groupware.service;

import java.util.List;

import com.kimsclub.groupware.vo.EmployeeVO;

public interface EmployeeService {
	public EmployeeVO login(EmployeeVO vo);

	/**
	 * 전체사원을 리스트에 받아온다.
	 * @return
	 */
	List<EmployeeVO> getEmployeeList();
}
