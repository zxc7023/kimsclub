package com.kimsclub.groupware.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kimsclub.groupware.service.MessageService;
import com.kimsclub.groupware.vo.EmployeeVO;

@Controller
public class HomeController {
	@Autowired 
	MessageService msgservice; 
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String,Object>();
		EmployeeVO evo = (EmployeeVO) session.getAttribute("loginInfo");
		int employee_no = evo.getEmployee_no();
		
	//안읽은 쪽지 확인 서비스	
		int unReadMsgCnt = msgservice.unReadMessage(employee_no);
	//결재 문서 서비스
		
	//-------//	

	//-------//
		
		map.put("unReadMsgCnt", unReadMsgCnt);//받은쪽지중 읽지 않은 쪽지 갯수
		mav.addObject("map", map);
		mav.setViewName("index");
		
		return mav;
	}

}
