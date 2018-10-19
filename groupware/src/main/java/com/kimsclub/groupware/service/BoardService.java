package com.kimsclub.groupware.service;

import java.util.List;

import com.kimsclub.groupware.vo.BoardVO;

public interface BoardService {
	
	//게시판 게시글 조회
	public List<BoardVO> boardList(String board_type);
	//게시판 게시글 등록
	public void insertBoard(BoardVO vo);
	//게시판 게시글 내용 보기
	public BoardVO detail(BoardVO vo);
	//게시판 게시글 조회수 카운트
	public BoardVO viewcnt(BoardVO vo);
	//게시판 
	public List<BoardVO> listAll(int start, int end, String searchOption, String keyword);
}
