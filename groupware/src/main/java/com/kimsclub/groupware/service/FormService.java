package com.kimsclub.groupware.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kimsclub.groupware.vo.FormVO;

public interface FormService {
	public List<FormVO> getFormList();
}
