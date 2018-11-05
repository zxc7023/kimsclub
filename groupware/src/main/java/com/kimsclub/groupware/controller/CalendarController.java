package com.kimsclub.groupware.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CalendarController {

	@RequestMapping(value = "/calendar", method = RequestMethod.GET)
	public String form() {//프로토타입 1.2 날짜미완료
		System.out.println("Fullcalendar() 메소드 호출");
		return "Fullcalendar/basic-views";
	}

	@RequestMapping(value = "/calendar2", method = RequestMethod.GET)
	public String form3() {//본버전
		System.out.println("Fullcalendar() 메소드 호출");
		return "Fullcalendar/views";
	}


}
