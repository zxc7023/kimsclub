package com.kimsclub.groupware.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.ApprovalLineVO;
import com.kimsclub.groupware.vo.ApprovalVO;
import com.kimsclub.groupware.vo.DocumentVO;

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
	

}
