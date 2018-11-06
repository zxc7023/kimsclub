package com.kimsclub.groupware.service;

import java.util.List;
import com.kimsclub.groupware.vo.CalendarVO;

public interface CalendarService {

	//이벤트 등록
	public void addCalendar(CalendarVO vo);

	public int selectSeq();
	
}
