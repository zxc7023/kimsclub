package com.kimsclub.groupware.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.ApprovalLineVO;
import com.kimsclub.groupware.vo.FormVO;

@Repository
public class FormDAO {
	@Autowired
	SqlSession session;
	
	public List<FormVO> selectObjectList(Map<String,Object> map){
		return session.selectList("Form.selectList",map);
	}
	
	public int countAticle(Map<String,Object> map) {
		return session.selectOne("Form.countArticle", map);
	}
	
	public void activationForm(Map<String,Object> map){
		session.update("Form.updateFormActivation",map);
	}
	
	public void deleteForm(Map<String,Object> map){
		session.delete("Form.deleteForm", map);
	}

	public void insertForm(FormVO vo) {
		session.insert("Form.insertForm", vo);		
	}

	public List<FormVO> selectUsedForm() {
		return session.selectList("Form.selectUsedForm");
	}

	public FormVO selectForm(int form_no) {
		return session.selectOne("Form.selectForm", form_no);
	}
	
	public void modifyForm(FormVO vo) {
		session.update("Form.modifyForm", vo);
	}

	public String loadForm(int form_no) {
		return session.selectOne("Form.loadForm",form_no);
	}
}
