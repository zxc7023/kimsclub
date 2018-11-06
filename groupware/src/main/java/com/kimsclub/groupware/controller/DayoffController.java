package com.kimsclub.groupware.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import com.kimsclub.groupware.vo.DayoffApplyVO;
import com.kimsclub.groupware.vo.DayoffCreateRecodeVO;
import com.kimsclub.groupware.vo.DayoffCreateTermsVO;
import com.kimsclub.groupware.vo.DayoffKindsVO;
import com.kimsclub.groupware.vo.DayoffMyRecodeVO;
import com.kimsclub.groupware.vo.EmployeeVO;

@Controller
@RequestMapping(value = "/dayoff/*")
public class DayoffController {
	
	@Autowired
	DayoffService service;
	
	@Autowired
	ApprovalService service2;

	/**
	 * 휴가신청 메뉴를 눌렀을때 요청할 url에 maaping되는 메소드
	 * 휴가신청에서 필요한 정보 : 휴가정보(총,사용,잔여) , 휴가 종류, 
	 * @return 휴가신청 view
	 */
	@RequestMapping(value = "/dayoffWriteform", method = RequestMethod.GET)
	public ModelAndView applyDayoffForm(HttpSession session) {
		System.out.println("/dayoffWriteform + GET 요청");
		
		//세션값에서 가져옴.
		EmployeeVO vo =  (EmployeeVO) session.getAttribute("loginInfo");
		
		//휴가 종류를 받아옴
		List<DayoffKindsVO> kindsList = service.getDayoffKinds();
		
		//내 서비스에서 dao를 호출하는걸로 변경할 예정
		List<EmployeeVO> elist = service2.loadAllEmp();
		
		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		try {
			json = mapper.writeValueAsString(elist);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		//나의 생성된 휴가 , 사용된 휴가 내역을 구하여 계산하는 부분
		
		//나의 생성된 휴가를 받아온다.
		DayoffMyRecodeVO myDayoff = service.readMyDayoffDays(vo);
		
		//내가 사용한 휴가내역을 받아온다.
		List<DayoffApplyVO> myUseDayoffList = service.readUseMyDayoff(vo);
		int useRegular = 0;
		int useReward = 0;
		
		
		
		for(DayoffApplyVO applyVO : myUseDayoffList) {
			if(applyVO.getDayoff_kind().getDayoff_type_code()==2) {
				useReward += applyVO.getTotal_days();
			}else {
				useRegular += applyVO.getTotal_days();
			}
		}
		
		
	
		
		ModelAndView mov = new ModelAndView();
		mov.setViewName("dayoff/dayoff_writeform");
		mov.addObject("userReward",useReward);
		mov.addObject("useRegular",useRegular);
		mov.addObject("elist", json);
		mov.addObject("myDayoff",myDayoff);
		mov.addObject("dayoffKindList",kindsList);
		return mov;
	}
	
	
	@RequestMapping(value = "/dayoffWriteform", method = RequestMethod.POST)
	public String applyDayoff(HttpSession session, @RequestBody DayoffApplyVO vo) {
		System.out.println(vo);
		return null;
	}
	
	/**
	 * 
	 * @return view : 휴가현황(dayoff_status) model : 휴가생성 내역(DayoffCreateRecode) 
	 */
	@RequestMapping(value = "/dayoffStatus", method = RequestMethod.GET)
	public ModelAndView readDayoffStatus(HttpSession session) {
		EmployeeVO vo = (EmployeeVO) session.getAttribute("loginInfo");
		ModelAndView mov = new ModelAndView();
		
		//나의 생성된 휴가 , 사용된 휴가 내역을 구하여 계산하는 부분
		
		
		//나의 생성된 휴가를 받아온다.
		DayoffMyRecodeVO myDayoff = service.readMyDayoffDays(vo);
		
		//내가 사용한 휴가내역을 받아온다.
		List<DayoffApplyVO> myUseDayoffList = service.readUseMyDayoff(vo);
		int useRegular = 0;
		int useReward = 0;
		
		
		
		for(DayoffApplyVO applyVO : myUseDayoffList) {
			if(applyVO.getDayoff_kind().getDayoff_type_code()==2) {
				useReward += applyVO.getTotal_days();
			}else {
				useRegular += applyVO.getTotal_days();
			}
		}
		mov.addObject("myDayoff",myDayoff);
		mov.addObject("userReward",useReward);
		mov.addObject("useRegular",useRegular);
		
		
		
		List<DayoffCreateRecodeVO> createList = service.getMyCreateRecode(vo);
		mov.addObject("createList",createList);
		mov.setViewName("dayoff/dayoff_status");
		
		return mov;
	}

	/**
	 * 
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
	
	/**
	 * 
	 * @param list
	 * @param model
	 * @return
	 */
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
	public Map<String, String> createDayoffTotalEmployee(HttpSession session) {
		EmployeeVO vo =  (EmployeeVO) session.getAttribute("loginInfo");
		
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
