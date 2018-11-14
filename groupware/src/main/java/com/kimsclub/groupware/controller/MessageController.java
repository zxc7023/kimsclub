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

import com.kimsclub.groupware.service.MessageService;
import com.kimsclub.groupware.vo.BoardPageVO;
import com.kimsclub.groupware.vo.EmployeeVO;
import com.kimsclub.groupware.vo.MessageVO;

@Controller
public class MessageController {
	@Autowired
	MessageService service;
	
	//쪽지 작성 화면
		@RequestMapping(value="/messageWrite", method=RequestMethod.GET)
		public String messageWrite() {
			return "/message/messageWrite";
		}
	
	//쪽지 작성 처리
		@RequestMapping(value="/messageWrite",method=RequestMethod.POST)
		public String messageWriteProcess(MessageVO vo, HttpSession session) {
			EmployeeVO evo = (EmployeeVO) session.getAttribute("loginInfo");
			int message_sender_no = evo.getEmployee_no();
			vo.setMessage_sender_no(message_sender_no);
			service.insertMessage(vo);
			return "redirect:/messageList?box=outBox";
		}	
		
	//쪽지함(보낸쪽지, 받은쪽지, 보관쪽지)
		@RequestMapping(value="/messageList")
		public ModelAndView messageList(HttpSession session,
				@RequestParam(name="box",defaultValue="inBox") String box,
				@RequestParam(name="searchOption", defaultValue="all") String searchOption,					  
				@RequestParam(name="keyword",defaultValue="") String keyword,
				@RequestParam(name="page_scale",defaultValue="10") int page_scale,
				@RequestParam(name="curPage",defaultValue="1") int curPage) {

			//로그인 세션(자신의 사원번호)
			EmployeeVO evo = (EmployeeVO) session.getAttribute("loginInfo");
			int employee_no = evo.getEmployee_no();
			
			//쪽지 목록 map에 담기
			ModelAndView mav = new ModelAndView();
			Map<String, Object> map = new HashMap<String,Object>();
			
			//쪽지 레코드 갯수
			int count = service.countMessage(employee_no, searchOption, keyword, box);
			
			//받은쪽지중 읽지 않은 쪽지 갯수
			int unReadMsgCnt = service.unReadMessage(employee_no);
			
			//쪽지 레코드수, 현재페이지, 페이지당 게시글 행수
			BoardPageVO messagePager = new BoardPageVO(count, curPage, page_scale);
			int start = messagePager.getPageBegin();
			int end = messagePager.getPageEnd();
			//쪽지 목록(보낸쪽지,받은쪽지,보관쪽지)
			List<MessageVO>	list = service.MessageList(start, end, employee_no, searchOption, keyword, box);
			map.put("list", list); //보낸 쪽지함 목록
			map.put("searchOption", searchOption); //검색옵션
			map.put("keyword", keyword); //검색 키워드
			map.put("count", count); //게시글 갯수
			map.put("messagePager", messagePager); //게시글 행,페이징
			map.put("box", box); //쪽지함 구분(보낸쪽지함, 받은쪽지함, 보관함)
			map.put("employee_no", employee_no);//자신의 사원번호
			map.put("unReadMsgCnt", unReadMsgCnt);//받은쪽지중 읽지 않은 쪽지 갯수
			mav.addObject("map", map);
			mav.setViewName("/message/messageList");
			return mav;
			}
		
	//쪽지 보관
		@RequestMapping(value="/keepMessage", method=RequestMethod.POST)
		@ResponseBody
		public void keepMessage(@RequestParam(value="message_no")int[] message_no) {
			service.keepMessage(message_no);
		}
		
	//쪽지 삭제
		@RequestMapping(value="/deleteMessage", method=RequestMethod.POST)
		@ResponseBody
		public void deleteMessage(@RequestParam(value="message_no")int[] message_no,
								  @RequestParam(value="box")String box) {
			String message_del;
			if(box.equals("outBox")) {//보낸 쪽지 삭제시
				message_del="message_send_del";
				service.deleteMessage(message_no, message_del);
			}else if(box.equals("inBox")) {//받은쪽지 삭제시
				message_del="message_receive_del";
				service.deleteMessage(message_no, message_del);
			}else {//보관쪽지 삭제시
				message_del="message_keep_del";
				service.deleteMessage(message_no, message_del);
			}
		}
		
	//쪽지 상세보기
		@RequestMapping(value="/messageDetail", method=RequestMethod.POST)
		public ModelAndView messageDetail(MessageVO vo,
				@RequestParam(name="box",defaultValue="inBox") String box,
				@RequestParam(name="searchOption", defaultValue="all") String searchOption,					  
				@RequestParam(name="keyword",defaultValue="") String keyword,
				@RequestParam(name="page_scale",defaultValue="10") int page_scale,
				@RequestParam(name="curPage",defaultValue="1") int curPage) {
			
			//쪽지 read
			service.readMessage(vo);
			
			//해당쪽지 세부내용 가져오기			
			MessageVO detailvo = service.detailMessage(vo, box);
			ModelAndView mav = new ModelAndView();
			mav.addObject("detailvo", detailvo);
			mav.addObject("searchOption", searchOption);
			mav.addObject("keyword", keyword);
			mav.addObject("page_scale", page_scale);
			mav.addObject("curPage", curPage);
			mav.addObject("box", box);	
			System.out.println(detailvo.getMessage_senderAndReceiver_name());
			mav.setViewName("/message/messageDetail");
			System.out.println(box);
			return mav;
		}

	//읽은 쪽지 확인

	}
