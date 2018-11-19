package com.kimsclub.groupware.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.DepartmentVO;

@Repository
public class DepartmentDAO {
	@Autowired
	SqlSession session;
	

	public List<DepartmentVO> getSelectList() {
		return session.selectList("department.selectOrgList");
	}


	public int selectDepartmentSeq() {
		return session.selectOne("department.selectDepartmentSeq");
	}


	public void insertDepartment(DepartmentVO vo) {
		session.insert("department.insertDepartment",vo);
	}


	public void updateDpartmentName(DepartmentVO vo) {
		session.update("department.updateDepartment",vo);
		
	}


	public void deleteDepartments(DepartmentVO vo) {
		session.delete("department.deleteDepartments",vo);
	}


	public DepartmentVO checkChildren(Map<String, Object> map) {
		return session.selectOne("department.checkChildren",map);
	}


	public void changeParentDepartment(Map<String, Object> map) {
		session.update("department.changeParentDepartment",map);
	}

}
