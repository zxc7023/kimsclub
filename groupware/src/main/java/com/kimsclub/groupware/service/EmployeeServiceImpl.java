package com.kimsclub.groupware.service;

import java.util.List;

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

}
