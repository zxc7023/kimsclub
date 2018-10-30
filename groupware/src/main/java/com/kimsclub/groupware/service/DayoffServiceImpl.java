package com.kimsclub.groupware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.DayoffDAO;
import com.kimsclub.groupware.vo.DayoffCreateTermsVO;
import com.kimsclub.groupware.vo.DayoffKindsVO;

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

	@Override
	public List<DayoffKindsVO> getDayoffKinds() {
		return dao.getDayoffKinds();
	}

	@Override
	public void createDayoffkinds(DayoffKindsVO vo) {
		dao.insertDayoffKinds(vo);
	}

	@Override
	public void createDayoffTotalEmployee() {
		
	}
	
	
	
	


}
