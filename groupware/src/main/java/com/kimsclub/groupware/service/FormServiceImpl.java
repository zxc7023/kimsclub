package com.kimsclub.groupware.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.FormDAO;
import com.kimsclub.groupware.dao.TestDAO;
import com.kimsclub.groupware.vo.BoardPageVO;
import com.kimsclub.groupware.vo.FormVO;

@Service("FormService")
public class FormServiceImpl implements FormService{
	@Autowired
	FormDAO dao;
	@Autowired
	TestDAO tdao;
	
	@Override
	public List<FormVO> getFormList(Map<String, Object> map) {
		return tdao.selectObjectList(map);
	}

	
	@Override
	public void useForm(String activation, String[] form_no) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("activation", activation);
		map.put("form_no",form_no);
		dao.activationForm(map);
	}

	@Override
	public void deleteForm(String[] form_no) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("form_no",form_no);
		dao.deleteForm(map);
	}

	@Override
	public void saveForm(FormVO vo) {
		//새 양식 생성
		if(vo.getForm_no()==0) {
			dao.insertForm(vo);
		}
		
		//양식 수정
		if(vo.getForm_no()!=0) {
			dao.modifyForm(vo);
		}
	}

	@Override
	public List<FormVO> getUsedFormList() {
		return dao.selectUsedForm();
	}

	@Override
	public FormVO modifyForm(int form_no) {
		return dao.selectForm(form_no);
	}


	@Override
	public int getFormNum(Map<String, Object> map) {
		return tdao.countAticle(map);
	}

}
