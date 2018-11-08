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
		insertApproval(vo);
	}

	public void insertDocument(DocumentVO vo) {
		session.insert("document.insertDocument", vo);
	}
	public void updateDocument(DocumentVO vo) {
		session.update("document.updateDocument", vo);
	}

	public void insertApproval(DocumentVO vo) {
		for (int i = 0; i < vo.getApproval().size(); i++) {
			//문서를 바로 기안하기 하였을 때 첫번째 결재자 결재상태로 입력
			System.out.println(vo.getApproval().get(i).getApproval_state());
			if(i==0&& vo.getDocument_state()==1) {
				session.insert("approval.insertApprovalFirst", vo.getApproval().get(i));
			} else if (i == vo.getApproval().size() - 1) {
				session.insert("approval.insertApprovalLast", vo.getApproval().get(i));
			} else {
				session.insert("approval.insertApproval", vo.getApproval().get(i));
			}
		}
	}
	public void updateApproval(DocumentVO vo) {
		for (int i = 0; i < vo.getApproval().size(); i++) {
			//문서를 바로 기안하기 하였을 때 첫번째 결재자 결재상태로 입력
			System.out.println(vo.getApproval().get(i).getApproval_state());
			if(i==0&& vo.getDocument_state()==1) {
				session.insert("approval.updateApprovalFirst", vo.getApproval().get(i));
			} else if (i == vo.getApproval().size() - 1) {
				session.insert("approval.updateApprovalLast", vo.getApproval().get(i));
			} else {
				session.insert("approval.updateApproval", vo.getApproval().get(i));
			}
		}
	}
	public void modifyApprovalDoc(DocumentVO dvo) {
		// TODO Auto-generated method stub
		
	}
}
