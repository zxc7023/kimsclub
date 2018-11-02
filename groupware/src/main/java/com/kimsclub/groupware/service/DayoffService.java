package com.kimsclub.groupware.service;

import java.util.List;

import com.kimsclub.groupware.vo.DayoffCreateRecodeVO;
import com.kimsclub.groupware.vo.DayoffCreateTermsVO;
import com.kimsclub.groupware.vo.DayoffKindsVO;
import com.kimsclub.groupware.vo.EmployeeVO;

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
	
	
	public List<DayoffKindsVO> getDayoffKinds();

	public void createDayoffkinds(DayoffKindsVO vo);
	
	public void createDayoffTotalEmployee(EmployeeVO vo);
	
	public List<DayoffCreateRecodeVO> getMyCreateRecode(EmployeeVO vo);
	
}
