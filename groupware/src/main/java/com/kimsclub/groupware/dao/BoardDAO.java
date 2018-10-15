package com.kimsclub.groupware.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.BoardVO;

@Repository
public class BoardDAO {
	@Autowired
	SqlSession session;
	
	public void insertBoard(BoardVO vo) {
		session.insert("board.insertBoard", vo);
	}
	
	public List<BoardVO> communityList(){
		return session.selectList("board.selectBoard");
	}
	
}
