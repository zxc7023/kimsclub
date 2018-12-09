package com.kimsclub.groupware.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.EmployeeDAO;
import com.kimsclub.groupware.vo.EmployeeVO;

@Service
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	EmployeeDAO dao;
	
	@Override
	public EmployeeVO login(EmployeeVO vo) {
		return dao.login(vo);
	}
	
	@Override
	public List<EmployeeVO> getEmployeeList(){
		return dao.selectEmployeeList();
	}

	@Override
	public List<EmployeeVO> loadAllEmp() {
		return dao.loadAllEmp();
	}

	@Override
	public void updateLastLogin(EmployeeVO vo) {
		dao.updatelastLogin(vo);
	}

	@Override
	public void addEmployee(EmployeeVO evo) {
		dao.insertEmployee(evo);
	}

	@Override
	public List<EmployeeVO> loadAllEmpList(Map<String, Object> map) {
		return dao.loadAllEmpList(map);
	}

	@Override
	public int getEmployeeCnt(Map<String, Object> map) {
		return dao.getEmployeeCnt(map);
	}

	@Override
	public void modifyEmployeeResult(EmployeeVO evo) {
		dao.modifyEmployeeResult(evo);
	}

	@Override
	public EmployeeVO getEmployeeHiredate(EmployeeVO employeeVO) {
		return dao.selectEmployeeHiredate(employeeVO);
	}

	@Override
	public List<EmployeeVO> getEmpListWithCri(Map<String, Object> map) {
		return dao.selectEmpListWithCri(map);
	}

	@Override
	public int getEmpCntWithCri(Map<String, Object> map) {
		return dao.selectEmpCntWithCri(map);
	}

}
