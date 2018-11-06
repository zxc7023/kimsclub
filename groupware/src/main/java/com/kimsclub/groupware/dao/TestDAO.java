package com.kimsclub.groupware.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.DocumentVO;
import com.kimsclub.groupware.vo.FormVO;

@Repository
public class TestDAO {
	@Autowired
	SqlSession session;
	
	public List<FormVO> selectObjectList(Map<String,Object> map){
		return session.selectList("test.selectList",map);
	}
	
	public List<DocumentVO> selectDocList(Map<String,Object> map){
		return session.selectList("document.selectList",map);
	}
	
	
	public int countAticle(Map<String,Object> map) {
		System.out.println("countArticle() 호출");
		return session.selectOne("test.countArticle", map);
	}
}
