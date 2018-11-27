package com.kimsclub.groupware.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kimsclub.groupware.service.DocumentService;
import com.kimsclub.groupware.service.MessageService;
import com.kimsclub.groupware.vo.EmployeeVO;

@Controller
public class HomeController {
	@Autowired 
	MessageService msgservice; 
	@Autowired 
	DocumentService service; 
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(HttpSession session) {
		System.out.println("home 호출");
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String,Object>();
		EmployeeVO evo = (EmployeeVO) session.getAttribute("loginInfo");
		int employee_no = evo.getEmployee_no();
		
	//안읽은 쪽지 확인 서비스	
		int unReadMsgCnt = msgservice.unReadMessage(employee_no);
	//결재 문서 서비스
		map.put("fromOption", "(SELECT d.* FROM document d, approval a1, approval a2 WHERE a1.approval_next_no = a2.approval_no AND a2.approval_state=0 AND a1.approval_state =1 AND a2.document_no=d.document_no AND a2.employee_no ="+employee_no+")");
		map.put("whereOption", "document_state = '진행'");
		int approvalDocCnt = service.getDocumentCnt(map);
		
		map.put("fromOption", "(SELECT d.*, a.employee_no,a.approval_state, e.employee_name FROM document d, approval a, employee e WHERE d.document_no = a.document_no AND d.DOCUMENT_WRITER_NO = e.employee_no)");
		map.put("whereOption", "employee_no = "+employee_no+" and document_state = '진행' and approval_state=1");
		int proceedDocCnt = service.getDocumentCnt(map);
		
		map.put("whereOption", "employee_no = "+employee_no+" and document_state = '진행' and approval_state=1 AND document_writer_no = "+employee_no);
		int proceedMyDocCnt = service.getDocumentCnt(map);
		
		mav.addObject("apdCnt", approvalDocCnt);
		mav.addObject("pdCnt", proceedDocCnt);
		mav.addObject("pMydCnt", proceedMyDocCnt);
	//-------//	

	//-------//
		
		map.put("unReadMsgCnt", unReadMsgCnt);//받은쪽지중 읽지 않은 쪽지 갯수
		mav.addObject("map", map);
		mav.setViewName("index");
		
		return mav;
	}

}
