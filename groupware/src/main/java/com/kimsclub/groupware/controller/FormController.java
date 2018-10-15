package com.kimsclub.groupware.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class FormController {
	
	@RequestMapping(value = "/form", method=RequestMethod.GET)
	public String form(){
		System.out.println("form() 메소드 호출");
		return "form/form";
	}
	
	@RequestMapping(value = "/createform", method=RequestMethod.GET)
	public String create_form(){
		System.out.println("form() 메소드 호출");
		return "form/formCreate";
	}
	
}
