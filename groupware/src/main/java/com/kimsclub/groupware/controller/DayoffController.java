package com.kimsclub.groupware.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.ResultMap;
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
import com.fasterxml.jackson.databind.SerializationFeature;
import com.kimsclub.groupware.service.ApprovalService;
import com.kimsclub.groupware.service.DayoffService;
import com.kimsclub.groupware.vo.DayoffApplyVO;
import com.kimsclub.groupware.vo.DayoffCreateRecodeVO;
import com.kimsclub.groupware.vo.DayoffCreateTermsVO;
import com.kimsclub.groupware.vo.DayoffKindsVO;
import com.kimsclub.groupware.vo.DayoffMyRecodeVO;
import com.kimsclub.groupware.vo.DocumentVO;
import com.kimsclub.groupware.vo.EmployeeVO;

@Controller
@RequestMapping(value = "/dayoff/*")
public class DayoffController {

	@Autowired
	DayoffService service;

	@Autowired
	ApprovalService service2;

	/**
	 * 휴가신청 메뉴를 눌렀을때 요청할 url에 maaping되는 메소드 휴가신청에서 필요한 정보 : 휴가정보(총,사용,잔여) , 휴가 종류,
	 * 
	 * @return 휴가신청 view
	 */
	@RequestMapping(value = "/dayoffWriteform", method = RequestMethod.GET)
	public ModelAndView applyDayoffForm(HttpSession session) {
		System.out.println("/dayoffWriteform + GET 요청");

		// 세션값에서 가져옴.
		EmployeeVO vo = (EmployeeVO) session.getAttribute("loginInfo");

		// 휴가 종류를 받아옴
		List<DayoffKindsVO> kindsList = service.getDayoffKinds();

		// 내 서비스에서 dao를 호출하는걸로 변경할 예정
		List<EmployeeVO> elist = service2.loadAllEmp();

		ObjectMapper mapper = new ObjectMapper();
		String json = null;

		try {
			json = mapper.writeValueAsString(elist);

		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// 나의 생성된 휴가 , 사용된 휴가 내역을 구하여 계산하는 부분

		// 나의 생성된 휴가를 받아온다.
		DayoffMyRecodeVO myDayoff = service.readMyDayoffDays(vo);

		// 내가 사용한 휴가내역을 받아온다.
		List<DayoffApplyVO> myUseDayoffList = service.readUseMyDayoff(vo);
		int useRegular = 0;
		int useReward = 0;

		for (DayoffApplyVO applyVO : myUseDayoffList) {
			if (applyVO.getDayoff_kind().getDayoff_type_code() == 2) {
				useReward += applyVO.getTotal_days();
			} else {
				useRegular += applyVO.getTotal_days();
			}
		}

		ModelAndView mov = new ModelAndView();
		mov.setViewName("dayoff/dayoff_writeform");
		mov.addObject("useReward", useReward);
		mov.addObject("useRegular", useRegular);
		mov.addObject("elist", json);
		mov.addObject("myDayoff", myDayoff);
		mov.addObject("dayoffKindList", kindsList);
		return mov;
	}

	@RequestMapping(value = "/dayoffWriteform", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> applyDayoff(HttpSession session, @RequestBody DayoffApplyVO vo) {

		Map<String, Object> resultMap = new HashMap<>();
		
		EmployeeVO empVo = (EmployeeVO) session.getAttribute("loginInfo");
		vo.getDocument().setEmployee(empVo);
		System.out.println(vo);
		try {
			service.applyDayoff(vo);
			resultMap.put("result",1);
		}catch (Exception e) {
			e.printStackTrace();
		}

		return resultMap;
	}

	@RequestMapping(value = "/checkWhatDate", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Integer> compareSelectDayToUseDate(@RequestBody List<String> selectDateList, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		EmployeeVO empVo = (EmployeeVO) session.getAttribute("loginInfo");

		map.put("employee", empVo);
		map.put("dateList", selectDateList);
		int result = service.selectUseDate(map);
		System.out.println("해당날짜들의 휴가 갯수 : " + result);
		Map<String, Integer> resultMap = new HashMap<>();
		if (result > 0) {
			resultMap.put("result", 0);
		} else {
			resultMap.put("result", 1);
		}
		return resultMap;
	}

	/**
	 * 
	 * @return view : 휴가현황(dayoff_status) model : 휴가생성 내역(DayoffCreateRecode)
	 */
	@RequestMapping(value = "/dayoffStatus", method = RequestMethod.GET)
	public ModelAndView readDayoffStatus(HttpSession session) {
		EmployeeVO vo = (EmployeeVO) session.getAttribute("loginInfo");
		ModelAndView mov = new ModelAndView();

		// 나의 생성된 휴가 , 사용된 휴가 내역을 구하여 계산하는 부분

		// 나의 생성된 휴가를 받아온다.
		DayoffMyRecodeVO myDayoff = service.readMyDayoffDays(vo);

		// 내가 사용한 휴가내역을 받아온다.
		List<DayoffApplyVO> myUseDayoffList = service.readUseMyDayoff(vo);
		double useRegular = 0.0;
		double useReward = 0.0;

		for (DayoffApplyVO applyVO : myUseDayoffList) {
			if (applyVO.getDayoff_kind().getDayoff_type_code() == 2) {
				useReward += applyVO.getTotal_days();
			} else {
				useRegular += applyVO.getTotal_days();
			}
		}
		mov.addObject("myDayoff", myDayoff);
		mov.addObject("useReward", useReward);
		mov.addObject("useRegular", useRegular);

		List<DayoffCreateRecodeVO> createList = service.getMyCreateRecode(vo);
		mov.addObject("createList", createList);
		
		
		
		//내가 신청한 휴가의 리스틀 보여주기위해서 사용
		List<DayoffApplyVO> applyList = service.selectApplyList(vo);
		System.out.println(applyList);
		mov.addObject("applyList",applyList);
		
		
		// 휴가 종류를 받아옴
		List<DayoffKindsVO> kindsList = service.getDayoffKinds();
		mov.addObject("kindsList",kindsList);
		
		
		
		
		
		mov.setViewName("dayoff/dayoff_status");
		return mov;
	}
	
	@RequestMapping(value="/dayoffApplyList", method=RequestMethod.POST ,produces="text/html;charset=UTF-8")
	@ResponseBody
	public String dayoffApplyList(@RequestBody DayoffApplyVO vo, HttpSession session) {
		
		System.out.println(vo);
		vo.setEmployee((EmployeeVO)session.getAttribute("loginInfo"));
		List<DayoffApplyVO> applyList =  service.selectApplyListWithCriteria(vo);
		
		String json = null;
		
		ObjectMapper mapper = new ObjectMapper();
		
		try {
			DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			mapper.setDateFormat(fmt);
			json =mapper.writeValueAsString(applyList);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println(json);
		return json;
	}
	
	@RequestMapping(value="/dayoffApplyDetailList", method=RequestMethod.POST ,produces="text/html;charset=UTF-8")
	@ResponseBody
	public String dayoffApplyDetailList(@RequestBody DayoffApplyVO vo) {
		DayoffApplyVO applyVO = service.dayoffApplyDetailList(vo);
		ObjectMapper mapper = new ObjectMapper();
		String json=null;
		try {
			DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			mapper.setDateFormat(fmt);
			json =mapper.writeValueAsString(applyVO);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(json);
		return json;
	}
	
	
	@RequestMapping(value="/dayoffCal",method=RequestMethod.POST, produces="text/html;charset=UTF-8")
	@ResponseBody
	public String dayoffCal(@RequestBody Map<String, Object> map) {
		System.out.println("호출");
		System.out.println(map.get("year") +"/"+map.get("month"));
		List<DayoffApplyVO> list = service.getDayoffEvent(map);
		System.out.println(list);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		try {
			DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			mapper.setDateFormat(fmt);
			json =mapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return json;
	}
	

	/*@RequestMapping(value = "/dayoff_status_tap01", method = RequestMethod.GET)
	@ResponseBody
	public String dayoff_status_tap01(HttpSession session) {
		Map<String, Object> resultMap = new HashMap<>();
		EmployeeVO vo = (EmployeeVO) session.getAttribute("loginInfo");
		// 나의 생성된 휴가 , 사용된 휴가 내역을 구하여 계산하는 부분

		// 나의 생성된 휴가를 받아온다.
		DayoffMyRecodeVO myDayoff = service.readMyDayoffDays(vo);
		// 내가 사용한 휴가내역을 받아온다.
		List<DayoffApplyVO> myUseDayoffList = service.readUseMyDayoff(vo);
		int useRegular = 0;
		int useReward = 0;
		for (DayoffApplyVO applyVO : myUseDayoffList) {
			if (applyVO.getDayoff_kind().getDayoff_type_code() == 2) {
				useReward += applyVO.getTotal_days();
			} else {
				useRegular += applyVO.getTotal_days();
			}
		}
		resultMap.put("myDayoff", myDayoff);
		resultMap.put("useReward", useReward);
		resultMap.put("useRegular", useRegular);
		
		List<DayoffCreateRecodeVO> createList = service.getMyCreateRecode(vo);
		for(DayoffCreateRecodeVO vo3  :createList) {
			System.out.println(vo3.getGeneration_date());
		}
		resultMap.put("createList", createList);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = null;

		try {
			DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			mapper.setDateFormat(fmt);
			json = mapper.writeValueAsString(resultMap);
		}catch (Exception e) {
			e.getStackTrace();
		}
		System.out.println(json);
		
		System.out.println(json);
		return json;
	}*/

	/**
	 * 
	 * @return
	 */
	@RequestMapping(value = "/dayoffSetting", method = RequestMethod.GET)
	public String readDayoffSetting(Model model) {
		List<DayoffCreateTermsVO> createTermsList = service.getDayoffCreateTerms();
		model.addAttribute("DayoffCreateTerms", createTermsList);
		List<DayoffKindsVO> kindsList = service.getDayoffKinds();
		model.addAttribute("DayoffKinds", kindsList);
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
	public Map<String, String> setDayoffSetting(@RequestBody List<DayoffCreateTermsVO> list, Model model) {
		service.modifyDayoffCreateTerms(list);
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", "1");
		return map;
	}

	@RequestMapping(value = "/createDayoffKinds", method = RequestMethod.POST)
	public String createDayoffKinds(DayoffKindsVO vo) {
		System.out.println(vo);
		service.createDayoffkinds(vo);
		return "redirect:/dayoff/dayoffSetting";
	}

	@RequestMapping(value = "/dayoffCreation", method = RequestMethod.GET)
	public String dayoffCreateView(Model model) {
		List<DayoffCreateTermsVO> createTermsList = service.getDayoffCreateTerms();
		model.addAttribute("DayoffCreateTerms", createTermsList);
		return "dayoff/dayoff_creation";
	}

	@RequestMapping(value = "/createDayoff", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> createDayoffTotalEmployee(HttpSession session) {
		EmployeeVO vo = (EmployeeVO) session.getAttribute("loginInfo");

		System.out.println(vo.getEmployee_no());

		Map<String, String> map = new HashMap<String, String>();
		try {
			service.createDayoffTotalEmployee(vo);
			map.put("result", "1");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

}
