package com.kimsclub.groupware.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kimsclub.groupware.service.FormService;
import com.kimsclub.groupware.vo.FormVO;

@Controller
public class FormController {
	@Autowired
	FormService service;
	
	//양식 관리 페이지 호출
	@RequestMapping(value = "/form", method=RequestMethod.GET)
	public ModelAndView form(){
		System.out.println("form() 메소드 호출");
		ModelAndView mav = new ModelAndView();
		List<FormVO> flist = service.getFormList();
		mav.addObject("FormList",flist);
		mav.setViewName("form/form");
		return mav;
	}
	
	//양식 생성 페이지 호출
	@RequestMapping(value = "/createform", method=RequestMethod.GET)
	public String create_form(){
		System.out.println("create_form() 메소드 호출");
		return "form/formCreate";
	}
	
	//양식 수정 페이지 호출
		@RequestMapping(value = "/modifyform", method=RequestMethod.GET)
		public String modify_form(){
			System.out.println("create_form() 메소드 호출");
			return "form/formModify";
		}
	
	//양식 저장 후 양식관리 페이지 호출
	@RequestMapping(value = "/createform", method=RequestMethod.POST)
	public String save_form(FormVO vo){
		System.out.println("save_form() 메소드 호출");
		
		return "redirect:/form";
	}
	
}
