package com.kimsclub.groupware.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.TransmissionVO;

@Repository
public class TransmissionDAO {
	@Autowired
	SqlSession session;
	
	public void sendDocs(List<TransmissionVO> tlist) {
		for(TransmissionVO tvo : tlist) {
			session.insert("sendDoc",tvo);
		}
	}

}
