package com.kimsclub.groupware.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kimsclub.groupware.service.BoardService;
import com.kimsclub.groupware.vo.BoardPageVO;
import com.kimsclub.groupware.vo.BoardReplyVO;
import com.kimsclub.groupware.vo.BoardVO;

@Controller
public class BoardController {
	@Autowired
	BoardService service;
	
	//게시판 메인화면
		@RequestMapping(value="/BoardMenu", method=RequestMethod.GET)
		public String boardMenu(){
			return "/Board/BoardMenu";
		}
		
	//게시판(커뮤니티,공지사항)게시글 목록
	@RequestMapping("/boardList")
	public ModelAndView boardList(@RequestParam("board_type") String board_type,
			@RequestParam(defaultValue="board_title") String searchOption,					  
			@RequestParam(defaultValue="") String keyword,
			@RequestParam(defaultValue="1") int curPage){
		
		//게시글 수
		int count = service.countArticle(board_type, searchOption, keyword);
		
		BoardPageVO boardPager = new BoardPageVO(count, curPage);
		
		int start = boardPager.getPageBegin();
		int end = boardPager.getPageEnd();		
		List<BoardVO> list = service.boardList(start,end,board_type,searchOption,keyword);
		
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("list", list); //게시글 목록
		map.put("searchOption", searchOption); //검색옵션
		map.put("keyword", keyword); //검색 키워드
		map.put("board_type", board_type); //게시판 타입(board_type):커뮤니티:c, 공지사항:n
		map.put("count", count); //게시글 갯수
		map.put("boardPager", boardPager); //게시글 페이징
		mav.addObject("map", map);
		mav.setViewName("/Board/BoardList");
		return mav;
	}

	//게시글(커뮤니티,공지사항)세부 화면
	@RequestMapping(value="/detail", method=RequestMethod.GET)
	public ModelAndView boardDetail(BoardVO vo) {
		//해당 게시글 조회수 증가
		service.viewcnt(vo);
		//해당게시글 세부사항 가져오기
		BoardVO detailVO = service.detail(vo);
		//
		ModelAndView mav = new ModelAndView();
		/*Map<String, Object> map = new HashMap<String,Object>();
		map.put("detailVO", detailVO);
		map.put("replyVO", arg1);*/
		mav.addObject("detailVO", detailVO);		
		mav.setViewName("/Board/BoardDetail");
		return mav;
	}
	
	//게시글(커뮤니티,공지사항)작성 화면
	@RequestMapping(value="/BoardWrite", method=RequestMethod.GET)
	public String boardWrite(){
		return "/Board/BoardWrite";
	}
	
	//게시글(커뮤니티,공지사항)작성 처리 
	@RequestMapping(value="/BoardWrite", method=RequestMethod.POST)
	public String boardList(BoardVO vo) {
	 	service.insertBoard(vo);
	 	return "redirect:/boardList?board_type="+vo.getBoard_type();
	}
	
	//댓글 입력
	@RequestMapping(value="/ReplyWrite", method=RequestMethod.POST)
	@ResponseBody
	public void replyWrite(@ModelAttribute BoardReplyVO vo, HttpSession session) {
		System.out.println("board_no:"+vo.getBoard_no());
		System.out.println("Reply_board_type:"+vo.getReply_board_type());
		System.out.println("Reply_contents:"+vo.getReply_contents());
		service.insertBoardReply(vo);
	}
	
	@RequestMapping(value="/ReplyList",method=RequestMethod.POST)
	/*@ResponseBody*/
	public List<BoardReplyVO> replyList(BoardReplyVO vo) {
		System.out.println("왜요");
		List<BoardReplyVO> replyList = service.boardReplyList(vo);
		return replyList;
	}
}
