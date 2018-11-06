package com.kimsclub.groupware.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.CalendarDAO;
import com.kimsclub.groupware.vo.CalendarVO;

@Service
public class CalendarServiceImpl implements CalendarService {
	@Autowired
	CalendarDAO dao;
	
	//이벤트 등록
	@Override
	public void addCalendar(CalendarVO vo) {
		dao.addCalendar(vo);
	}

	@Override
	public int selectSeq() {
		return dao.selectCalSeq();
	}
	
	
}
