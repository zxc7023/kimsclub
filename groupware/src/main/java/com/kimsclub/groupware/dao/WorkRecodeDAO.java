package com.kimsclub.groupware.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimsclub.groupware.vo.WorkRecodeVO;
import com.kimsclub.groupware.vo.WorkSettingVO;

@Repository
public class WorkRecodeDAO {

	
	@Autowired
	SqlSession session;
	
	public List<WorkRecodeVO> getWorkRecodes(Map<String, Object> map) {
		return session.selectList("workRecode.selectWorkRecodes",map);
	}

	public WorkSettingVO getWorkSetting() {
		return session.selectOne("workRecode.selectWorkSetting");
	}

}
