package com.kimsclub.groupware.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kimsclub.groupware.service.ApprovalService;
import com.kimsclub.groupware.vo.ApprovalLineVO;
import com.kimsclub.groupware.vo.EmployeeVO;
import com.kimsclub.groupware.vo.FormVO;

@Controller
public class ApprovalController {
	@Autowired
	ApprovalService service;

		
	@RequestMapping(value = "/approval", method=RequestMethod.GET)
	public ModelAndView approval(){
		System.out.println("approval() 메소드 호출");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("approval/approval");
		
		return mav;
	}
	
	@RequestMapping(value = "/loadForm", method=RequestMethod.GET , produces = "application/text; charset=utf8")
	@ResponseBody
	public String loadForm(@RequestParam("form_no")int form_no ){
		System.out.println("loadForm() 메소드 호출");
		return service.loadForm(form_no);
	}
	
	@RequestMapping(value = "/writeDoc", method=RequestMethod.GET)
	public ModelAndView writeDoc(@RequestParam(name="employee_no", defaultValue="4")int employee_no){
		System.out.println("writeDoc() 메소드 호출");
		List<FormVO> flist = service.getUseFormlist();
		
		List<ApprovalLineVO> alist = service.loadMyApprovalLine(employee_no);
		List<EmployeeVO> elist = service.loadAllEmp();
		
		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		
		try {
			json = mapper.writeValueAsString(elist);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("elist", json);
		mav.addObject("alist", alist);
		mav.addObject("flist", flist);
		mav.setViewName("approval/writeDoc");
		
		return mav;
	}
	
	@RequestMapping(value = "/approvalNewDoc", method=RequestMethod.GET)
	public ModelAndView approvalNewDoc(){
		System.out.println("approvalnewDoc() 메소드 호출");
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("approval/approvalNewDoc");
		
		return mav;
	}
	
	@RequestMapping(value = "/approvalNewDoc", method=RequestMethod.POST)
	public ModelAndView approvalSaveDoc(@RequestParam(name="employee_no", defaultValue="4")int document_writer_no,
			@RequestParam(name="approval_employee_no")int[] approval_approver_no,
			@RequestParam(name="form_contents")String document_contents,
			@RequestParam(name="document_title")String document_title
			){
		
		System.out.println("approvalSaveDoc() 메소드 호출");
		System.out.println(document_writer_no+":"+document_contents+":"+document_title+":"+approval_approver_no[0]);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("approval/approvalNewDoc");
		
		return mav;
	}
	
	@RequestMapping(value = "/approvalDoc", method=RequestMethod.GET)
	public ModelAndView approvalDoc(){
		System.out.println("approvalDoc() 메소드 호출");
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("approval/approvalDoc");
		
		return mav;
	}
	@RequestMapping(value = "/approvalCompleteDoc", method=RequestMethod.GET)
	public ModelAndView approvalCompleteDoc(){
		System.out.println("approvalCompleteDoc() 메소드 호출");
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("approval/approvalCompleteDoc");
		
		return mav;
	}
	@RequestMapping(value = "/approvalProceedDoc", method=RequestMethod.GET)
	public ModelAndView approvalProceedDoc(){
		System.out.println("approvalProceedDoc() 메소드 호출");
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("approval/approvalProceedDoc");
		
		return mav;
	}
	@RequestMapping(value = "/approvalReturnDoc", method=RequestMethod.GET)
	public ModelAndView approvalReturnDoc(){
		System.out.println("approvalReturnDoc() 메소드 호출");
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("approval/approvalReturnDoc");
		
		return mav;
	}
	
	@RequestMapping(value = "/myApprovalLine", method=RequestMethod.GET)
	@ResponseBody
	public List<ApprovalLineVO> approvalLine(@RequestParam(name="employee_no", defaultValue="4")int employee_no){
		System.out.println("myApprovalLine() 메소드 호출");
		List<ApprovalLineVO> alist = service.loadMyApprovalLine(employee_no);
		return alist;
	}
	
	@RequestMapping(value = "/selectMyApprovalLine",method=RequestMethod.GET)
	@ResponseBody
	public List<ApprovalLineVO> selectMyApprovalLine(@RequestParam(name="approval_path_no", defaultValue="4")int approval_path_no){
		System.out.println("selectMyApprovalLine() 메소드 호출");
		List<ApprovalLineVO> alist = service.selectMyApprovalLine(approval_path_no);
		return alist;
	}
}
