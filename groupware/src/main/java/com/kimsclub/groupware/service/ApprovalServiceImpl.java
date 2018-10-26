package com.kimsclub.groupware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.FormDAO;
import com.kimsclub.groupware.vo.FormVO;

@Service
public class ApprovalServiceImpl implements ApprovalService {
	@Autowired
	FormDAO dao;
	
	@Override
	public List<FormVO> getUseFormlist() {
		// TODO Auto-generated method stub
		return dao.selectUsedForm();
	}

	@Override
	public String loadForm(int form_no) {
		return dao.loadForm(form_no);
	}

}
