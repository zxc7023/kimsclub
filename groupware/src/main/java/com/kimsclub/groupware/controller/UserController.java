package com.kimsclub.groupware.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kimsclub.groupware.service.DepartmentService;
import com.kimsclub.groupware.vo.DepartmentVO;

@Controller
public class UserController {
	@Autowired
	DepartmentService service;
	//양식 생성 페이지 호출
	@RequestMapping(value = "/userjoin", method=RequestMethod.GET)
	public String user_join(){
		System.out.println("user_join() 메소드 호출");
		return "user/user_join";
	}
	
	//test 호출
	@RequestMapping(value = "/emp", method=RequestMethod.GET)
	public ModelAndView emp(){
		List<DepartmentVO> dlist = service.getDepartmentList();
		
		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		
		try {
			json = mapper.writeValueAsString(dlist);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("dlist", json);
		mav.setViewName("emp");
		return mav;
	}
}
