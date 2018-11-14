package com.kimsclub.groupware.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class TransmissionController {
	
	@RequestMapping(value = "/sendDoc", method=RequestMethod.POST)
	public String sendDoc(@RequestParam("employee_no")int[] employee_no){
		System.out.println("sendDoc() 메소드 호출");
		for(int i:employee_no) {
			System.out.println(i);
		}
		return "transmission/sendDocList";
	}
}
