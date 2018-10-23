package com.kimsclub.groupware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.DayoffDAO;
import com.kimsclub.groupware.vo.DayoffCreateTermsVO;

@Service
public class DayoffServiceImpl implements DayoffService {

	@Autowired
	DayoffDAO dao;

	@Override
	public List<DayoffCreateTermsVO> getDayoffCreateTerms() {
		return dao.getDayoffCreateTerms();
	}

	@Override
	public void modifyDayoffCreateTerms(List<DayoffCreateTermsVO> list) {
		dao.modifyDayoffCreateTerms(list);
	}
	
	
	
	


}
