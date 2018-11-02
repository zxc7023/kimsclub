package com.kimsclub.groupware.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.kimsclub.groupware.dao.DocumentDAO;
import com.kimsclub.groupware.vo.DocumentVO;

public class DocumentServiceImpl implements DocumentService {
	@Autowired
	DocumentDAO ddao;
	
	@Override
	public void saveDocument(DocumentVO dvo) {
		ddao.insertDocument(dvo);
		
	}
	
}
