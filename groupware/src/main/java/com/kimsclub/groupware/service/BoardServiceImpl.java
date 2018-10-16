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
	
	@Override
	public List<BoardVO> communityList() {
		return dao.communityList();
	}
	
	@Override
	public List<BoardVO> noticeList() {
		return dao.noticeList();
	}
	
	@Override
	public void insertBoard(BoardVO vo) {
		dao.insertBoard(vo);
	}

	@Override
	public List<BoardVO> detail() {
		
		return null;
	}
	
	

}
