package com.kimsclub.groupware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.FormDAO;
import com.kimsclub.groupware.vo.FormVO;

@Service("FormService")
public class FormServiceImpl implements FormService{
	@Autowired
	FormDAO dao;
	
	@Override
	public List<FormVO> getFormList() {
		return dao.selectForm();
	}

}
