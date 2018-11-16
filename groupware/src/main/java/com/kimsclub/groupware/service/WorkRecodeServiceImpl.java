package com.kimsclub.groupware.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.WorkRecodeDAO;
import com.kimsclub.groupware.vo.EmployeeVO;
import com.kimsclub.groupware.vo.WorkRecodeVO;

@Service
public class WorkRecodeServiceImpl implements WorkRecodeService {

	
	@Autowired
	WorkRecodeDAO dao;
	
	@Override
	public List<WorkRecodeVO> getWorkRecodes(EmployeeVO vo) {
		return dao.getWorkRecodes(vo);
	}

}
