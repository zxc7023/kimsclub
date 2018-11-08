package com.kimsclub.groupware.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kimsclub.groupware.vo.ApprovalVO;
import com.kimsclub.groupware.vo.DayoffApplyVO;
import com.kimsclub.groupware.vo.DayoffCreateRecodeVO;
import com.kimsclub.groupware.vo.DayoffCreateTermsVO;
import com.kimsclub.groupware.vo.DayoffKindsVO;
import com.kimsclub.groupware.vo.DayoffMyRecodeVO;
import com.kimsclub.groupware.vo.DocumentVO;
import com.kimsclub.groupware.vo.EmployeeVO;

@Repository
public class DayoffDAO {

	@Autowired
	SqlSession session;

	public List<DayoffCreateTermsVO> getDayoffCreateTerms() {
		return session.selectList("dayoff.selectCreateTerms");
	}

	public void modifyDayoffCreateTerms(List<DayoffCreateTermsVO> list) {
		for (DayoffCreateTermsVO vo : list) {
			session.update("dayoff.updateCreateTerms", vo);
		}
	}

	public List<DayoffKindsVO> getDayoffKinds() {
		return session.selectList("dayoff.selectDayoffKinds");
	}

	public void insertDayoffKinds(DayoffKindsVO vo) {
		session.insert("dayoff.insertDayoffKinds", vo);
	}

	public List<DayoffCreateRecodeVO> selectEmpDayoffDays() {
		return session.selectList("dayoff.selectEmpDayoffDay");
	}

	public void insertEmpsAnnualDayoff(List<DayoffCreateRecodeVO> empList) {
		for (DayoffCreateRecodeVO vo : empList) {
			session.insert("dayoff.insertAnnualDayoff", vo);
			session.update("dayoff.updateAnualMyRecode", vo);
		}
	}

	public List<DayoffCreateRecodeVO> selectMyDayoffRecode(EmployeeVO vo) {
		return session.selectList("dayoff.selecMytCreateRecode", vo);
	}

	/**
	 * 최종으로 생성된 나의 휴가일수를 가져오기위한 메소드
	 * 
	 * @param vo
	 *            emploee_no가 저장된 vo객체
	 * @return
	 */
	public DayoffMyRecodeVO selectTotalDayoffDays(EmployeeVO vo) {
		return session.selectOne("dayoff.selectDayoffMyRecode", vo);
	}

	public List<DayoffApplyVO> selectDayoffApply(EmployeeVO vo) {
		return session.selectList("dayoff.selectDayoffToUse", vo);
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void applyDayoff(DayoffApplyVO vo) {
		insertDocument(vo);
		insertApproval(vo.getDocument().getApproval());
	}

	public void insertDocument(DayoffApplyVO vo) {
		session.insert("dayoff.insertDocument", vo);
	}

	public void insertApproval(List<ApprovalVO> approval) {
		for (int i = 0; i < approval.size(); i++) {
			if (i == 0) {
				session.insert("dayoff.insertApprovalFirst", approval.get(i));
			} else if (i == approval.size() - 1) {
				session.insert("dayoff.insertApprovalLast", approval.get(i));
			} else {
				session.insert("dayoff.insertApproval", approval.get(i));
			}

		}
	}

}
