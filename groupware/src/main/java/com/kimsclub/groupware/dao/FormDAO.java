package com.kimsclub.groupware.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.FormVO;

@Repository
public class FormDAO {
	@Autowired
	SqlSession session;
	
	public List<FormVO> selectAllForm(){
		return session.selectList("form.selectAllForm");
	}
	
	public void activationForm(Map<String,Object> map){
		session.update("form.updateFormActivation",map);
	}
	
	public void deleteForm(Map<String,Object> map){
		session.delete("form.deleteForm", map);
	}

	public void insertForm(FormVO vo) {
		session.insert("form.insertForm", vo);		
	}

	public List<FormVO> selectUsedForm() {
		return session.selectList("form.selectUsedForm");
	}

	public FormVO selectForm(int form_no) {
		return session.selectOne("form.selectForm", form_no);
	}
}
