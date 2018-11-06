package com.kimsclub.groupware.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kimsclub.groupware.service.CalendarService;
import com.kimsclub.groupware.vo.CalendarVO;

import sun.print.resources.serviceui_ko;

@Controller
public class CalendarController {
	
	@Autowired
	CalendarService service;

	@RequestMapping(value = "/calendar", method = RequestMethod.GET)		
	public String calendarList() {
		System.out.println("Fullcalendar() 메소드 호출");
		return "Fullcalendar/basic-views";
	}
	
	@RequestMapping(value = "/addCalendar", method = RequestMethod.POST)		
	public ModelAndView addcalendar(@RequestBody CalendarVO vo){
		
		System.out.println(vo);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("Fullcalendar/basic-views");
		System.out.println("Fullcalendar() 메소드 호출");
		return mav;
	}
	@RequestMapping(value = "/selectCalSeq", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> nocalendar(){
		int seq = service.selectSeq();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("event_no", seq);
		System.out.println(seq);
		return map;
	}

	
	
/*	@RequestMapping(value = "/calendar2", method = RequestMethod.GET)
	public String form3() {//본버전
		System.out.println("Fullcalendar() 메소드 호출");
		return "Fullcalendar/views";
	}*/


}
