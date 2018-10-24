package com.kimsclub.groupware.service;

import java.util.List;
import java.util.Map;

import com.kimsclub.groupware.vo.FormVO;

public interface FormService {
	public List<FormVO> getFormList(Map<String, Object> map);
	public int getFormNum(Map<String,Object> map);
	public void useForm(String activation, String[] form_no);
	public void deleteForm(String[] form_no);
	public void saveForm(FormVO vo);
	public List<FormVO> getUsedFormList();
	public FormVO modifyForm(int form_no);
	
	
}
