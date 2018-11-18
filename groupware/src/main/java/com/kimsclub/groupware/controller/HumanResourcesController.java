package com.kimsclub.groupware.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kimsclub.groupware.service.DepartmentService;
import com.kimsclub.groupware.service.EmployeeService;
import com.kimsclub.groupware.vo.DepartmentVO;
import com.kimsclub.groupware.vo.EmployeeVO;
import com.kimsclub.groupware.vo.TreeVO;

@Controller
@RequestMapping(value = "/humanResources/*")
public class HumanResourcesController {
	
	
	@Autowired
	DepartmentService department_service;
	
	@Autowired
	EmployeeService employee_service;
	
	@RequestMapping(value = "/department", method=RequestMethod.GET)
	public ModelAndView department_list(){
		System.out.println("department_list 메소드 호출");
		List<DepartmentVO> list = department_service.getDepartmentList();
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
	
	
	@RequestMapping(value = "/departmentList", method=RequestMethod.GET, produces="text/html;charset=UTF-8")
	@ResponseBody
	public String departmentList(@RequestParam("load_type")int load_type){
		System.out.println("departmentList 메소드 호출");
		List<TreeVO> tlist = new ArrayList<TreeVO>();
		List<DepartmentVO> dlist = new ArrayList<DepartmentVO>();
		List<EmployeeVO> elist = new ArrayList<EmployeeVO>();
		
		dlist = department_service.getDepartmentList();
		for(DepartmentVO dvo : dlist) {
			tlist.add(new TreeVO(dvo));
		}
		if(load_type == 1){
			elist = employee_service.loadAllEmp();
			for(EmployeeVO evo : elist) {
				tlist.add(new TreeVO(evo));
			}
		}
		String json = null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			json = mapper.writeValueAsString(tlist);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return json;
	}
	
	@RequestMapping(value="/getDepartmentSeq", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Integer> getDepartmentSeq(){
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("department_no", department_service.getDepartmentSeq());
		return map;
	}
	
	@RequestMapping(value="/addDepartment", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> addDepartment(@RequestBody DepartmentVO vo){
		department_service.addDepartment(vo);
		Map<String,String> map = new HashMap<String, String>();
		map.put("result", "1");
		return map;
	}
	
	@RequestMapping(value="/modifyDepartmentName", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> modifyDepartmentName(@RequestBody DepartmentVO vo){
		System.out.println(vo);
		department_service.modifyDepartmentName(vo);
		Map<String,String> map = new HashMap<String, String>();
		map.put("result", "1");
		return map;
	}
	@RequestMapping(value="/removeDepartments", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> removeDepartments(@RequestBody DepartmentVO vo){
		System.out.println("삭제메소드:" + vo);
		department_service.removeDepartment(vo);
		Map<String,String> map = new HashMap<String, String>();
		map.put("result", "1");
		return map;
	}
	
	/**
	 * 사용자 관리를 눌렀을때 해당하는 url에 매핑되는 메소드
	 * @return
	 */
	@RequestMapping(value="/employee", method=RequestMethod.GET)
	public ModelAndView getEmployee() {
		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/employeeManage");
		return mav;
	}
	
	
}
