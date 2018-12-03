package com.kimsclub.groupware.service;

import java.util.List;
import java.util.Map;

import com.kimsclub.groupware.vo.WorkRecodeVO;
import com.kimsclub.groupware.vo.WorkdaySettingVO;
import com.kimsclub.groupware.vo.WorkhourSettingVO;

public interface WorkService {



	/**
	 * 나의 근태기록을 가져온다
	 * @param map 달력 날짜,로그인 아이디
	 * @return 근무기록 리스트
	 */
	public List<WorkRecodeVO> getMyWorkRecode(Map<String, Object> map);

	public WorkhourSettingVO getWorkhourSetting();

}
