package com.kimsclub.groupware.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kimsclub.groupware.vo.ApprovalVO;
import com.kimsclub.groupware.vo.DayoffApplyVO;
import com.kimsclub.groupware.vo.DocumentVO;

@Repository
public class DocumentDAO {
	@Autowired
	SqlSession session;
	
	//조건에 맞는 문서의 개수
	public int selectDocumentCnt(Map<String, Object> map) {
		return session.selectOne("Document.countArticle",map);
	}
	
	//조건에 맞는 문서 목록 가져오기
	public List<DocumentVO> selectDocList(Map<String,Object> map){
		return session.selectList("Document.selectList",map);
	}
	
	//문서 임시 저장
	public void insertDocument(DocumentVO vo) {
		session.insert("Document.insertDocument", vo);
	}
	
	public DocumentVO selectDocument(int document_no) {
		return session.selectOne("Document.selectDocument", document_no);
	}
	
	public void modifyDoc(DocumentVO dvo) {
		session.update("Document.updateDocument", dvo);
	}
	
	public void deleteDoc(int document_no) {
		session.delete("Document.deleteDocument", document_no);
	}

	public void changeDocState(DocumentVO dvo) {
		session.update("Document.updateDocState", dvo);
	}
	
	
}
