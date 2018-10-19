package com.kimsclub.groupware.service;

import java.util.List;

import com.kimsclub.groupware.vo.BoardVO;

public interface BoardService {

	public List<BoardVO> communityList();
	public List<BoardVO> noticeList();
	public void insertBoard(BoardVO vo);
	public BoardVO detail(BoardVO vo);
	public BoardVO viewcnt(BoardVO vo);
}
