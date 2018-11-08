package com.kimsclub.groupware.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.DocumentDAO;
import com.kimsclub.groupware.vo.DocumentVO;

@Service
public class DocumentServiceImpl implements DocumentService {
	@Autowired
	DocumentDAO ddao;
	
	//요구하는 문서 목록내에 문서들의 총 개수
	@Override
	public int getDocumentCnt(Map<String, Object> map) {
		return ddao.selectDocumentCnt(map);
	}

	//조건에 맞는 문서의 목록 가져오기
	@Override
	public List<DocumentVO> getDocumentList(Map<String, Object> map) {
		return ddao.selectDocList(map);
	}
	
	//문서 임시 저장
	@Override
	public void saveDocument(DocumentVO dvo) {
		ddao.insertDocument(dvo);
	}
	
	//선택한 문서 상세보기
	@Override
	public DocumentVO viewNewDoc(int document_no) {
		return ddao.selectDocument(document_no);
	}
}
