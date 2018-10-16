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
		return session.selectList("board.selectComm");
	}
	
	public List<BoardVO> noticeList(){
		return session.selectList("board.selectNotice");
	}
	
	public List<BoardVO> detail(){
		//성욱이형 커밋을 잘하자 10번 외칩니다.
		//return session.selectOne("board.selectDetail", arg1);
		return null;
	}
}
