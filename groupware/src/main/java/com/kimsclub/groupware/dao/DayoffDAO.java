package com.kimsclub.groupware.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.DayoffApplyVO;
import com.kimsclub.groupware.vo.DayoffCreateRecodeVO;
import com.kimsclub.groupware.vo.DayoffCreateTermsVO;
import com.kimsclub.groupware.vo.DayoffKindsVO;
import com.kimsclub.groupware.vo.DayoffMyRecodeVO;
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
			session.update("dayoff.updateAnualMyRecode",vo);
		}
	}
	
	public List<DayoffCreateRecodeVO> selectMyDayoffRecode(EmployeeVO vo) {
		return session.selectList("dayoff.selecMytCreateRecode",vo);
	}
	
	/**
	 * 최종으로 생성된 나의 휴가일수를 가져오기위한 메소드
	 * @param vo emploee_no가 저장된 vo객체
	 * @return
	 */
	public DayoffMyRecodeVO selectTotalDayoffDays(EmployeeVO vo) {
		return session.selectOne("dayoff.selectDayoffMyRecode",vo);
	}
	
	public List<DayoffApplyVO> selectDayoffApply(EmployeeVO vo){
		return session.selectList("dayoff.selectDayoffToUse",vo);
	}
	
}
