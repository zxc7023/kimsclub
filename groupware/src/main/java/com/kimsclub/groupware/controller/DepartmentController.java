package com.kimsclub.groupware.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kimsclub.groupware.service.DepartmentService;
import com.kimsclub.groupware.vo.DepartmentVO;

@Controller
public class DepartmentController {
	
	@Autowired
	DepartmentService service;
	
	@RequestMapping(value = "/department", method=RequestMethod.GET)
	public ModelAndView department_list(){
		System.out.println("department_list() 메소드 호출");
		
		ModelAndView mav = new ModelAndView();
		List<DepartmentVO> dlist = service.getDepartmentList();
		int[] size = service.getMaxSize();
		System.out.println();
		mav.addObject("dlist",dlist);
		mav.addObject("max_level",size[0]);
		mav.addObject("max_leaf",size[1]);
		mav.setViewName("department/department");
		return mav;
	}
}
