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

	
	/**
	 * 세션에 저장된 사용자의 hiredate를 가져오기 위한 메소드 
	 * @param employeeVO 세션에 저장된 employee 객체
	 * @return EmployeeVO객체 (hiredate가 맴버변수에 저장되어 있다.)
	 */
	public EmployeeVO getEmployeeHiredate(EmployeeVO employeeVO);

	/**
	 * map(cri + department_no)을 검색 기준으로 리스트 받아온다.
	 * @param map
	 * @return
	 */
	public List<EmployeeVO> getEmpListWithCri(Map<String, Object> map);
}
