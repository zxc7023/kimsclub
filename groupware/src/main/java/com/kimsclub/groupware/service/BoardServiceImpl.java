package com.kimsclub.groupware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.BoardDAO;
import com.kimsclub.groupware.vo.BoardVO;

@Service("service")
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardDAO dao;
	
	//게시판 게시글 조회
	@Override
	public List<BoardVO> boardList(String board_type) {
		return dao.boardList(board_type);
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

	@Override
	public List<BoardVO> listAll(int start, int end, String searchOption, String keyword) {
		return dao.listAll(start, end, searchOption, keyword);
	}

}
