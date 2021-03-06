package com.kimsclub.groupware.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.kimsclub.groupware.service.DocumentService;
import com.kimsclub.groupware.service.FormService;
import com.kimsclub.groupware.vo.ApprovalLineVO;
import com.kimsclub.groupware.vo.ApprovalPathVO;
import com.kimsclub.groupware.vo.ApprovalVO;
import com.kimsclub.groupware.vo.DocumentVO;
import com.kimsclub.groupware.vo.EmployeeVO;

@Controller
public class ApprovalController {
	@Autowired
	ApprovalService service;
	@Autowired
	FormService service2;
	@Autowired
	DocumentService service3;	
		
	
	/**
	 *  선택한 문서를 기안하기 위한 페이지 결재선을 선택 후 기안한다
	 *  view : 결재선 선택 페이지(approvalDoc) model : elist-결재선을 선택할 때 사용 dvo-수정 할 문서의 정보
	 */
	@RequestMapping(value = "/approvalDoc", method=RequestMethod.POST)
	public ModelAndView approvalDoc(@RequestParam("document_no")int document_no){
		System.out.println("approvalDoc() 메소드 호출");
		DocumentVO dvo = service3.viewDoc(document_no);
		ModelAndView mav = new ModelAndView();
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
		mav.addObject("dvo",dvo);
		mav.setViewName("approval/approvalDoc");

		return mav;
	}
	
	/**
	 *  즐겨찾기 추가
	 */
	@RequestMapping(value = "/addFavorite", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> addFavorite(@RequestBody ApprovalPathVO apvo){
		System.out.println("addFavorite() 메소드 호출");
		System.out.println(apvo);
		service.addFavorite(apvo);
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("result", "1");
		
		
		return map;
	}
	
	/**
	 *  선택한 문서를 기안하기 위한 페이지 결재선을 선택 후 기안한다
	 *  view : 결재선 선택 페이지(approvalDoc) model : elist-결재선을 선택할 때 사용 dvo-수정 할 문서의 정보
	 */
	@RequestMapping(value = "/approvalDocResult", method=RequestMethod.POST)
	@ResponseBody
	public String approvalDocResult(@RequestBody DocumentVO dvo){
		System.out.println("approvalDocResult() 메소드 호출");
		for(ApprovalVO avo : dvo.getApproval()) {
			System.out.println(avo);
			System.out.println(dvo.getDocument_no());
			System.out.println(dvo.getDocument_state());
			avo.setDocument(dvo);
		}
		service.approvalNewDoc(dvo);
		return "/groupware/proceedDocList";
	}
	
	
	@RequestMapping(value = "/approvalCompleteDoc", method=RequestMethod.GET)
	public ModelAndView approvalCompleteDoc(){
		System.out.println("approvalCompleteDoc() 메소드 호출");
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("approval/approvalCompleteDoc");
		
		return mav;
	}

	
	@RequestMapping(value = "/myApprovalLine", method=RequestMethod.GET)
	@ResponseBody
	public List<ApprovalLineVO> approvalLine(@RequestParam(name="employee_no")int employee_no){
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
