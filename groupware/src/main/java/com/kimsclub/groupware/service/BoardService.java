package com.kimsclub.groupware.service;

import java.util.List;

import com.kimsclub.groupware.vo.BoardReplyVO;
import com.kimsclub.groupware.vo.BoardVO;

public interface BoardService {
	//게시판 게시글 조회
	public List<BoardVO> boardList(int start, int end, String board_type, String searchOption, String keyword);
	//게시판 게시글 등록
	public void insertBoard(BoardVO vo);
	//게시판 게시글 내용 보기
	public BoardVO detail(BoardVO vo);
	//게시판 게시글 조회수
	public BoardVO viewcnt(BoardVO vo);
	//게시글 수
	public int countArticle(String board_type, String searchOption, String keyword);
	//댓글 입력
	public void insertBoardReply(BoardReplyVO vo);
	//댓글 목록
	public List<BoardReplyVO> boardReplyList(BoardReplyVO vo);
	
}
