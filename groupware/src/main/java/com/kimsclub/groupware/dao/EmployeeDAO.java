package com.kimsclub.groupware.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.EmployeeVO;

@Repository
public class EmployeeDAO {
	@Autowired
	SqlSession session;
	
	public List<EmployeeVO> loadAllEmp(){
		return session.selectList("employee.loadAllEmployee"); 
	}
	
	
	public EmployeeVO login(EmployeeVO vo) {
		return session.selectOne("employee.login",vo);
	}


	public List<EmployeeVO> selectEmployeeList() {
		return session.selectList("employee.selectEmployeeList");
	}
}