package com.kimsclub.groupware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.DepartmentDAO;

import com.kimsclub.groupware.vo.DepartmentVO;

@Service("DepartmentService")
public class DepartmentServiceImpl implements DepartmentService {

	@Autowired
	DepartmentDAO dao;

	@Override
	public List<DepartmentVO> getDepartmentList() {
		return dao.getSelectList();
	}

	@Override
	public int getDepartmentSeq() {
		return dao.selectDepartmentSeq();
	}

	@Override
	public void addDepartment(DepartmentVO vo) {
		dao.insertDepartment(vo);
	}

	@Override
	public void modifyDepartmentName(DepartmentVO vo) {
		dao.updateDpartmentName(vo);
	}

	@Override
	public void removeDepartment(DepartmentVO vo) {
		dao.deleteDepartments(vo);
	}

}
