package com.kimsclub.groupware.service;

import java.util.List;
import java.util.Map;

import com.kimsclub.groupware.vo.DocumentVO;


public interface DocumentService {
	
	public int getDocumentCnt(Map<String,Object> map);
	
	List<DocumentVO> getDocumentList(Map<String, Object> map);
	
	public void saveDocument(DocumentVO dvo);
	
	DocumentVO viewNewDoc(int document_no);
	
	void modifyDocument(DocumentVO dvo);

	public void deleteNewDoc(int document_no);
}
