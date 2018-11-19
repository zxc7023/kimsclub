package com.kimsclub.groupware.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.WorkRecodeDAO;
import com.kimsclub.groupware.vo.EmployeeVO;
import com.kimsclub.groupware.vo.WorkRecodeVO;
import com.kimsclub.groupware.vo.WorkSettingVO;

@Service
public class WorkRecodeServiceImpl implements WorkRecodeService {

	
	@Autowired
	WorkRecodeDAO dao;
	

	@Override
	public List<WorkRecodeVO> getWorkRecodes(Map<String, Object> map) {
		return dao.getWorkRecodes(map);
	}


	@Override
	public WorkSettingVO getWorkSetting() {
		return dao.getWorkSetting();
	}

}
