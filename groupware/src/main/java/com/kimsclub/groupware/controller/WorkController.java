package com.kimsclub.groupware.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/work/*")
public class WorkController {

	@RequestMapping(value="/workStatus", method=RequestMethod.GET)
	public ModelAndView workStatus() {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("work/work_status");
		return mav;
	}
	
}
