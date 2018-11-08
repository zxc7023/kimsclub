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
import com.kimsclub.groupware.service.EmployeeService;
import com.kimsclub.groupware.service.FormService;
import com.kimsclub.groupware.vo.ApprovalVO;
import com.kimsclub.groupware.vo.BoardPageVO;
import com.kimsclub.groupware.vo.DocumentVO;
import com.kimsclub.groupware.vo.EmployeeVO;
import com.kimsclub.groupware.vo.FormVO;

@Controller
public class DocumentController {
	@Autowired
	ApprovalService service;
	@Autowired
	DocumentService service2;
	@Autowired
	FormService service3;
	
	/**
	 *  선택한 문서의 제목, 내용을 수정함
	 *  view : 문서 수정 페이지(modifyNewDoc) model : flist-활성화된 양식 목록 양식 불러올 때 사용 dvo-수정 할 문서의 정보
	 */
	@RequestMapping(value = "/modifyNewDoc", method=RequestMethod.GET)
	public ModelAndView approvalDocModify(@RequestParam(name="document_no",defaultValue="1") int document_no){
		ModelAndView mav = new ModelAndView();
		
		List<FormVO> flist = service3.getUsedFormList();
		
		mav.addObject("flist", flist);
		
		DocumentVO dvo = service2.viewNewDoc(document_no);
		mav.addObject("dvo", dvo);
		mav.setViewName("document/modifyNewDoc");
		return mav;
	}
	
	@RequestMapping(value = "/approvalDocModify", method=RequestMethod.POST)
	@ResponseBody
	public String approvalDocModifyResult(HttpSession session,@RequestBody DocumentVO dvo){
		System.out.println("approvalDocModify() 메소드 호출");
		dvo.setEmployee(dvo.getApproval().get(0).getEmployee());
		service.modifyDocument(dvo);
		
		String result = "approval/approvalNewDoc";
		return result;
	}
	
	/**
	 *  새 문서함 기안 전 작성한 문서 목록 문서를 선택해 기안, 삭제, 수정 할 수 있다.
	 *  view : 새문서함(newDocList) 
	 */
	@RequestMapping(value = "/newDocList", method=RequestMethod.GET)
	public ModelAndView newDocList(@RequestParam(name="page_scale", defaultValue="10") int page_scale,
			@RequestParam(name="searchOption", defaultValue="")String[] search_option,					  
			@RequestParam(name="keyword", defaultValue="") String keyword,
			@RequestParam(name="cur_page",defaultValue="1") int cur_page,HttpSession session){
		System.out.println("newDocList() 메소드 호출");
		EmployeeVO evo = (EmployeeVO) session.getAttribute("loginInfo");
		
		//map에 페이지에 필요한 리스트를 불러오기 위한 파라미터들 입력
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("fromOption", "document");
		map.put("searchOption", search_option);
		map.put("keyword", keyword);
		map.put("order", "document_no");
		//기안자가 자신이고 임시저장상태인 문서들의 목록
		map.put("whereOption", "document_writer_no = "+evo.getEmployee_no()+"and document_state = 0");
		//내용 제외- 문서 목록에서는 내용을 보여줄 필요없음
		map.put("selectOption", "B.document_no, B.document_title, B.document_date");
		//페이징
		BoardPageVO bpvo = new BoardPageVO(service2.getDocumentCnt(map), cur_page, page_scale); 
		map.put("start", bpvo.getPageBegin());
		map.put("end", bpvo.getPageEnd());
		
		//map을 통해 해당하는 리스트 불러오기
		List<DocumentVO> dlist = service2.getDocumentList(map);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("map",map);
		mav.addObject("dlist",dlist);
		mav.addObject("page",bpvo);
		mav.setViewName("document/newDocList");
		
		return mav;
	}
	
	/**
	 *  결재 문서 작성
	 * @return view : 문서 작성 페이지(writeDoc) model:  결재선에 추가할 사원정보(EmployeeVO), 활성화된 양식 정보(FormVO)
	 */
	@RequestMapping(value = "/writeDoc", method=RequestMethod.GET)
	public ModelAndView writeDoc(){
		System.out.println("writeDoc() 메소드 호출");
		List<FormVO> flist = service3.getUsedFormList();
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
		mav.setViewName("document/writeDoc");
		return mav;
	}
	
	/**
	 *  새 문서 작성 dvo.document_state에 따라 임시저장 문서인지 바로 기안하는 문서인지 구분
	 * @return view : 새 문서함(newDocList)
	 */	
	@RequestMapping(value = "/newDocList", method=RequestMethod.POST)
	@ResponseBody
	public String approvalSaveDoc(HttpSession session,@RequestBody DocumentVO dvo){
		System.out.println("approvalSaveDoc() 메소드 호출");
		EmployeeVO evo = (EmployeeVO)session.getAttribute("loginInfo");
		dvo.setEmployee(evo);
		service2.saveDocument(dvo);
		String result = "/groupware/newDocList";
		return result;
	}
	
	/**
	 *  임시저장된 문서 선택해서 보기
	 * @return view : 임시저장된 문서(viewNewDoc.jsp)
	 */	
	@RequestMapping(value = "/viewNewDoc", method=RequestMethod.GET)
	public ModelAndView viewNewDoc(@RequestParam(name="document_no")int document_no){
		System.out.println("viewNewDoc() 메소드 호출");
		
		ModelAndView mav = new ModelAndView();
		
		DocumentVO dvo = service2.viewNewDoc(document_no);
		
		mav.addObject("dvo", dvo);
		System.out.println("값 출력:");
		System.out.println(dvo.getApproval());
		for(ApprovalVO avo: dvo.getApproval()) {
			System.out.println(avo);
		}
		mav.setViewName("document/viewNewDoc");
		return mav;
	}
}
