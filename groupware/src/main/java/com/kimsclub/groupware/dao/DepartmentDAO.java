package com.kimsclub.groupware.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.DepartmentVO;

@Repository
public class DepartmentDAO {
	@Autowired
	SqlSession session;
	
	public List<DepartmentVO> getDepartmentList(){
		return session.selectList("department.selectOrgList");
	}
}
