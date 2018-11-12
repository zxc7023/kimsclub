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
	
	/**
	 * 전체사원의 휴가를 생성한다.
	 * @param vo
	 */
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
	 * 해당사용자의 휴가 사용 내역을 가져온다
	 * 반려가된 휴가는 제외한다.
	 * @param map 
	 */
	public int selectUseDate(Map<String, Object> map);

	/**
	 * 해당하는 사용자의 휴가신청 내역을 가져온다.
	 * @param vo
	 * @return
	 */
	 public List<DayoffApplyVO> selectApplyList(EmployeeVO vo);

	public List<DayoffApplyVO> selectApplyListWithCriteria(DayoffApplyVO vo);

	public DayoffApplyVO dayoffApplyDetailList(DayoffApplyVO vo);

	public List<DayoffApplyVO> getDayoffEvent(Map<String, Object> map);
}
