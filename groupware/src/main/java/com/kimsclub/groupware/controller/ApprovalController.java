package com.kimsclub.groupware.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kimsclub.groupware.service.ApprovalService;
import com.kimsclub.groupware.vo.BoardPageVO;
import com.kimsclub.groupware.vo.FormVO;

@Controller
public class ApprovalController {
	@Autowired
	ApprovalService service;

	//양식 관리 페이지 호출
		@RequestMapping(value = "/approval", method=RequestMethod.GET)
		public ModelAndView approval(){
			System.out.println("approval() 메소드 호출");
			
			ModelAndView mav = new ModelAndView();
			mav.setViewName("approval/approval");
			
			return mav;
		}
}
