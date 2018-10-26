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
	
	public List<DepartmentVO> getDepartments(){
		return session.selectList("department.selectOrgList");
	}
	public List<DepartmentVO> getSelectList() {
		return session.selectList("department.selectList");
	}

	public int[] getMaxSize() {
		int[] size = new int[2];
		size[0] = session.selectOne("department.selectMaxLevel");
		size[1] = session.selectOne("department.selectMaxLeaf");
		return size;
	}
}
