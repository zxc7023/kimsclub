package com.kimsclub.groupware.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.DayoffCreateRecodeVO;
import com.kimsclub.groupware.vo.DayoffCreateTermsVO;
import com.kimsclub.groupware.vo.DayoffKindsVO;
import com.kimsclub.groupware.vo.EmployeeVO;

@Repository
public class DayoffDAO {
	
	@Autowired
	SqlSession session;
	
	public List<DayoffCreateTermsVO> getDayoffCreateTerms(){
		return session.selectList("dayoff.selectCreateTerms");
	}

	public void modifyDayoffCreateTerms(List<DayoffCreateTermsVO> list) {
		for(DayoffCreateTermsVO vo : list) {
			session.update("dayoff.updateCreateTerms",vo);			
		}
	}
	
	public List<DayoffKindsVO> getDayoffKinds(){
		return session.selectList("dayoff.selectDayoffKinds");
	}

	public void insertDayoffKinds(DayoffKindsVO vo) {
		session.insert("dayoff.insertDayoffKinds",vo);
	}

	public List<DayoffCreateRecodeVO> selectEmpDayoffDays(){
		return session.selectList("dayoff.selectEmpDayoffDay");
	}
	
	public void insertEmpsAnnualDayoff(List<DayoffCreateRecodeVO> empList) {
		for(DayoffCreateRecodeVO vo : empList) {
			session.insert("dayoff.insertAnnualDayoff",vo);
		}
	}
	
	public List<DayoffCreateRecodeVO> selectMyDayoffRecode(EmployeeVO vo) {
		return session.selectList("dayoff.selecMytCreateRecode",vo);
	}
	
}
