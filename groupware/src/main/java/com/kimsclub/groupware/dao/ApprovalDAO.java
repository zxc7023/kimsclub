package com.kimsclub.groupware.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.ApprovalLineVO;

@Repository
public class ApprovalDAO {
	@Autowired
	SqlSession session;
	
	public List<ApprovalLineVO> loadMyApprovalLine(int employee_no) {
		// TODO Auto-generated method stub
		return session.selectList("approvalLine.myApprovalLineList", employee_no);
	}

	public List<ApprovalLineVO> selectMyApprovalLine(int approval_path_no) {
		// TODO Auto-generated method stub
		return session.selectList("selectMyApprovalLine",approval_path_no);
	}
	
	public void saveApproval(int[] approval_approver_no) {
		
	}

}
