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
		return session.selectList("myApprovalLineList", employee_no);
	}

}
