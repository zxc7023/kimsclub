package com.kimsclub.groupware.service;

import java.util.List;
import java.util.Map;

import com.kimsclub.groupware.vo.DayoffApplyVO;
import com.kimsclub.groupware.vo.DayoffCreateRecodeVO;
import com.kimsclub.groupware.vo.DayoffCreateTermsVO;
import com.kimsclub.groupware.vo.DayoffKindsVO;
import com.kimsclub.groupware.vo.DayoffMyRecodeVO;
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
	

	/**
	 * 나의 생성된 휴가를 조회한다.
	 * @param vo
	 * @return
	 */
	DayoffMyRecodeVO readMyDayoffDays(EmployeeVO vo);
	
	/**
	 * 나의 사용한 휴가내역을 조회한다.
	 * @param vo
	 * @return
	 */
	List<DayoffApplyVO> readUseMyDayoff(EmployeeVO vo);
	
	
	public void applyDayoff(DayoffApplyVO vo);

	/**
	 * 해당사용자의 
	 * @param map 
	 */
	public void selectUseDate(Map<String, Object> map);
}
