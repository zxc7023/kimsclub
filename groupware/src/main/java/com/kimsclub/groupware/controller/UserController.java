package com.kimsclub.groupware.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class UserController {

	//양식 생성 페이지 호출
	@RequestMapping(value = "/userjoin", method=RequestMethod.GET)
	public String user_join(){
		System.out.println("user_join() 메소드 호출");
		return "user/user_join";
	}
	
}
