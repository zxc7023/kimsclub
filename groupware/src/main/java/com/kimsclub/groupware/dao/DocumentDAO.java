package com.kimsclub.groupware.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.DocumentVO;

@Repository
public class DocumentDAO {
	@Autowired
	SqlSession session;
	
	public void insertDocument(DocumentVO dvo) {
		session.insert("document.saveDocument", dvo);
	}

	public DocumentVO selectDocument(int document_no) {
		return session.selectOne("document.selectDocument", document_no);
	}
}
