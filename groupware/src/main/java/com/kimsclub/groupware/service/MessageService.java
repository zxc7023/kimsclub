package com.kimsclub.groupware.service;

import java.util.List;
import java.util.Map;

import com.kimsclub.groupware.vo.MessageVO;

public interface MessageService {

	//쪽지 작성 등록
	public void insertMessage(MessageVO vo);
	//쪽지 레코드 갯수
	public int countMessage(int employee_no, String searchOption, String keyword, String box);
	//쪽지함 조회
	public List<MessageVO> MessageList(int start, int end, int employee_no, String searchOption, String keyword, String box);
	//쪽지 보관
	public void keepMessage(int[] message_no, String box);
	//쪽지 삭제
	public void deleteMessage(int[] message_no, String message_del);
	//쪽지 상세보기
	public MessageVO detailMessage(MessageVO vo, String box); 
	//쪽지 읽음
	public void readMessage(MessageVO vo);
	//읽지 않은 쪽지
	public int unReadMessage(int employee_no);
	
}
