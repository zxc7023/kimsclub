package com.kimsclub.groupware.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kimsclub.groupware.service.BoardService;
import com.kimsclub.groupware.vo.BoardVO;

@Controller
public class BoardController {
	@Autowired
	BoardService service;
	
	//게시판 메인화면
		@RequestMapping(value="/BoardMenu", method=RequestMethod.GET)
		public String BoardMenu(){
			return "/Board/BoardMenu";
		}
	//커뮤니티 목록
	@RequestMapping("/community")
	public ModelAndView comlist(){
		List<BoardVO> list =service.communityList();
		ModelAndView mav = new ModelAndView();
		mav.addObject("BoardList", list);
		mav.setViewName("/Board/BoardList");
		return mav;
	}
	//공지사항 목록
	@RequestMapping("/notice")
	public ModelAndView noticelist(){
		List<BoardVO> list = service.noticeList();
		ModelAndView mav = new ModelAndView();
		mav.addObject("BoardList", list);
		mav.setViewName("/Board/BoardList");
		return mav;
	}
	//게시글(커뮤니티,공지사항)세부 화면
	@RequestMapping("/detail")
	public ModelAndView BoardDetail() {
		/*List<BoardVO> list = service.noticeList();*/
		ModelAndView mav = new ModelAndView();
		/*mav.addObject("BoardList", list);*/
		mav.setViewName("/Board/BoardDetail");
		return mav;	
	}
	//게시글(커뮤니티,공지사항)작성 화면
	@RequestMapping(value="/BoardWrite", method=RequestMethod.GET)
	public String BoardWrite(){
		return "/Board/BoardWrite";
	}
	
	//게시글(커뮤니티,공지사항)작성 처리 
	@RequestMapping(value="/BoardWrite", method=RequestMethod.POST)
	public String BoardList(BoardVO vo) {
		vo.setBoard_type("c");
		System.out.println(vo.getBoard_title());
		service.insertBoard(vo);
		return "redirect:/community";
	}
	
}
