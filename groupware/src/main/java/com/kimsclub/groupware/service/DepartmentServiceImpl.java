package com.kimsclub.groupware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.DepartmentDAO;
import com.kimsclub.groupware.dao.TestDAO;
import com.kimsclub.groupware.vo.DepartmentVO;

@Service("DepartmentService")
public class DepartmentServiceImpl implements DepartmentService {

	
	@Autowired
	DepartmentDAO dao;
	
	@Override
	public List<DepartmentVO> getDepartmentList() {
		return dao.getDepartmentList();
	}

}
