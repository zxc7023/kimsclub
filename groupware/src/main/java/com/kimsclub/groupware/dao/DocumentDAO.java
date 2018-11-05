package com.kimsclub.groupware.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.DocumentVO;

@Repository
public class DocumentDAO {
	@Autowired
	SqlSession session;
	
	public void insertDocument(DocumentVO dvo) {
		session.insert("document.insertDocument", dvo);
	}
}
