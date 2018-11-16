package com.kimsclub.groupware.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kimsclub.groupware.vo.ApprovalLineVO;
import com.kimsclub.groupware.vo.ApprovalPathVO;
import com.kimsclub.groupware.vo.DocumentVO;
import com.kimsclub.groupware.vo.EmployeeVO;
import com.kimsclub.groupware.vo.FormVO;


public interface ApprovalService {

	
	List<EmployeeVO> loadAllEmp();

	List<ApprovalLineVO> loadMyApprovalLine(int employee_no);

	List<ApprovalLineVO> selectMyApprovalLine(int approval_path_no);

	void approvalNewDoc(DocumentVO dvo);

	void addFavorite(ApprovalPathVO apvo);
}