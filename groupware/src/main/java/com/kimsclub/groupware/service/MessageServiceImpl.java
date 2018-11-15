package com.kimsclub.groupware.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.MessageDAO;
import com.kimsclub.groupware.vo.MessageVO;

@Service("MessageService")
public class MessageServiceImpl implements MessageService {
	@Autowired
	MessageDAO dao;
	
	//쪽지 작성 등록
	@Override
	public void insertMessage(MessageVO vo) {
		dao.insertMessage(vo);
	}
	
	//쪽지 레코드 갯수
	@Override
	public int countMessage(int employee_no, String searchOption, String keyword, String box) {
		return dao.countMessage(employee_no, searchOption, keyword, box);
	}

	//보낸 쪽지함 조회
	@Override
	public List<MessageVO> MessageList(int start, int end, int employee_no, String searchOption, String keyword, String box) {
		return dao.MessageList(start, end, employee_no, searchOption, keyword, box);
	}
	
	//쪽지 보관
	@Override
	public void keepMessage(int[] message_no) {
		dao.keepMessage(message_no);
	}
	
	//쪽지 삭제
	@Override
	public void deleteMessage(int[] message_no, String message_del) {
		dao.deleteMessage(message_no, message_del);
	}

	//쪽지 상세보기
	@Override
	public MessageVO detailMessage(MessageVO vo, String box) {
		return dao.detailMessage(vo, box);
	}

/*	//쪽지 답장하기
	@Override
	public MessageVO answerMessage(MessageVO vo) {
		return null;
	}*/

	//쪽지 읽음
	@Override
	public void readMessage(MessageVO vo) {
		dao.readMessage(vo);
	}

	//읽지 않은 쪽지
	@Override
	public int unReadMessage(int employee_no) {
		return dao.unReadMesaage(employee_no);
	}

	
	
}