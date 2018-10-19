package com.kimsclub.groupware.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.FormVO;

@Repository
public class FormDAO {
	@Autowired
	SqlSession session;
	
	public List<FormVO> selectForm(){
		return session.selectList("form.selectForm");
	}
}
