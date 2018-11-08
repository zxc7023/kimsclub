package com.kimsclub.groupware.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.BoardReplyVO;
import com.kimsclub.groupware.vo.BoardVO;

@Repository
public class BoardDAO {
	@Autowired
	SqlSession session;
	
	//게시판(커뮤니티, 공지사항) 조회
	public List<BoardVO> boardList(int start, int end, String board_type, String searchOption, String keyword){
		Map<String, Object> map =new HashMap<String, Object>();
		map.put("start",start);
		map.put("end",end);
		map.put("board_type", board_type);
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		return session.selectList("board.selectBoard", map);
	}
	
	//게시글 등록
	public void insertBoard(BoardVO vo) {
		session.insert("board.insertBoard", vo);
	}
	
	//작성된 게시글 상세 내용 조회
	public BoardVO detail(BoardVO vo){
		BoardVO detailVO = session.selectOne("board.selectDetail", vo);
		return detailVO;
	}
	
	//게시글 조회수 증가 
	public BoardVO viewcnt(BoardVO vo) {
		session.update("board.updateViewcnt",vo);
		return vo;
	}
	
	//게시글 수 카운트
	public int countArticle(String board_type, String searchOption, String keyword) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("board_type", board_type);
		return session.selectOne("board.countArticle",map);
	}
	
	//게시판 게시글 수정
	public void updateBoard(BoardVO vo) {
		session.update("board.updateBoard",vo);
	}
	
	//게시판 게시글 삭제
	public void deleteBoard(BoardVO vo) {
		session.delete("board.deleteBoard",vo);
	}
	
	//게시글 댓글 등록
	public void insertBoardReply(BoardReplyVO vo) {
		if(vo.getReply_group()==0) {
			//댓글 입력시
			session.insert("board.insertBoardReply", vo);
		}else{
			if(vo.getReply_order()==0) {
				//입력된 댓글의 답글 입력시
				session.insert("board.insertBoardReplyOfReply", vo);	
			}else {
				session.update("board.updateBoardReplyOfReply", vo);
				session.insert("board.insertBoardReplyOfReplyOfReply",vo);
			}
		}
	}
	
	//게시글 댓글 목록 조회
	public List<BoardReplyVO> boardReplyList(BoardReplyVO vo) {
		return	session.selectList("board.selectBoardReply", vo);
	}
	
	//게시글 댓글 order 조회
	public int selectReplyOrder(BoardReplyVO vo) {
		System.out.println("-----------------------");
		System.out.println("order"+vo.getReply_order());
		System.out.println("depth"+vo.getReply_depth());
		return session.selectOne("board.selectReplyOrder", vo);
	}
	
	//게시글 댓글 조회수 조회
	public int selectReplyCount(BoardReplyVO vo) {
		return session.selectOne("board.selectReplyCount",vo);
	}
	
	//게시글 댓글 삭제 
	public void deleteReply(BoardReplyVO vo) {
		session.delete("board.deleteReply", vo);
	}
	
	//게시글 댓글 수정
	public void updateReply(BoardReplyVO vo) {
		session.update("board.updateReply", vo);
	}
}
