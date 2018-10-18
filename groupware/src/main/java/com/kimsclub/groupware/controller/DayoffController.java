package com.kimsclub.groupware.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/dayoff/*")
public class DayoffController {
	
	@RequestMapping(value = "/dayoffWriteform", method=RequestMethod.GET)
	public String writeDayoff() {
		System.out.println("write_dayoff() 메소드 호출");
		return "dayoff/dayoff_writeform";
	}
	
	@RequestMapping(value = "/dayoffStatus", method=RequestMethod.GET)
	public String readDayoffStatus() {
		System.out.println("write_dayoff() 메소드 호출");
		return "dayoff/dayoff_status";
	}
}
