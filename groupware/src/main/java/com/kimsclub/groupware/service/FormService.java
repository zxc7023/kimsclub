package com.kimsclub.groupware.service;

import java.util.List;

import com.kimsclub.groupware.vo.FormVO;

public interface FormService {
	public List<FormVO> getFormList();
	public void useForm(String activation, String[] form_no);
	public void deleteForm(String[] form_no);
	public void saveForm(FormVO vo);
	public List<FormVO> getUsedFormList();
	public FormVO modifyForm(int form_no);
}
