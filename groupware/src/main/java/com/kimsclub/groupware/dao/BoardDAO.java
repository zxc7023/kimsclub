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
	
	//게시글 등록
	public void insertBoard(BoardVO vo) {
		System.out.println("타입:"+vo.getBoard_type());
		session.insert("board.insertBoard", vo);
	}
	
	//커뮤니티 게시판 리스트 조회 
	public List<BoardVO> communityList(){
		return session.selectList("board.selectComm");
	}
	
	//공지사항 게시판 리스트 조회
	public List<BoardVO> noticeList(){
		return session.selectList("board.selectNotice");
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
}
