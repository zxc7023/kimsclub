package com.kimsclub.groupware.service;

import java.util.List;

import com.kimsclub.groupware.vo.DayoffCreateTermsVO;

public interface DayoffService {
	
	/**
	 * 연차에 해당하는 휴가일수를 불러온다.
	 * @return
	 */
	public List<DayoffCreateTermsVO> getDayoffCreateTerms();
	
	/**
	 * 연차에 해당하는 휴가일수를 수정한다.
	 */
	public void modifyDayoffCreateTerms(List<DayoffCreateTermsVO> list);
}
