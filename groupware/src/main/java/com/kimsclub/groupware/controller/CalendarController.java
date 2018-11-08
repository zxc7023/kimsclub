package com.kimsclub.groupware.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kimsclub.groupware.service.CalendarService;
import com.kimsclub.groupware.vo.CalendarVO;

/**
 * @author DANAWACOMPUTER
 *
 */
/**
 * @author DANAWACOMPUTER
 *
 */
/**
 * @author DANAWACOMPUTER
 *
 */
/**
 * @author DANAWACOMPUTER
 *
 */
@Controller
public class CalendarController {

	@Autowired
	CalendarService service;

	/**
	 * 캘린더뷰를 반환
	 * 
	 * @return
	 */
	@RequestMapping(value = "/calendar", method = RequestMethod.GET)
	public String calendarList() {
		System.out.println("Fullcalendar() 메소드 호출");
		return "Fullcalendar/basic-views";
	}

	/**
	 * 시퀀스 이벤트번호를 json 형식으로 반환
	 * 
	 * @return
	 */
	@RequestMapping(value = "/selectCalSeq", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> nocalendar() {
		int seq = service.selectSeq();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("event_no", seq);
		System.out.println(seq);
		return map;
	}

	/**
	 * event 등록
	 * 
	 * @param vo 이벤트객체
	 * @return
	 */
	@RequestMapping(value = "/addCalendar", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Integer> addcalendar(@RequestBody CalendarVO vo) {
		System.out.println("addcalendar() 메소드 호출");
		System.out.println(vo);

		Map<String, Integer> resultMap = new HashMap<String, Integer>();
		resultMap.put("result", 1);

		try {
			service.addCalendar(vo);
		} catch (Exception e) {
			resultMap.put("result", 0);
		}

		return resultMap;
	}

	/**
	 * event 편집
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/editCalendar", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Integer> editcalendar(@RequestBody CalendarVO vo){
		System.out.println("addcalendar() 메소드 호출");
		System.out.println(vo);
		
		Map<String, Integer> resultMap = new HashMap<String, Integer>();
		resultMap.put("result", 1);
		
		try {
			service.addCalendar(vo);
		}catch (Exception e) {
			resultMap.put("result", 0);
		}

		return resultMap;
	}

}
