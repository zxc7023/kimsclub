package com.kimsclub.groupware.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CalendarController {
	
	@RequestMapping(value = "/calendar", method=RequestMethod.GET)
	public String form(){
		System.out.println("Fullcalendar() 메소드 호출");
		return "Fullcalendar/basic-views";
	}
	@RequestMapping(value = "/cal", method=RequestMethod.GET)
	public String form1(){
		System.out.println("Fullcalendar() 메소드 호출");
		return "Fullcalendar/basic";
	}
	
	@RequestMapping(value = "/ca", method=RequestMethod.GET)
	public String form2(){
		System.out.println("Fullcalendar() 메소드 호출");
		return "Fullcalendar/SchForm";
	}
		
}
