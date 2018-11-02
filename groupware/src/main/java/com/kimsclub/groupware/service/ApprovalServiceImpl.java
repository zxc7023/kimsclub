package com.kimsclub.groupware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.ApprovalDAO;
import com.kimsclub.groupware.dao.EmployeeDAO;
import com.kimsclub.groupware.dao.FormDAO;
import com.kimsclub.groupware.vo.ApprovalLineVO;
import com.kimsclub.groupware.vo.EmployeeVO;
import com.kimsclub.groupware.vo.FormVO;

@Service
public class ApprovalServiceImpl implements ApprovalService {
	@Autowired
	FormDAO fdao;
	@Autowired
	ApprovalDAO adao;
	@Autowired
	EmployeeDAO edao;
	
	@Override
	public List<FormVO> getUseFormlist() {
		// TODO Auto-generated method stub
		return fdao.selectUsedForm();
	}

	@Override
	public String loadForm(int form_no) {
		return fdao.loadForm(form_no);
	}

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
}
