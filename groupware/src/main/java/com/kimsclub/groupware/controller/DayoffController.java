package com.kimsclub.groupware.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/dayoff/*")
public class DayoffController {
	
	@RequestMapping(value = "/dayoff_writeform", method=RequestMethod.GET)
	public String write_dayoff() {
		System.out.println("write_dayoff() 메소드 호출");
		return "dayoff/dayoffWriteform";
	}
	
}
