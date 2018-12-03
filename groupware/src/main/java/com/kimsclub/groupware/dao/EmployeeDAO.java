package com.kimsclub.groupware.dao;

import java.util.List;
import java.util.Map;

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


	public void updatelastLogin(EmployeeVO vo) {
		System.out.println(vo);
		session.update("employee.updateLastLogin",vo);
	}


	public void insertEmployee(EmployeeVO evo) {
		session.insert("employee.insertEmployee",evo);
		
	}


	public List<EmployeeVO> loadAllEmpList(Map<String, Object> map) {
		return session.selectList("employee.loadAllEmpList", map);
	}


	public int getEmployeeCnt(Map<String, Object> map) {
		return session.selectOne("employee.countArticle", map);
	}


	public void modifyEmployeeResult(EmployeeVO evo) {
		session.update("employee.updateEmployee", evo);
		
	}


	public EmployeeVO selectEmloyeeHiredate(EmployeeVO employeeVO) {
		return session.selectOne("employee.selectEmloyeeHiredate", employeeVO);
	}
}
