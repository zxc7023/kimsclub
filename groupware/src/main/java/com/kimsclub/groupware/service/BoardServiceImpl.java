package com.kimsclub.groupware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.BoardDAO;
import com.kimsclub.groupware.vo.BoardReplyVO;
import com.kimsclub.groupware.vo.BoardVO;

@Service("service")
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardDAO dao;
	
	//게시판 게시글 조회
	@Override
	public List<BoardVO> boardList(int start, int end, String board_type, String searchOption, String keyword) {
		return dao.boardList(start, end, board_type, searchOption, keyword);
	}
	
	//게시판 게시글 등록
	@Override
	public void insertBoard(BoardVO vo) {
		dao.insertBoard(vo);
	}
	
	//게시판 게시글 내용 보기
	@Override
	public BoardVO detail(BoardVO vo) {
		return dao.detail(vo);
	}
	//게시판 게시글 조회수 카운트
	@Override
	public BoardVO viewcnt(BoardVO vo) {
		return dao.viewcnt(vo);
	}
	//게시판 게시글 수
	@Override
	public int countArticle(String board_type, String searchOption, String keyword) {
		return dao.countArticle(board_type, searchOption, keyword);
	}
	//게시글 댓글 입력
	@Override
	public void insertBoardReply(BoardReplyVO vo) {
		dao.insertBoardReply(vo);
	}
	//게시글 댓글 목록
	@Override
	public List<BoardReplyVO> boardReplyList(BoardReplyVO vo) {
		return dao.boardReplyList(vo);
	}
	
	
}
