package com.kimsclub.groupware.controller;

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
import com.kimsclub.groupware.vo.TreeVO;

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
	public ModelAndView getEmployee(@RequestParam(name="page_scale", defaultValue="20") int page_scale,
			@RequestParam(name="searchOption", defaultValue="")String[] search_option,					  
			@RequestParam(name="keyword", defaultValue="") String keyword,
			@RequestParam(name="cur_page",defaultValue="1") int cur_page,HttpSession session,
			@RequestParam(name="whereOption", defaultValue="1=1")String whereOption) {
		System.out.println("getEmployee	 메소드 호출");
		Map<String, Object> map = new HashMap<String,Object>();
		//List<EmployeeVO> elist = employee_service.loadAllEmp();
		
		ModelAndView mav = new ModelAndView();
		map.put("fromOption", "employee e left join department d on e.department_no = d.department_no");
		map.put("searchOption", search_option);
		map.put("keyword", keyword);
		map.put("order", "employee_no");
		map.put("whereOption", whereOption);
		map.put("selectOption", "employee_no,password,hiredate,usertype,email,phonenumber,d.department_name as department_name, d.department_no as department_no, position, employee_name");
		BoardPageVO bpvo = new BoardPageVO(employee_service.getEmployeeCnt(map), cur_page, page_scale); 
		map.put("start", bpvo.getPageBegin());
		map.put("end", bpvo.getPageEnd());
		List<EmployeeVO> elist = employee_service.loadAllEmpList(map);
		System.out.println(elist);
		mav.addObject("map",map);
		mav.addObject("elist", elist);
		mav.addObject("page",bpvo);
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
	
	/**
	 * 사용자 수정 처리
	 * @return
	 */
	@RequestMapping(value="/modifyEmployee", method=RequestMethod.POST)
	public String modifyEmployeeResult(@RequestBody EmployeeVO evo,HttpSession session) {
		System.out.println("modifyEmployeeResult 메소드 호출");
		System.out.println(evo);
		employee_service.modifyEmployeeResult(evo);
		session.invalidate();
		return "redirect:/login";
	}
}
