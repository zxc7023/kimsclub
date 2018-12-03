package com.kimsclub.groupware.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kimsclub.groupware.service.EmployeeService;
import com.kimsclub.groupware.service.WorkService;
import com.kimsclub.groupware.vo.EmployeeVO;
import com.kimsclub.groupware.vo.WorkRecodeVO;
import com.kimsclub.groupware.vo.WorkhourSettingVO;

@Controller
@RequestMapping(value = "/work/*")
public class WorkController {

	@Autowired
	WorkService workService;
	
	@Autowired
	EmployeeService employeeService;
	
	/**
	 * 근태 현황을 눌렀을 때의 해당하는 url에 매핑된 메소드
	 * @return view를 반환
	 */
	@RequestMapping(value="/workStatus", method=RequestMethod.GET)
	public ModelAndView workStatus() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("work/work_status");
		return mav;
	}
	
	
	/**
	 * AJAX로 나의 연차를 요청하는 URL을 처리하는 메소드
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/getInitalData", method=RequestMethod.GET)
	@ResponseBody
	public String getMyHiredate(HttpSession session) {
		EmployeeVO loginVO = (EmployeeVO)session.getAttribute("loginInfo");
		
		//1. 나의 회사 입사연도 일자를 가져온다.
		//입사연도를 기준으로 view에서 select option에 보여주기 위해서 필요.
		EmployeeVO empVo = employeeService.getEmployeeHiredate(loginVO);
		
		//2. 출퇴근 시간을 가져온다.
		//출퇴근 데이터를 가지고 비교하기 위해 필요.
		WorkhourSettingVO woVo = workService.getWorkhourSetting();
		
		
		Map<String, Object> map = new HashMap<>();
		map.put("hiredate", empVo.getHiredate());
		map.put("workhour", woVo);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = null;

		try {
			DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			mapper.setDateFormat(fmt);
			json = mapper.writeValueAsString(map);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return json;
	}
	
	/**
	 * 나의 근태기록을 년-월 기준으로 가져온다.
	 * @param session
	 * @param serchTime 조회하고자하는 연-월이 저장된 객체
	 * @return
	 */
	@RequestMapping(value="/getMyWorkRecode", method=RequestMethod.POST, produces="text/html;charset=UTF-8")
	@ResponseBody
	public String getMyWorkRecode(HttpSession session, @RequestBody Date serchTime) {
		EmployeeVO loginVO = (EmployeeVO)session.getAttribute("loginInfo");
		
		//나의 해당하는 정보를 가져오기위해 세션에 저장된 객체를 가져온다.
		EmployeeVO empVo = employeeService.getEmployeeHiredate(loginVO);
		
		//받아온 날짜를 Cal객체로만듬
		Calendar searchCal = Calendar.getInstance();
		searchCal.setTime(serchTime);
		
		//mybatis에서 해당하는값으로 만들데이터 변환
		Calendar startTime = Calendar.getInstance();
		Calendar endTime = Calendar.getInstance();		
		startTime.set(searchCal.get(searchCal.YEAR), searchCal.get(searchCal.MONTH), 1);
		
		//현재년도의 현재달인경우 오늘날자룰 마지막일로 설정, 아닌경우 해당하는 달의 마지막일까지 설정
		Date sysdate = new Date();
		Calendar syscal = Calendar.getInstance();
		syscal.setTime(sysdate);
		
		
		if((syscal.get(Calendar.YEAR) == startTime.get(Calendar.YEAR)) && (syscal.get(Calendar.MONTH) == startTime.get(Calendar.MONTH)) ) {
			endTime.set(searchCal.get(searchCal.YEAR), searchCal.get(searchCal.MONTH),searchCal.get(searchCal.DATE));
		}else {
			endTime.set(searchCal.get(searchCal.YEAR), searchCal.get(searchCal.MONTH),searchCal.getActualMaximum(Calendar.DAY_OF_MONTH));			
		}
		
		

		//mybatis 검색조건값 map에 넣음
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Map<String, Object> map = new HashMap<>();
		map.put("startTime", sdf.format(startTime.getTime()));
		map.put("endTime", sdf.format(endTime.getTime()));
		map.put("employee_no", loginVO.getEmployee_no());
		List<WorkRecodeVO> workRecodeList = workService.getMyWorkRecode(map);
		
		
		//리턴값 세팅
		ObjectMapper mapper = new ObjectMapper();
		String json = null;

		try {
			DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			mapper.setDateFormat(fmt);
			json = mapper.writeValueAsString(workRecodeList);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return json;
	}
	
	
	
	
	@RequestMapping(value="/workSetting", method=RequestMethod.GET)
	public ModelAndView workSetting(HttpSession session) {
		EmployeeVO vo = (EmployeeVO)session.getAttribute("loginInfo");
		
	/*	List<WorkRecodeVO> wlist = service.getWorkRecodes(vo);*/
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("work/work_setting");
		return mav;
	}
	
	
/*	@RequestMapping(value="/getWorkSetting",method=RequestMethod.POST)
	@ResponseBody
	public String getWorkSetting() {
		System.out.println("여기옴");
		
		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		
		WorkdaySettingVO sVo = workRecodeService.getWorkSetting();
		
		try {
			json = mapper.writeValueAsString(sVo);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return json;
	}*/
	
}
