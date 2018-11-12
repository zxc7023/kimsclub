package com.kimsclub.groupware.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kimsclub.groupware.dao.DayoffDAO;
import com.kimsclub.groupware.dao.DocumentDAO;
import com.kimsclub.groupware.dao.EmployeeDAO;
import com.kimsclub.groupware.vo.DayoffApplyVO;
import com.kimsclub.groupware.vo.DayoffCreateRecodeVO;
import com.kimsclub.groupware.vo.DayoffCreateTermsVO;
import com.kimsclub.groupware.vo.DayoffKindsVO;
import com.kimsclub.groupware.vo.DayoffMyRecodeVO;
import com.kimsclub.groupware.vo.EmployeeVO;

@Service
public class DayoffServiceImpl implements DayoffService {

	@Autowired
	DayoffDAO dao;
	

	@Autowired 
	DocumentDAO dDao;
	

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
	public void createDayoffTotalEmployee(EmployeeVO admin) {
		List<DayoffCreateRecodeVO> empList = dao.selectEmpDayoffDays();
		
		for(DayoffCreateRecodeVO vo : empList) {
			vo.setDayoff_generator(admin.getEmployee_no());
		}
		dao.insertEmpsAnnualDayoff(empList);

	}

	@Override
	public List<DayoffCreateRecodeVO> getMyCreateRecode(EmployeeVO vo) {
		return dao.selectMyDayoffRecode(vo);
	}
	
	@Override
	public DayoffMyRecodeVO readMyDayoffDays(EmployeeVO vo) {
		return dao.selectTotalDayoffDays(vo);
	}
	
	@Override
	public List<DayoffApplyVO> readUseMyDayoff(EmployeeVO vo){
		return dao.selectDayoffApply(vo);
	}

	@Override
	public void applyDayoff(DayoffApplyVO vo) {
		try {
			dao.applyDayoff(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int selectUseDate(Map<String, Object> map) {
		return dao.selectUseDate(map);
		
	}
	
	@Override
	public  List<DayoffApplyVO> selectApplyList(EmployeeVO vo) {
		return dao.selectApplyList(vo);
	}

	@Override
	public List<DayoffApplyVO> selectApplyListWithCriteria(DayoffApplyVO vo) {
		return dao.selectApplyListWithCriteria(vo);
		
	}

	@Override
	public DayoffApplyVO dayoffApplyDetailList(DayoffApplyVO vo) {
		return dao.dayoffApplyDetailList(vo);
	}

	@Override
	public DayoffApplyVO getDayoffEvent() {
		return dao.getDayoffEvent();
	}


	


}
