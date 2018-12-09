package com.kimsclub.groupware.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.kimsclub.groupware.service.DepartmentService;
import com.kimsclub.groupware.service.EmployeeService;
import com.kimsclub.groupware.vo.BoardPageVO;
import com.kimsclub.groupware.vo.DepartmentVO;
import com.kimsclub.groupware.vo.EmployeeVO;
import com.kimsclub.groupware.vo.PageMaker;
import com.kimsclub.groupware.vo.SearchCriteria;
import com.kimsclub.groupware.vo.TreeVO;

import oracle.net.aso.p;


@Controller
@RequestMapping(value = "/humanResources/*")
public class HumanResourcesController {
	
	
	@Autowired
	DepartmentService department_service;
	
	@Autowired
	EmployeeService employee_service;
	
	@RequestMapping(value = "/department", method=RequestMethod.GET)
	public ModelAndView department_list(){
		System.out.println("department_list 메소드 호출");
		List<DepartmentVO> list = department_service.getDepartmentList();
		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		
		try {
			json = mapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(json);
		
		ModelAndView mov = new ModelAndView();
		mov.addObject("department_json",json);
		mov.setViewName("department/department2");
		return mov;
	}
	
	
	@RequestMapping(value = "/departmentList", method=RequestMethod.GET, produces="text/html;charset=UTF-8")
	@ResponseBody
	public String departmentList(@RequestParam("load_type")int load_type){
		System.out.println("departmentList 메소드 호출");
		List<TreeVO> tlist = new ArrayList<TreeVO>();
		List<DepartmentVO> dlist = new ArrayList<DepartmentVO>();
		List<EmployeeVO> elist = new ArrayList<EmployeeVO>();
		
		dlist = department_service.getDepartmentList();
		for(DepartmentVO dvo : dlist) {
			tlist.add(new TreeVO(dvo));
		}
		if(load_type == 1){
			elist = employee_service.loadAllEmp();
			for(EmployeeVO evo : elist) {
				tlist.add(new TreeVO(evo));
			}
		}
		String json = null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			json = mapper.writeValueAsString(tlist);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return json;
	}
	
	@RequestMapping(value="/getDepartmentSeq", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Integer> getDepartmentSeq(){
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("department_no", department_service.getDepartmentSeq());
		return map;
	}
	
	@RequestMapping(value="/addDepartment", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> addDepartment(@RequestBody DepartmentVO vo){
		department_service.addDepartment(vo);
		Map<String,String> map = new HashMap<String, String>();
		map.put("result", "1");
		return map;
	}
	
	@RequestMapping(value="/modifyDepartmentName", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> modifyDepartmentName(@RequestBody DepartmentVO vo){
		System.out.println(vo);
		department_service.modifyDepartmentName(vo);
		Map<String,String> map = new HashMap<String, String>();
		map.put("result", "1");
		return map;
	}
	@RequestMapping(value="/removeDepartments", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> removeDepartments(@RequestBody DepartmentVO vo){
		System.out.println("삭제메소드:" + vo);
		department_service.removeDepartment(vo);
		Map<String,String> map = new HashMap<String, String>();
		map.put("result", "1");
		return map;
	}
	
	/**
	 * 사용자 관리를 눌렀을때 해당하는 url에 매핑되는 메소드
	 * @return
	 */
	@RequestMapping(value="/employee", method=RequestMethod.GET)
	public ModelAndView getEmployee() {
		System.out.println("getEmployee	 메소드 호출");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/employeeManage");
		return mav;
	}
	

	/**
	 * 사용자 추가
	 * @return
	 */
	@RequestMapping(value="/addEmployee", method=RequestMethod.GET)
	public ModelAndView addEmployee() {
		System.out.println("addEmployee 메소드 호출");

		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/addEmployee");
		return mav;
	}
	
	/**
	 * 사용자 추가
	 * @return
	 */
	@RequestMapping(value="/addEmployee", method=RequestMethod.POST)
	@ResponseBody
	public String addEmployeeResult(@RequestBody EmployeeVO evo,HttpSession session) {
		System.out.println("addEmployeeResult 메소드 호출");
		System.out.println(evo);
		employee_service.addEmployee(evo);
		return "employee";
	}
	
	/**
	 * 사용자 수정
	 * @return
	 */
	@RequestMapping(value="/modifyEmployee", method=RequestMethod.GET)
	public ModelAndView modifyEmployee(@RequestParam("employee_no")int employee_no,HttpSession session) {
		System.out.println("modifyEmployee 메소드 호출");
		EmployeeVO evo = (EmployeeVO)session.getAttribute("loginInfo");
		ModelAndView mav = new ModelAndView();
		if(evo.getEmployee_no()==employee_no||employee_no==0) {
			mav.addObject("evo", evo);
			mav.setViewName("user/modifyEmployee");
		}else {
			mav.setViewName("login");
		}
		return mav;
	}

	@RequestMapping(value="/checkChildren", method=RequestMethod.POST)
	@ResponseBody
	public String checkChildren(@RequestBody Map<String,Object> map) {
		String result ="1";
		System.out.println(map);
		DepartmentVO vo = department_service.checkChildren(map);
		if(null == vo) {
			department_service.changeParentDepartment(map);
			System.out.println("변경완료");
			result = "0";
		}else {
			System.out.println("하위경로로 존재");
		}
		return result;
	}
	
	
	/**
	 * 사용자 수정 처리
	 * @return
	 */
	@RequestMapping(value="/modifyEmployee", method=RequestMethod.POST)
	@ResponseBody
	public String modifyEmployeeResult(@RequestBody EmployeeVO evo,HttpSession session) {
		System.out.println("modifyEmployeeResult 메소드 호출");
		System.out.println(evo);
		employee_service.modifyEmployeeResult(evo);
		return "employee";
	}
	
	
	@RequestMapping(value="/departmentList2", method=RequestMethod.GET, produces="text/html;charset=UTF-8")
	@ResponseBody
	public String departmentList2() {
		
		List<TreeVO> tlist = new ArrayList<TreeVO>();
		List<DepartmentVO> dlist = new ArrayList<DepartmentVO>();
		
		dlist = department_service.getDepartmentList();
		System.out.println(dlist);
		
		for(DepartmentVO dvo : dlist) {
			
			tlist.add(new TreeVO(dvo));
		}
		System.out.println(tlist);
		String json = null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			json = mapper.writeValueAsString(dlist);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return json;
	}
	
	/**
	 * 해당하는 기준을 가지고 데이터를 가져온다.
	 * 기본적으로 page는 1, department_no = "모든 사용자" searchType/searchValue = null 이다.
	 * @return
	 */
	@RequestMapping(value = "/getEmpWithCreteria", method=RequestMethod.GET,produces="text/html;charset=UTF-8")
	@ResponseBody
	public String getEmpList(SearchCriteria cri,@RequestParam(required=false, defaultValue="1") String department_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cri", cri);
		map.put("department_no", department_no);
		List<EmployeeVO> empList = employee_service.getEmpListWithCri(map);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalConunt(employee_service.getEmpCntWithCri(map));
		System.out.println(cri);
		System.out.println(empList);
		System.out.println(pageMaker);
		
		String json = null;
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("pageMaker", pageMaker);
		resultMap.put("empList", empList);
		ObjectMapper mapper = new ObjectMapper();
		try {
			DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			mapper.setDateFormat(fmt);
			json = mapper.writeValueAsString(resultMap);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return json;
		
	}
}
