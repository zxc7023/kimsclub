package com.kimsclub.groupware.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kimsclub.groupware.vo.DayoffCreateConditionVO;

public interface DayoffService {
	
	/**
	 * 연차에 해당하는 휴가일수를 불러온다.
	 * @return
	 */
	public List<DayoffCreateConditionVO> getDayoffCreateCondition();
}
