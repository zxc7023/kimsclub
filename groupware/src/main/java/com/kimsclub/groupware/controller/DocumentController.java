package com.kimsclub.groupware.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

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
import com.kimsclub.groupware.service.ApprovalService;
import com.kimsclub.groupware.vo.ApprovalVO;
import com.kimsclub.groupware.vo.DocumentVO;
import com.kimsclub.groupware.vo.EmployeeVO;
import com.kimsclub.groupware.vo.FormVO;

@Controller
public class DocumentController {
	@Autowired
	ApprovalService service;
	
	@RequestMapping(value = "/approvalDocModify", method=RequestMethod.GET)
	public ModelAndView approvalDocModify(@RequestParam(name="document_no",defaultValue="1") int document_no){
		ModelAndView mav = new ModelAndView();
		
		List<FormVO> flist = service.getUseFormlist();
		List<EmployeeVO> elist = service.loadAllEmp();
		
		//elist를 json형식으로 전달하기위한 설정
		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		try {
			json = mapper.writeValueAsString(elist);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		mav.addObject("elist", json);
		mav.addObject("flist", flist);
		
		DocumentVO dvo = service.viewNewDoc(document_no);
		mav.addObject("dvo", dvo);
		System.out.println("값 출력:");
		System.out.println(dvo.getApproval());
		for(ApprovalVO avo: dvo.getApproval()) {
			System.out.println(avo);
		}
		mav.setViewName("approval/approvalDocModify");
		return mav;
	}
	
	@RequestMapping(value = "/approvalDocModify", method=RequestMethod.POST)
	@ResponseBody
	public String approvalDocModifyResult(HttpSession session,@RequestBody DocumentVO dvo){
		System.out.println("approvalDocModify() 메소드 호출");
		dvo.setEmployee(dvo.getApproval().get(0).getEmployee());
		service.modifyDocument(dvo);
		
		String result = "approval/approvalNewDoc";
		return result;
	}
	
}
