package com.kimsclub.groupware.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.DayoffCreateConditionVO;

@Repository
public class DayoffDAO {
	
	@Autowired
	SqlSession session;
	
	public List<DayoffCreateConditionVO> getDayoffCondition(){
		return session.selectList("dayoff.selectCreateCondition");
	}

	public void modifyDayoffCondition(List<DayoffCreateConditionVO> list) {
		for(DayoffCreateConditionVO vo : list) {
			session.update("dayoff.updateCreateCondition",vo);			
		}
		
	}
}
