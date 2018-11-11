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
	public ModelAndView approvalDocModify(@RequestParam(name="document_no") int document_no){
		ModelAndView mav = new ModelAndView();
		
		List<FormVO> flist = service3.getUsedFormList();
		
		mav.addObject("flist", flist);
		
		DocumentVO dvo = service2.viewDoc(document_no);
		mav.addObject("dvo", dvo);
		mav.setViewName("document/modifyNewDoc");
		return mav;
	}
	
	/**
	 *  자기자신을 제외한 결재선에 아무도 결재를 안했을 시에 결재를 회수할 수 있다.
	 */
	@RequestMapping(value = "/retrieveDoc", method=RequestMethod.GET)
	public String retrieveDoc(@RequestParam(name="document_no") int document_no){
		System.out.println("retrieveDoc() 메소드 호출");
		service2.retrieveDocument(document_no);
		return "/groupware/newDocList";
	}
	
	/**
	 *  결재 승인
	 */
	@RequestMapping(value = "/approveDoc", method=RequestMethod.GET)
	@ResponseBody
	public String approveDoc(HttpSession session, @RequestParam(name="document_no") int document_no){
		System.out.println("approveDoc() 메소드 호출");
		Map<String, Object> map = new HashMap<String,Object>();
		EmployeeVO evo = (EmployeeVO)session.getAttribute("loginInfo");
		map.put("document_no",document_no);
		map.put("employee_no", evo.getEmployee_no());
		service2.approveDocument(map);
		return "/groupware/approvalDocList";
	}
	
	/**
	 *  선택한 문서의 제목, 내용의 수정 처리
	 *  view : 해당 번호의 문서 정보(viewDoc)
	 */
	@RequestMapping(value = "/modifyDocState", method=RequestMethod.POST)
	@ResponseBody
	public String approvalDocModifyResult(HttpSession session,@RequestBody DocumentVO dvo){
		System.out.println("approvalDocModify() 메소드 호출");
		EmployeeVO evo = (EmployeeVO)session.getAttribute("loginInfo");
		dvo.setEmployee(evo);
		service2.modifyDocument(dvo);
		return "/groupware/viewDoc?document_type=0&document_no="+dvo.getDocument_no();
	}
	
	/**
	 *  해당하는 조건의 문서의 목록을 가져오기 위한 세팅
	 *  doc_type = 0 새 문서함(자신이 작성한 문서중 아직 기안하지 않은 문서의 목록)  - document_writer_no = 자신의 번호 AND document_state = 0 
	 */
	public ModelAndView docSetting(int employee_no,int page_scale, String[] searchOption, String keyword,int cur_page,int doc_type) {
		Map<String, Object> map = new HashMap<String,Object>();
		ModelAndView mav = new ModelAndView();
		map.put("fromOption", "document");
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("order", "document_no");
		if(doc_type==0) {
			map.put("whereOption", "document_writer_no = "+employee_no+" and document_state = '임시저장'");
		}else if (doc_type==1) {
			map.put("whereOption", "document_writer_no = "+employee_no+" and document_state = '진행'");
		}else if (doc_type==3) {
			map.put("whereOption", "document_writer_no = "+employee_no+" and document_state = '반려'");
		}else if (doc_type==4) {
			map.put("whereOption", "document_writer_no = "+employee_no+" and document_state = '완료'");
		}else if (doc_type==2) {
			map.put("whereOption", "document_no = (SELECT document_no FROM approval WHERE approval_state = 1 AND approval_next_no = (SELECT approval_no FROM approval WHERE approval_state=0 and employee_no = "+employee_no+"))");
		}
		
		//내용 제외- 문서 목록에서는 내용을 보여줄 필요없음
		map.put("selectOption", "B.document_no, B.document_title, TO_CHAR(B.document_date, 'yyyy/mm/dd') document_date");
		//페이징
		BoardPageVO bpvo = new BoardPageVO(service2.getDocumentCnt(map), cur_page, page_scale); 
		map.put("start", bpvo.getPageBegin());
		map.put("end", bpvo.getPageEnd());
				
		//map을 통해 해당하는 리스트 불러오기
		List<DocumentVO> dlist = service2.getDocumentList(map);
		mav.addObject("map",map);
		mav.addObject("dlist",dlist);
		mav.addObject("page",bpvo);
		
		return mav;
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
		ModelAndView mav = docSetting(evo.getEmployee_no(), page_scale, search_option, keyword, cur_page,0);
	
		mav.setViewName("document/newDocList");
		
		return mav;
	}
	
	/**
	 *  새 문서함 기안 전 작성한 문서 목록 문서를 선택해 기안, 삭제, 수정 할 수 있다.
	 *  view : 반려문서함(returnDocList) 
	 */
	@RequestMapping(value = "/returnDocList", method=RequestMethod.GET)
	public ModelAndView returnDocList(@RequestParam(name="page_scale", defaultValue="10") int page_scale,
			@RequestParam(name="searchOption", defaultValue="")String[] search_option,					  
			@RequestParam(name="keyword", defaultValue="") String keyword,
			@RequestParam(name="cur_page",defaultValue="1") int cur_page,HttpSession session){
		System.out.println("returnDocList() 메소드 호출");
		EmployeeVO evo = (EmployeeVO) session.getAttribute("loginInfo");
		ModelAndView mav = docSetting(evo.getEmployee_no(), page_scale, search_option, keyword, cur_page,3);
	
		mav.setViewName("document/retrunDocList");
		
		return mav;
	}
	
	/**
	 *  새 문서함 기안 전 작성한 문서 목록 문서를 선택해 기안, 삭제, 수정 할 수 있다.
	 *  view : 완료문서함(proceedDocList) 
	 */
	@RequestMapping(value = "/completeDocList", method=RequestMethod.GET)
	public ModelAndView completeDocList(@RequestParam(name="page_scale", defaultValue="10") int page_scale,
			@RequestParam(name="searchOption", defaultValue="")String[] search_option,					  
			@RequestParam(name="keyword", defaultValue="") String keyword,
			@RequestParam(name="cur_page",defaultValue="1") int cur_page,HttpSession session){
		System.out.println("completeDocList() 메소드 호출");
		EmployeeVO evo = (EmployeeVO) session.getAttribute("loginInfo");
		ModelAndView mav = docSetting(evo.getEmployee_no(), page_scale, search_option, keyword, cur_page,4);
	
		mav.setViewName("document/completeDocList");
		
		return mav;
	}
	
	/**
	 *  새 문서함 기안 전 작성한 문서 목록 문서를 선택해 기안, 삭제, 수정 할 수 있다.
	 *  view : 진행문서함(proceedDocList) 
	 */
	@RequestMapping(value = "/proceedDocList", method=RequestMethod.GET)
	public ModelAndView proceedDocList(@RequestParam(name="page_scale", defaultValue="10") int page_scale,
			@RequestParam(name="searchOption", defaultValue="")String[] search_option,					  
			@RequestParam(name="keyword", defaultValue="") String keyword,
			@RequestParam(name="cur_page",defaultValue="1") int cur_page,HttpSession session){
		System.out.println("proceedDocList() 메소드 호출");
		EmployeeVO evo = (EmployeeVO) session.getAttribute("loginInfo");
		ModelAndView mav = docSetting(evo.getEmployee_no(), page_scale, search_option, keyword, cur_page,1);
	
		mav.setViewName("document/proceedDocList");
		
		return mav;
	}
	
	/**
	 *  새 문서함 기안 전 작성한 문서 목록 문서를 선택해 기안, 삭제, 수정 할 수 있다.
	 *  view : 결재문서함(approvalDocList) 
	 */
	@RequestMapping(value = "/approvalDocList", method=RequestMethod.GET)
	public ModelAndView approvalDocList(@RequestParam(name="page_scale", defaultValue="10") int page_scale,
			@RequestParam(name="searchOption", defaultValue="")String[] search_option,					  
			@RequestParam(name="keyword", defaultValue="") String keyword,
			@RequestParam(name="cur_page",defaultValue="1") int cur_page,HttpSession session){
		System.out.println("approvalDocList() 메소드 호출");
		EmployeeVO evo = (EmployeeVO) session.getAttribute("loginInfo");
		ModelAndView mav = docSetting(evo.getEmployee_no(), page_scale, search_option, keyword, cur_page,2);
	
		mav.setViewName("document/approvalDocList");
		
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
	 * @return view : 임시저장된 문서(viewDoc.jsp)
	 */	
	@RequestMapping(value = "/viewDoc", method=RequestMethod.GET)
	public ModelAndView viewDoc(@RequestParam(name="document_no")int document_no,@RequestParam(name="document_type")int document_type){
		System.out.println("viewDoc() 메소드 호출");
		
		ModelAndView mav = new ModelAndView();
		
		DocumentVO dvo = service2.viewDoc(document_no);
		
		mav.addObject("dvo", dvo);
		System.out.println(document_type);
		if(document_type == 0) {
			System.out.println("임시저장페이지 호출");
			mav.setViewName("document/viewNewDoc");			
		}else if(document_type==1) {
			System.out.println("진행페이지 호출");
			mav.setViewName("document/viewProceedDoc");
		}else if(document_type==3) {
			System.out.println("반려페이지 호출");
			mav.setViewName("document/viewReturnDoc");
		}else if(document_type==2) {
			System.out.println("결재페이지 호출");
			mav.setViewName("document/viewApprovalDoc");
		}else if(document_type==4) {
			System.out.println("완료페이지 호출");
			mav.setViewName("document/viewCompleteDoc");
		}
		
		return mav;
	}
	
	/**
	 *  선택한 문서 삭제하기
	 * @return view : 새문서함목록(newDocList.jsp)
	 */	
	@RequestMapping(value = "/deleteNewDoc", method=RequestMethod.GET)
	public String deleteNewDoc(@RequestParam(name="document_no")int document_no){
		System.out.println("deleteNewDoc() 메소드 호출");
		
		service2.deleteNewDoc(document_no);
		return "groupware/newDocList";
	}
}
