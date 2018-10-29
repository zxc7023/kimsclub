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
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kimsclub.groupware.service.DepartmentService;
import com.kimsclub.groupware.vo.DepartmentVO;

@Controller
@RequestMapping(value = "/humanResources/*")
public class HumanResourcesController {
	
	
	@Autowired
	DepartmentService service;
	
	@RequestMapping(value = "/department", method=RequestMethod.GET)
	public ModelAndView department_list(){
		System.out.println("department_list 메소드 호출");
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
		mov.addObject("department_json",json);
		mov.setViewName("department/department2");
		return mov;
	}
	
	@RequestMapping(value="/getDepartmentSeq", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Integer> getDepartmentSeq(){
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("department_no", service.getDepartmentSeq());
		return map;
	}
	
	@RequestMapping(value="/addDepartment", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> addDepartment(@RequestBody DepartmentVO vo){
		service.addDepartment(vo);
		Map<String,String> map = new HashMap<String, String>();
		map.put("result", "1");
		return map;
	}
	
	@RequestMapping(value="/modifyDepartmentName", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> modifyDepartmentName(@RequestBody DepartmentVO vo){
		System.out.println(vo);
		service.modifyDepartmentName(vo);
		Map<String,String> map = new HashMap<String, String>();
		map.put("result", "1");
		return map;
	}
	@RequestMapping(value="/removeDepartments", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> removeDepartments(@RequestBody DepartmentVO vo){
		System.out.println("삭제메소드:" + vo);
		service.removeDepartment(vo);
		Map<String,String> map = new HashMap<String, String>();
		map.put("result", "1");
		return map;
	}
	
	
}
