package com.kimsclub.groupware.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.EmployeeVO;
import com.kimsclub.groupware.vo.WorkRecodeVO;

@Repository
public class WorkRecodeDAO {

	
	@Autowired
	SqlSession session;
	
	public List<WorkRecodeVO> getWorkRecodes(EmployeeVO vo) {
		return session.selectList("workRecode.selectWorkRecodes",vo);
	}

}
