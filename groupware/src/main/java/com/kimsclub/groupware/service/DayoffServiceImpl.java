package com.kimsclub.groupware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.DayoffDAO;
import com.kimsclub.groupware.vo.DayoffCreateConditionVO;

@Service
public class DayoffServiceImpl implements DayoffService {

	@Autowired
	DayoffDAO dao;

	@Override
	public List<DayoffCreateConditionVO> getDayoffCreateCondition() {
		return dao.getDayoffCondition();
	}


}
