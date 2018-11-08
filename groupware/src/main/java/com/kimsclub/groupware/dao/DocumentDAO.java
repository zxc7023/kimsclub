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
	
/*	public void insertDocument(DocumentVO dvo) {
		session.insert("document.saveDocument", dvo);
	}*/

	public DocumentVO selectDocument(int document_no) {
		return session.selectOne("document.selectDocument", document_no);
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void applyApprovalDoc(DocumentVO vo) {
		insertDocument(vo);
		insertApproval(vo.getApproval());
	}

	public void insertDocument(DocumentVO vo) {
		session.insert("document.insertDocument", vo);
	}

	public void insertApproval(List<ApprovalVO> approval) {
		for (int i = 0; i < approval.size(); i++) {
			if (i == approval.size() - 1) {
				session.insert("approval.insertApprovalLast", approval.get(i));
			} else {
				session.insert("approval.insertApproval", approval.get(i));
			}
		}
	}
}
