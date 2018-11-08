package com.kimsclub.groupware.service;

import java.util.List;
import java.util.Map;

import com.kimsclub.groupware.vo.CalendarVO;

public interface CalendarService {

	//이벤트 등록
	public void addCalendar(CalendarVO vo);
	//이벤트번호 선택
	public int selectSeq();
	//이벤트 조회
	public List<CalendarVO> selectEvents();
	//이벤트 편집
	public void editCalendar(CalendarVO vo);
	
}
