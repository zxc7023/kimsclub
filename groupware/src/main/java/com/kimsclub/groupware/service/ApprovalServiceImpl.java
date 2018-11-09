package com.kimsclub.groupware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kimsclub.groupware.dao.ApprovalDAO;
import com.kimsclub.groupware.dao.DocumentDAO;
import com.kimsclub.groupware.dao.EmployeeDAO;
import com.kimsclub.groupware.vo.ApprovalLineVO;
import com.kimsclub.groupware.vo.DocumentVO;
import com.kimsclub.groupware.vo.EmployeeVO;

@Service
public class ApprovalServiceImpl implements ApprovalService {
	@Autowired
	ApprovalDAO adao;
	@Autowired
	EmployeeDAO edao;
	@Autowired
	DocumentDAO ddao;

	@Override
	public List<ApprovalLineVO> loadMyApprovalLine(int employee_no) {
		return adao.loadMyApprovalLine(employee_no);
	}

	@Override
	public List<ApprovalLineVO> selectMyApprovalLine(int approval_path_no) {
		return adao.selectMyApprovalLine(approval_path_no);
	}

	@Override
	public List<EmployeeVO> loadAllEmp() {
		return edao.loadAllEmp();
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void approvalNewDoc(DocumentVO dvo) {
		ddao.changeDocState(dvo);
		adao.insertApproval(dvo.getApproval());
	}
}
