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
import com.kimsclub.groupware.service.ApprovalService;
import com.kimsclub.groupware.vo.ApprovalLineVO;
import com.kimsclub.groupware.vo.ApprovalVO;
import com.kimsclub.groupware.vo.BoardPageVO;
import com.kimsclub.groupware.vo.DocumentVO;
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
	
	/**
	 * Ajax-양식내용
	 * @return String : form_no를 통해 해당하는 양식 내용 가져오기 
	 */
	//produces = "application/text; charset=utf8" - 한글이 깨지기 때문에 charset=utf8로 설정
	@RequestMapping(value = "/loadForm", method=RequestMethod.GET , produces = "application/text; charset=utf8")
	@ResponseBody
	public String loadForm(@RequestParam("form_no")int form_no ){
		System.out.println("loadForm() 메소드 호출");
		return service.loadForm(form_no);
	}
	
	/**
	 *  결재 문서 작성
	 * @return view : 문서 작성 페이지(writeDoc) model:  결재선에 추가할 사원정보(EmployeeVO), 활성화된 양식 정보(FormVO)
	 */
	@RequestMapping(value = "/writeDoc", method=RequestMethod.GET)
	public ModelAndView writeDoc(){
		System.out.println("writeDoc() 메소드 호출");
		List<FormVO> flist = service.getUseFormlist();
		List<EmployeeVO> elist = service.loadAllEmp();
		
		//elist를 json형식으로 전달하기위한 설정
		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		try {
			json = mapper.writeValueAsString(elist);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("elist", json);
		mav.addObject("flist", flist);
		mav.setViewName("approval/writeDoc");
		return mav;
	}
	
	
	@RequestMapping(value = "/approvalNewDoc", method=RequestMethod.GET)
	public ModelAndView approvalNewDoc(@RequestParam(name="page_scale", defaultValue="10") int page_scale,
			@RequestParam(name="searchOption", defaultValue="")String[] search_option,					  
			@RequestParam(name="keyword", defaultValue="") String keyword,
			@RequestParam(name="cur_page",defaultValue="1") int cur_page,HttpSession session){
		System.out.println("approvalnewDoc() 메소드 호출");
		EmployeeVO evo = (EmployeeVO) session.getAttribute("loginInfo");
		
		//map에 페이지에 필요한 리스트를 불러오기 위한 파라미터들 입력
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("fromOption", "document");
		map.put("searchOption", search_option);
		map.put("keyword", keyword);
		map.put("order", "document_no");
		map.put("whereOption", "DOCUMENT_WRITER_NO = "+evo.getEmployee_no()+"and document_state=0");
		//내용 제외
		map.put("selectOption", "B.document_no, B.document_title, B.document_date");
		BoardPageVO bpvo = new BoardPageVO(service.getDocumentNum(map), cur_page, page_scale); 
		map.put("start", bpvo.getPageBegin());
		map.put("end", bpvo.getPageEnd());
		
		//map을 통해 해당하는 리스트 불러오기
		List<DocumentVO> dlist = service.getDocumentList(map);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("dlist",dlist);
		mav.setViewName("approval/approvalNewDoc");
		
		return mav;
	}
	
	@RequestMapping(value = "/approvalNewDoc", method=RequestMethod.POST)
	@ResponseBody
	public String approvalSaveDoc(HttpSession session,@RequestBody DocumentVO dvo){
		System.out.println("approvalSaveDoc() 메소드 호출");
		dvo.setEmployee(dvo.getApproval().get(0).getEmployee());
		service.saveDocument(dvo);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		try {
			json = mapper.writeValueAsString("approval/approvalNewDoc");
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		return json;
	}
	
	
	@RequestMapping(value = "/approvalViewNewDoc", method=RequestMethod.GET)
	public ModelAndView approvalViewNewDoc(@RequestParam(name="document_no")int document_no){
		System.out.println("approvalViewNewDoc() 메소드 호출");
		
		ModelAndView mav = new ModelAndView();
		
		DocumentVO dvo = service.viewNewDoc(document_no);
		
		mav.addObject("dvo", dvo);
		System.out.println("값 출력:");
		System.out.println(dvo.getApproval());
		for(ApprovalVO avo: dvo.getApproval()) {
			System.out.println(avo);
		}
		mav.setViewName("approval/approvalViewNewDoc");
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
