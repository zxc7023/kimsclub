package com.kimsclub.groupware.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
		System.out.println("================================================================================================================");
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
	 * 이벤트 조회
	 * @return
	 */
	@RequestMapping(value = "/selectEvent", method = RequestMethod.GET)
	@ResponseBody
	public List<CalendarVO> selectEvent() {

		List<CalendarVO> clist = null;
		clist = service.selectEvents();
		System.out.println(clist.size());
		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		try {
			DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd hh:mm");
	        mapper.setDateFormat(fmt);
			json = mapper.writeValueAsString(clist);
			
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(json);
		return clist;

	}
	
	/**
	 * 이벤트 편집
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/editEvent", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Integer> editcalendar(@RequestBody CalendarVO vo) {
		System.out.println("editEvent() 메소드 호출");
		System.out.println(vo);
		System.out.println("================================================================================================================");

		Map<String, Integer> resultMap = new HashMap<String, Integer>();
		resultMap.put("result", 1);

		try {
			service.editEvent(vo);
		} catch (Exception e) {
			resultMap.put("result", 0);
		}

		return resultMap;
	}
	/**
	 * 이벤트 삭제
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/deleteEvent", method = RequestMethod.POST)
	@ResponseBody
	public int deletecalendar(@RequestBody CalendarVO vo) {
		System.out.println("deleteEvent() 메소드 호출");
		System.out.println(vo);
		
		int result = 0;
		
		try {
			service.deleteEvent(vo);
			result = 1;
			System.out.println(result);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

}
