package com.kimsclub.groupware.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.DayoffCreateTermsVO;
import com.kimsclub.groupware.vo.DayoffKindsVO;

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
	
}
