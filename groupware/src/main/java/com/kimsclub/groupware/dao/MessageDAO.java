package com.kimsclub.groupware.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.MessageVO;
import com.sun.corba.se.impl.protocol.giopmsgheaders.Message;

@Repository
public class MessageDAO {
	@Autowired
	SqlSession session;
	
	//쪽지 작성 등록
	public void insertMessage(MessageVO vo) {
		session.insert("message.insertMessage", vo);
	}
	
	//쪽지 레코드 갯수
	public int countMessage(int employee_no, String searchOption, String keyword, String box) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("employee_no", employee_no);
		map.put("box", box);
		return session.selectOne("message.selectCountMessage", map);
	}
	
	//쪽지함 조회
	public List<MessageVO> MessageList(int start, int end, int employee_no, String searchOption, String keyword, String box){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("start",start);
		map.put("end",end);
		map.put("employee_no", employee_no);
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("box", box);
		return session.selectList("message.selectMessageList",map);
	}
	
	//쪽지 보관
	public void keepMessage(int[] message_no, String box) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("message_no",message_no);
		map.put("box",box);
		session.update("message.updateKeepMessage", map);
	}
	
	//쪽지 삭제
	public void deleteMessage(int[] message_no, String message_del) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("message_no", message_no);
		map.put("message_del", message_del);
		session.update("message.updateDeleteMessage", map);
	}
	
	//쪽지 상세보기
	public MessageVO detailMessage(MessageVO vo, String box) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("message_no", vo.getMessage_no());
		map.put("box", box);
		return session.selectOne("message.selectDetailMessage", map);

	}
	
	//쪽지 읽음
	public void readMessage(MessageVO vo) {
		session.update("message.updateReadMessage", vo);
	}
	
	//읽지 않은 쪽지
	public int unReadMesaage(int employee_no) {
		return session.selectOne("message.selectUnReadMessage", employee_no);
	}
}
