package com.kimsclub.groupware.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kimsclub.groupware.service.DayoffService;
import com.kimsclub.groupware.vo.DayoffCreateConditionVO;

@Controller
@RequestMapping(value = "/dayoff/*")
public class DayoffController {
	
	@Autowired
	DayoffService service;

	@RequestMapping(value = "/dayoffWriteform", method = RequestMethod.GET)
	public String applyDayoff() {
		System.out.println("write_dayoff() 메소드 호출");
		return "dayoff/dayoff_writeform";
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
	public String setDayoff(Model model) {
		List<DayoffCreateConditionVO> conditionList = service.getDayoffCreateCondition();
		
		model.addAttribute("dayoffCreateCondition",conditionList);
		return "dayoff/dayoff_setting";
	}
}
