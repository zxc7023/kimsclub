package com.kimsclub.groupware.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.BoardVO;

@Repository
public class BoardDAO {
	@Autowired
	SqlSession session;
	
	//게시글 등록
	public void insertBoard(BoardVO vo) {
		System.out.println("타입:"+vo.getBoard_type());
		session.insert("board.insertBoard", vo);
	}
	
	//게시판(커뮤니티, 공지사항) 조회
	public List<BoardVO> boardList(String board_type){
		return session.selectList("board.selectBoard", board_type);
	}
	
	//작성된 게시글 내용 조회
	public BoardVO detail(BoardVO vo){
		BoardVO detailVO = session.selectOne("board.selectDetail", vo);
		return detailVO;
	}
	
	//게시글 조회수 증가 
	public BoardVO viewcnt(BoardVO vo) {
		session.update("board.updateViewcnt",vo);
		return vo;
	}
	
	public List<BoardVO> listAll(int start, int end, String searchOption, String keyword){
		Map<String, Object>map = new HashMap<String, Object>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("end", end);
		return session.selectList("board.listAll", map);
	}
}
