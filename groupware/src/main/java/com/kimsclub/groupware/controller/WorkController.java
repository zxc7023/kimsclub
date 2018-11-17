package com.kimsclub.groupware.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kimsclub.groupware.service.WorkRecodeService;
import com.kimsclub.groupware.vo.EmployeeVO;
import com.kimsclub.groupware.vo.WorkRecodeVO;

import sun.print.resources.serviceui;

@Controller
@RequestMapping(value = "/work/*")
public class WorkController {

	
	@Autowired
	WorkRecodeService service;
	
	@RequestMapping(value="/workStatus", method=RequestMethod.GET)
	public ModelAndView workStatus(HttpSession session) {
		EmployeeVO vo = (EmployeeVO)session.getAttribute("loginInfo");
		
		List<WorkRecodeVO> wlist = service.getWorkRecodes(vo);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("work/work_status");
		return mav;
	}
	
}
