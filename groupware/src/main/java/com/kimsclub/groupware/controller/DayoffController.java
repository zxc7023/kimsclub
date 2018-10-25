package com.kimsclub.groupware.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kimsclub.groupware.service.DayoffService;
import com.kimsclub.groupware.vo.DayoffCreateTermsVO;
import com.kimsclub.groupware.vo.DayoffKindsVO;

@Controller
@RequestMapping(value = "/dayoff/*")
public class DayoffController {
	
	@Autowired
	DayoffService service;

	@RequestMapping(value = "/dayoffWriteform", method = RequestMethod.GET)
	public ModelAndView applyDayoff() {
		System.out.println("write_dayoff() 메소드 호출");
		List<DayoffKindsVO> kindsList = service.getDayoffKinds();
		ModelAndView mov = new ModelAndView();
		mov.setViewName("dayoff/dayoff_writeform");
		mov.addObject("dayoffKindList",kindsList);
		return mov;
	}

	@RequestMapping(value = "/dayoffStatus", method = RequestMethod.GET)
	public String readDayoffStatus() {
		System.out.println("readDayoffStatus() 메소드 호출");
		return "dayoff/dayoff_status";
	}

	/**
	 * 인터셉터 기능을 넣어서 세션정보를 확인후 관리자인 경우에만 접근가능하도록
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
}
