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

import com.kimsclub.groupware.service.DocumentService;
import com.kimsclub.groupware.service.TransmissionService;
import com.kimsclub.groupware.vo.BoardPageVO;
import com.kimsclub.groupware.vo.DocumentVO;
import com.kimsclub.groupware.vo.EmployeeVO;
import com.kimsclub.groupware.vo.TransmissionVO;


@Controller
public class TransmissionController {
	@Autowired
	TransmissionService service;
	@Autowired
	DocumentService service2;
	
	/**
	 *  완료된 문서를 받을 사람을 지정하여 보내준다.
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
		return "redirect:sendDocList";
	}
	
	/**
	 *  완료된 문서를 전 사원이 볼 수 있는 공람문서함으로 보내준다.
	 */
	@RequestMapping(value = "/sendPublicDoc", method=RequestMethod.POST)
	public String sendPublicDoc(HttpSession session, @RequestParam("document_no")int document_no){
		System.out.println("sendPublicDoc() 메소드 호출");
		EmployeeVO evo = (EmployeeVO)session.getAttribute("loginInfo");
		
		TransmissionVO tvo = new TransmissionVO(evo.getEmployee_no(),0,document_no);
		service.sendPublicDoc(tvo);
		return "redirect:publicDocList";
	}
	
	/**
	 *  해당하는 조건의 문서의 목록을 가져오기 위한 세팅
	 *  doc_type = 0 새 문서함(자신이 작성한 문서중 아직 기안하지 않은 문서의 목록)  - document_writer_no = 자신의 번호 AND document_state = 0 
	 */
	public ModelAndView docSetting(int employee_no,int page_scale, String[] searchOption, String keyword,int cur_page,int doc_type) {
		Map<String, Object> map = new HashMap<String,Object>();
		ModelAndView mav = new ModelAndView();
		map.put("fromOption", "document d join transmission t on d.document_no = t.transmission_document_no LEFT JOIN employee e1 on transmission_sender_no = e1.employee_no LEFT JOIN employee e2 on t.TRANSMISSION_RECEIVER_NO = e2.employee_no");
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("order", "TRANSMISSION_SENDER_DATE");
		if(doc_type==0) {
			map.put("whereOption", "TRANSMISSION_SENDER_NO = "+employee_no);
		}else if (doc_type==1) {
			map.put("whereOption", "TRANSMISSION_RECEIVER_NO = "+employee_no);
		}else if (doc_type==2) {
			map.put("whereOption", "TRANSMISSION_RECEIVER_NO is null");
		}
		
		map.put("selectOption", "d.*,t.*,e1.EMPLOYEE_NAME as sender_name,e2.employee_name as receiver_name");
		//페이징
		BoardPageVO bpvo = new BoardPageVO(service2.getDocumentCnt(map), cur_page, page_scale); 
		map.put("start", bpvo.getPageBegin());
		map.put("end", bpvo.getPageEnd());
				
		//map을 통해 해당하는 리스트 불러오기
		List<TransmissionVO> tlist = service.getTransmissionList(map);
		
		//현재 페이지가 page_scale 변경 시 최대 페이지보다 크면 1로 초기화
		if(cur_page>bpvo.getTotPage()) {
			cur_page=1;
		}
		
		mav.addObject("map",map);
		mav.addObject("tlist",tlist);
		mav.addObject("page",bpvo);
		
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
		System.out.println("sendDocList() 메소드 호출");
		EmployeeVO evo = (EmployeeVO) session.getAttribute("loginInfo");
		ModelAndView mav = docSetting(evo.getEmployee_no(), page_scale, search_option, keyword, cur_page,0);
		
		mav.setViewName("transmission/sendDocList");
		
		return mav;
	}
	
	/**
	 *  자신이 받은 완료문서 목록을 보여준다.
	 *  view : 받은 문서함(receiveDocList) 
	 */
	@RequestMapping(value = "/receiveDocList", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView receiveDocList(@RequestParam(name="page_scale", defaultValue="10") int page_scale,
			@RequestParam(name="searchOption", defaultValue="")String[] search_option,					  
			@RequestParam(name="keyword", defaultValue="") String keyword,
			@RequestParam(name="cur_page",defaultValue="1") int cur_page,HttpSession session){
		System.out.println("receiveDocList() 메소드 호출");
		EmployeeVO evo = (EmployeeVO) session.getAttribute("loginInfo");
		ModelAndView mav = docSetting(evo.getEmployee_no(), page_scale, search_option, keyword, cur_page,1);
		
		mav.setViewName("transmission/receiveDocList");
		
		return mav;
	}
	
	/**
	 *  모든 사원이 볼 수 있는 공람문서 목록을 보여준다.
	 *  view : 공람 문서함(publicDocList) 
	 */
	@RequestMapping(value = "/publicDocList", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView publicDocList(@RequestParam(name="page_scale", defaultValue="10") int page_scale,
			@RequestParam(name="searchOption", defaultValue="")String[] search_option,					  
			@RequestParam(name="keyword", defaultValue="") String keyword,
			@RequestParam(name="cur_page",defaultValue="1") int cur_page,HttpSession session){
		System.out.println("publicDocList() 메소드 호출");
		EmployeeVO evo = (EmployeeVO) session.getAttribute("loginInfo");
		ModelAndView mav = docSetting(evo.getEmployee_no(), page_scale, search_option, keyword, cur_page,2);
		
		mav.setViewName("transmission/publicDocList");
		
		return mav;
	}
	
	
	/**
	 *  문서 선택해서 보기
	 * @return view : 임시저장된 문서(viewDoc.jsp)
	 */	
	@RequestMapping(value = "/viewTransmissionDoc", method=RequestMethod.POST)
	public ModelAndView viewTransmissionDoc(HttpSession session,@RequestParam(name="document_no")int document_no,@RequestParam(name="document_type")int document_type){
		System.out.println("viewTransmissionDoc() 메소드 호출");
		EmployeeVO evo = (EmployeeVO)session.getAttribute("loginInfo");
		ModelAndView mav = new ModelAndView();
		DocumentVO dvo = service2.viewDoc(document_no);
		System.out.println(dvo);
		mav.addObject("dvo", dvo);
        if("휴가신청".equals(dvo.getDocument_title())) {
            System.out.println("휴가신청 페이지 호출");
            mav.addObject("dayOff",1);
        }
		if(document_type == 0) {
			System.out.println("발송문서함페이지 호출");
			mav.setViewName("transmission/viewSendDoc");			
		}else if(document_type==1) {
			System.out.println("수신문서함페이지 호출");
			mav.setViewName("transmission/viewReceiveDoc");
		}else if(document_type==2) {
			System.out.println("공람문서함페이지 호출");
			mav.setViewName("transmission/viewPublicDoc");
		}
		
		return mav;
	}
	
}
