package com.kimsclub.groupware.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.CalendarVO;

@Repository
public class CalendarDAO {
	@Autowired
	SqlSession session;
	

	//이벤트 등록
	public void addCalendar(CalendarVO vo) {
		session.insert("calendar.addCalendar", vo);
	}


	public int selectCalSeq() {
		return session.selectOne("calendar.selectCalendarSequence");
	}


	public List<CalendarVO> selectEvents() {
		return session.selectList("calendar.selectEvents");
	}
	
	public void editCalendar(CalendarVO vo) {
		session.insert("calendar.editCalendar", vo);
	}
	public void deleteCalendar(CalendarVO vo) {
		session.insert("calendar.deleteCalendar", vo);
	}
	


}
