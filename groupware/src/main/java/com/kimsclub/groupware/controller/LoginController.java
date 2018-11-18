package com.kimsclub.groupware.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kimsclub.groupware.service.EmployeeService;
import com.kimsclub.groupware.vo.EmployeeVO;

@Controller
@SessionAttributes("loginInfo")
public class LoginController {
	
	@Autowired
	EmployeeService service;
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginform() {
		return "login";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String loginresult(EmployeeVO employee, Model model,HttpServletRequest request,HttpSession session) {
		System.out.println(employee.getEmployee_no() + employee.getPassword());
		String returnURL = "";
		
		if(session.getAttribute("loginInfo") != null) {
			session.removeAttribute("loginInfo");
		}
		
		try {
			EmployeeVO resultUser = service.login(employee);
			if(resultUser != null) {
				model.addAttribute("loginInfo",resultUser);
				session.setMaxInactiveInterval(60 * 30);
				System.out.println(resultUser);
				service.updateLastLogin(employee);
				returnURL = "redirect:/";
			}else {
				returnURL = "redirect:/login";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnURL;
	}
	// 로그아웃 하는 부분
    @RequestMapping(value="/logout")
    public String logout(HttpSession session) {
    	System.out.println("로그아웃하러옴");
        session.removeAttribute("loginInfo"); // 하나씩 하려면 이렇게 해도 됨.
        return "redirect:/login";
    }


}
