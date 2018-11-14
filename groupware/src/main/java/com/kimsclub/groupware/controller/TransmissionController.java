package com.kimsclub.groupware.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kimsclub.groupware.service.TransmissionService;
import com.kimsclub.groupware.vo.BoardPageVO;
import com.kimsclub.groupware.vo.DocumentVO;
import com.kimsclub.groupware.vo.EmployeeVO;
import com.kimsclub.groupware.vo.TransmissionVO;


@Controller
public class TransmissionController {
	@Autowired
	TransmissionService service;
	
	/**
	 *  완료된 문서를 공람이나 받을 사람을 지정하여 보내준다.
	 */
	@RequestMapping(value = "/sendDoc", method=RequestMethod.POST)
	public String sendDoc(HttpSession session, @RequestParam("employee_no")int[] employee_no, @RequestParam("document_no")int document_no){
		System.out.println("sendDoc() 메소드 호출");
		EmployeeVO evo = (EmployeeVO)session.getAttribute("loginInfo");
		
		List<TransmissionVO> tlist = new ArrayList<TransmissionVO>();
		for(int receiver_no:employee_no) {
			System.out.println(receiver_no);
			tlist.add(new TransmissionVO(evo.getEmployee_no(),receiver_no,document_no));
		}
		
		service.sendDocs(tlist);
		return "transmission/sendDocList";
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
		}else if (doc_type==2) {
			map.put("whereOption", "document_writer_no = "+employee_no+" and document_state = '반려'");
		}
		
		//내용 제외- 문서 목록에서는 내용을 보여줄 필요없음
	/*	map.put("selectOption", "B.document_no, B.document_title, B.document_date ");
		//페이징
		BoardPageVO bpvo = new BoardPageVO(service2.getDocumentCnt(map), cur_page, page_scale); 
		map.put("start", bpvo.getPageBegin());
		map.put("end", bpvo.getPageEnd());
				
		//map을 통해 해당하는 리스트 불러오기
		List<DocumentVO> dlist = service2.getDocumentList(map);

		mav.addObject("map",map);
		mav.addObject("dlist",dlist);
		mav.addObject("page",bpvo);*/
		
		return mav;
	}
	
	/**
	 *  자신이 보낸 완료문서 목록을 보여준다.
	 *  view : 보낸 문서함(sendDocList) 
	 */
	@RequestMapping(value = "/sendDocList", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView sendDocList(@RequestParam(name="page_scale", defaultValue="10") int page_scale,
			@RequestParam(name="searchOption", defaultValue="")String[] search_option,					  
			@RequestParam(name="keyword", defaultValue="") String keyword,
			@RequestParam(name="cur_page",defaultValue="1") int cur_page,HttpSession session){
		System.out.println("newDocList() 메소드 호출");
		EmployeeVO evo = (EmployeeVO) session.getAttribute("loginInfo");
		ModelAndView mav = docSetting(evo.getEmployee_no(), page_scale, search_option, keyword, cur_page,0);
		
		mav.setViewName("transmission/sendDocList");
		
		return mav;
	}
}
