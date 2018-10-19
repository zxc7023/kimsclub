package com.kimsclub.groupware.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
		
	//게시판(커뮤니티,공지사항 별)게시글 목록
	@RequestMapping("/boardList")
	public ModelAndView boardList(HttpServletRequest request){
		//게시판 타입(board_type):커뮤니티:c, 공지사항:n
		String board_type = request.getParameter("board_type");
		List<BoardVO> list =service.boardList(board_type);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("BoardList", list);
		mav.addObject("board_type",board_type);
		mav.setViewName("/Board/BoardList");
		return mav;
	}	
		
	//게시글(커뮤니티,공지사항)세부 화면
	@RequestMapping(value="/detail", method=RequestMethod.GET)
	public ModelAndView BoardDetail(BoardVO vo) {
		//해당게시글 세부사항 가져오기
		BoardVO detailVO = service.detail(vo);
		//해당 게시글 조회수 증가
		service.viewcnt(vo);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("detailVO", detailVO);
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
	 	service.insertBoard(vo);
	 	return "redirect:/boardList?board_type="+vo.getBoard_type();
	}
}
