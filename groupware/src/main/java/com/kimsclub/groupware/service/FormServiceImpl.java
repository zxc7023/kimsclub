package com.kimsclub.groupware.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.FormDAO;
import com.kimsclub.groupware.vo.BoardPageVO;
import com.kimsclub.groupware.vo.FormVO;

@Service("FormService")
public class FormServiceImpl implements FormService{
	@Autowired
	FormDAO fdao;
	
	@Override
	public List<FormVO> getFormList(Map<String, Object> map) {
		return fdao.selectObjectList(map);
	}
	
	//선택한 양식을 가져옴
	@Override
	public String loadForm(int form_no) {
		return fdao.loadForm(form_no);
	}
	
	//활성화된 양식 목록을 가져옴
	@Override
	public List<FormVO> getUsedFormList() {
		return fdao.selectUsedForm();
	}
	
	@Override
	public void useForm(String activation, String[] form_no) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("activation", activation);
		map.put("form_no",form_no);
		fdao.activationForm(map);
	}

	@Override
	public void deleteForm(String[] form_no) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("form_no",form_no);
		fdao.deleteForm(map);
	}

	@Override
	public void saveForm(FormVO vo) {
		//새 양식 생성
		if(vo.getForm_no()==0) {
			fdao.insertForm(vo);
		}
		
		//양식 수정
		if(vo.getForm_no()!=0) {
			fdao.modifyForm(vo);
		}
	}


	@Override
	public FormVO modifyForm(int form_no) {
		return fdao.selectForm(form_no);
	}


	@Override
	public int getFormCnt(Map<String, Object> map) {
		return fdao.countAticle(map);
	}

}
