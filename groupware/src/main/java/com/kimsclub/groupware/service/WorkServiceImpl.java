package com.kimsclub.groupware.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.WorkRecodeDAO;
import com.kimsclub.groupware.vo.WorkRecodeVO;
import com.kimsclub.groupware.vo.WorkdaySettingVO;
import com.kimsclub.groupware.vo.WorkhourSettingVO;

@Service
public class WorkServiceImpl implements WorkService {

	
	@Autowired
	WorkRecodeDAO dao;
	



	@Override
	public List<WorkRecodeVO> getMyWorkRecode(Map<String, Object> map) {
		return dao.selectWorkRecodeList(map);
	}


	@Override
	public WorkhourSettingVO getWorkhourSetting() {
		return dao.selectWorkhourSetting();
	}

}
