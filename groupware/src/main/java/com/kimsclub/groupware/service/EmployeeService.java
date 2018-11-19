package com.kimsclub.groupware.service;

import java.util.List;
import java.util.Map;

import com.kimsclub.groupware.vo.EmployeeVO;

public interface EmployeeService {
	public EmployeeVO login(EmployeeVO vo);

	/**
	 * 전체사원을 리스트에 받아온다.
	 * @return
	 */
	List<EmployeeVO> getEmployeeList();
	
	public List<EmployeeVO> loadAllEmp();
	
	public void updateLastLogin(EmployeeVO vo);

	public void addEmployee(EmployeeVO evo);

	public List<EmployeeVO> loadAllEmpList(Map<String, Object> map);

	public int getEmployeeCnt(Map<String, Object> map);

	public void modifyEmployeeResult(EmployeeVO evo);
}
