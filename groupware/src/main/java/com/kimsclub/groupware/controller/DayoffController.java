package com.kimsclub.groupware.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kimsclub.groupware.service.ApprovalService;
import com.kimsclub.groupware.service.DayoffService;
import com.kimsclub.groupware.vo.DayoffCreateRecodeVO;
import com.kimsclub.groupware.vo.DayoffCreateTermsVO;
import com.kimsclub.groupware.vo.DayoffKindsVO;
import com.kimsclub.groupware.vo.EmployeeVO;

@Controller
@RequestMapping(value = "/dayoff/*")
public class DayoffController {
	
	@Autowired
	DayoffService service;
	
	@Autowired
	ApprovalService service2;

	/**
	 *
	 * @return 휴가신청 view
	 */
	@RequestMapping(value = "/dayoffWriteform", method = RequestMethod.GET)
	public ModelAndView applyDayoff() {
		System.out.println("write_dayoff() 메소드 호출");
		List<DayoffKindsVO> kindsList = service.getDayoffKinds();
		List<EmployeeVO> elist = service2.loadAllEmp();
		
		
		ObjectMapper mapper = new ObjectMapper();
		String json = null;
	
		try {
			json = mapper.writeValueAsString(elist);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		ModelAndView mov = new ModelAndView();
		mov.setViewName("dayoff/dayoff_writeform");
		mov.addObject("elist", json);
		mov.addObject("dayoffKindList",kindsList);
		return mov;
	}

	
	/**
	 * 
	 * @return view : 휴가현황(dayoff_status) model : 휴가생성 내역(DayoffCreateRecode) 
	 */
	@RequestMapping(value = "/dayoffStatus", method = RequestMethod.GET)
	public ModelAndView readDayoffStatus() {
		
		//세션이 없어서 임시로 1번사원으로 실험
		EmployeeVO tmpEmp = new EmployeeVO();
		tmpEmp.setEmployee_no(1);
		
		
		ModelAndView mov = new ModelAndView();
		
		List<DayoffCreateRecodeVO> createList = service.getMyCreateRecode(tmpEmp);
		mov.addObject("createList",createList);
		mov.setViewName("dayoff/dayoff_status");
		
		return mov;
	}

	/**
	 * 관리자 기능
	 * @return
	 */
	@RequestMapping(value = "/dayoffSetting", method = RequestMethod.GET)
	public String readDayoffSetting(Model model) {
		List<DayoffCreateTermsVO> createTermsList = service.getDayoffCreateTerms();
		model.addAttribute("DayoffCreateTerms",createTermsList);
		List<DayoffKindsVO> kindsList = service.getDayoffKinds();
		model.addAttribute("DayoffKinds",kindsList);
		return "dayoff/dayoff_setting";
	}
	
	
	@RequestMapping(value = "/dayoffSetting", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> setDayoffSetting(@RequestBody List<DayoffCreateTermsVO> list, Model model){
		service.modifyDayoffCreateTerms(list);
		Map<String,String> map = new HashMap<String, String>();
		map.put("result", "1");
		return map; 
	}
	
	@RequestMapping(value = "/createDayoffKinds", method = RequestMethod.POST)
	public String createDayoffKinds(DayoffKindsVO vo){
		System.out.println(vo);
		service.createDayoffkinds(vo);
		return "redirect:/dayoff/dayoffSetting"; 
	}
	

	
	@RequestMapping(value = "/dayoffCreation", method = RequestMethod.GET)
	public String dayoffCreateView(Model model){
		List<DayoffCreateTermsVO> createTermsList = service.getDayoffCreateTerms();
		model.addAttribute("DayoffCreateTerms",createTermsList);
		return "dayoff/dayoff_creation"; 
	}
	
	@RequestMapping(value = "/createDayoff", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> createDayoffTotalEmployee(EmployeeVO vo) {
		
		//세션정보가없어서 임시로 ajax로 보낸 데이터로 해당 관리자로 사용
		System.out.println(vo.getEmployee_no());
		
		
		Map<String,String> map = new HashMap<String, String>();
		try {			
			service.createDayoffTotalEmployee(vo);
			map.put("result", "1");
		}catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	

	
	
}
