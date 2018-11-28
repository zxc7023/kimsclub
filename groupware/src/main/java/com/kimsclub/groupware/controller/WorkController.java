package com.kimsclub.groupware.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kimsclub.groupware.service.WorkRecodeService;
import com.kimsclub.groupware.vo.EmployeeVO;
import com.kimsclub.groupware.vo.WorkRecodeVO;
import com.kimsclub.groupware.vo.WorkSettingVO;

import sun.print.resources.serviceui;

@Controller
@RequestMapping(value = "/work/*")
public class WorkController {

	
	@Autowired
	WorkRecodeService service;
	
	@RequestMapping(value="/workStatus", method=RequestMethod.GET)
	public ModelAndView workStatus(HttpSession session) {
		EmployeeVO vo = (EmployeeVO)session.getAttribute("loginInfo");
		

		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		String json2 = null;
		
		WorkSettingVO sVo = service.getWorkSetting();
		
		try {
			json = mapper.writeValueAsString(sVo);
			json2 = mapper.writeValueAsString(vo);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("workSetting",json);
		mav.addObject("employee",json2);
		mav.setViewName("work/work_status");
		return mav;
	}
	
	@RequestMapping(value="/getMyWorkStatus", method=RequestMethod.POST ,produces="text/html;charset=UTF-8")
	@ResponseBody
	public String getMyWorkStatus(HttpSession session,@RequestBody Date serchTime) {
		EmployeeVO vo = (EmployeeVO)session.getAttribute("loginInfo");
		Calendar start_time = Calendar.getInstance();
		start_time.setTime(serchTime);
	
		Calendar end_time = Calendar.getInstance();
		System.out.println(start_time.get(start_time.DAY_OF_MONTH));
		if(start_time.get(start_time.DAY_OF_MONTH) ==1 ) {
			end_time.set(start_time.get(start_time.YEAR), start_time.get(start_time.MONTH), 15);
		}else {			
			end_time.set(start_time.get(start_time.YEAR), start_time.get(start_time.MONTH), start_time.getActualMaximum(Calendar.DAY_OF_MONTH));
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println("시작일시" + sdf.format(start_time.getTime()));
		System.out.println("종료일시" + sdf.format(end_time.getTime()));
		
		Map<String, Object> map = new HashMap<>();
		map.put("start_time", sdf.format(start_time.getTime()));
		map.put("end_time", sdf.format(end_time.getTime()));
		map.put("employee_no", vo.getEmployee_no());
		
		List<WorkRecodeVO> wList = service.getWorkRecodes(map);
		System.out.println(wList);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = null;

		try {
			DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			mapper.setDateFormat(fmt);
			json = mapper.writeValueAsString(wList);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(json);
		

		return json;
	}
	
	
	@RequestMapping(value="/workSetting", method=RequestMethod.GET)
	public ModelAndView workSetting(HttpSession session) {
		EmployeeVO vo = (EmployeeVO)session.getAttribute("loginInfo");
		
	/*	List<WorkRecodeVO> wlist = service.getWorkRecodes(vo);*/
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("work/work_setting");
		return mav;
	}
	
	
	@RequestMapping(value="/getWorkSetting",method=RequestMethod.POST)
	@ResponseBody
	public String getWorkSetting() {
		System.out.println("여기옴");
		
		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		
		WorkSettingVO sVo = service.getWorkSetting();
		
		try {
			json = mapper.writeValueAsString(sVo);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return json;
	}
	
}
