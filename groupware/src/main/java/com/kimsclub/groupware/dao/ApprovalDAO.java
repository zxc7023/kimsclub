package com.kimsclub.groupware.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kimsclub.groupware.vo.ApprovalLineVO;
import com.kimsclub.groupware.vo.ApprovalPathDetailVO;
import com.kimsclub.groupware.vo.ApprovalPathVO;
import com.kimsclub.groupware.vo.ApprovalVO;

@Repository
public class ApprovalDAO {
	@Autowired
	SqlSession session;
	
	public List<ApprovalLineVO> loadMyApprovalLine(int employee_no) {
		return session.selectList("ApprovalLine.myApprovalLineList", employee_no);
	}

	public List<ApprovalLineVO> selectMyApprovalLine(int approval_path_no) {
		return session.selectList("ApprovalLine.selectMyApprovalLine",approval_path_no);
	}

	public void insertApproval(List<ApprovalVO> alist) {
		for (int i = 0; i < alist.size(); i++) {
			//문서를 바로 기안하기 하였을 때 첫번째 결재자 결재상태로 입력
			if(i==0) {
				session.insert("Approval.insertApprovalFirst", alist.get(i));
			} else if (i == alist.size() - 1) {
				session.insert("Approval.insertApprovalLast", alist.get(i));
			} else {
				session.insert("Approval.insertApproval", alist.get(i));
			}
		}
	}

	public void removeApproval(int document_no) {
		session.delete("Approval.deleteApproval", document_no);
	}

	public void approveApproval(Map<String, Object> map) {
		session.update("Approval.approveApproval", map);
	}

	public int checkComplete(Map<String, Object> map) {
		return session.selectOne("Approval.checkComplete", map);
	}

	public void returnApproval(Map<String, Object> map) {
		session.update("Approval.returnApproval",map);
		
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void addFavorite(ApprovalPathVO apvo) {
		session.insert("Approval.insertAP",apvo);
		for(ApprovalPathDetailVO apdvo: apvo.getApdlist()) {
			session.insert("Approval.insertAPD",apdvo);
		}
		
	}
	

}
