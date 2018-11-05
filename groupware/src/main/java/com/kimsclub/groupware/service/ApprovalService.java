package com.kimsclub.groupware.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kimsclub.groupware.vo.ApprovalLineVO;
import com.kimsclub.groupware.vo.DocumentVO;
import com.kimsclub.groupware.vo.EmployeeVO;
import com.kimsclub.groupware.vo.FormVO;

@Service
public interface ApprovalService {

	List<FormVO> getUseFormlist();
	
	List<EmployeeVO> loadAllEmp();

	String loadForm(int form_no);

	List<ApprovalLineVO> loadMyApprovalLine(int employee_no);

	List<ApprovalLineVO> selectMyApprovalLine(int approval_path_no);
	
	void saveDocument(Map<String, Object> map);

}