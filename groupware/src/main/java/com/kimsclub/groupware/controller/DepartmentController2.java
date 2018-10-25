package com.kimsclub.groupware.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kimsclub.groupware.service.DepartmentService;
import com.kimsclub.groupware.vo.DepartmentVO;

@Controller
public class DepartmentController2 {
	
	
	@Autowired
	DepartmentService service;
	
	@RequestMapping(value = "/department2", method=RequestMethod.GET)
	public ModelAndView department_list(){
		System.out.println("department_list2() 메소드 호출");
		
		List<DepartmentVO> list = service.getDepartmentList();
		
		ObjectMapper mapper = new ObjectMapper();
		
		String json = null;
		
		try {
			json = mapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(json);
		
		
		
		

		ModelAndView mov = new ModelAndView();
		mov.addObject("testData",json);
		mov.setViewName("department/department2");
		
		
		
		return mov;
	}
}
