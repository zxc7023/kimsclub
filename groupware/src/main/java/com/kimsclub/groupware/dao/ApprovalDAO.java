package com.kimsclub.groupware.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.ApprovalLineVO;
import com.kimsclub.groupware.vo.ApprovalVO;

@Repository
public class ApprovalDAO {
	@Autowired
	SqlSession session;
	
	public List<ApprovalLineVO> loadMyApprovalLine(int employee_no) {
		return session.selectList("approvalLine.myApprovalLineList", employee_no);
	}

	public List<ApprovalLineVO> selectMyApprovalLine(int approval_path_no) {
		return session.selectList("selectMyApprovalLine",approval_path_no);
	}
	
	public List<ApprovalVO> selectApprovalList(int document_no) {
		return session.selectList("approval.selectApprovalList",document_no);
	}

}
