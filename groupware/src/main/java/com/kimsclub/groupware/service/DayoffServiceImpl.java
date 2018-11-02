package com.kimsclub.groupware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.DayoffDAO;
import com.kimsclub.groupware.dao.EmployeeDAO;
import com.kimsclub.groupware.vo.DayoffCreateRecodeVO;
import com.kimsclub.groupware.vo.DayoffCreateTermsVO;
import com.kimsclub.groupware.vo.DayoffKindsVO;
import com.kimsclub.groupware.vo.EmployeeVO;

@Service
public class DayoffServiceImpl implements DayoffService {

	@Autowired
	DayoffDAO dao;
	EmployeeDAO empDao;

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
	
	
	
	


}
