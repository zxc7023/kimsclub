package com.kimsclub.groupware.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.kimsclub.groupware.vo.ApprovalVO;
import com.kimsclub.groupware.vo.DayoffApplyDetailVO;
import com.kimsclub.groupware.vo.DayoffApplyVO;
import com.kimsclub.groupware.vo.DayoffCreateRecodeVO;
import com.kimsclub.groupware.vo.DayoffCreateTermsVO;
import com.kimsclub.groupware.vo.DayoffKindsVO;
import com.kimsclub.groupware.vo.DayoffMyRecodeVO;
import com.kimsclub.groupware.vo.EmployeeVO;

@Repository
public class DayoffDAO {

	@Autowired()
	SqlSession session;
	
	@Autowired
	DataSourceTransactionManager transactionManager;

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

	public void applyDayoff(DayoffApplyVO vo) throws Exception {
		DefaultTransactionDefinition def= new DefaultTransactionDefinition();
		def.setName("applyDayoffTransaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus  status = transactionManager.getTransaction(def);
		
		try {
			insertDocument(vo);
			insertApproval(vo.getDocument().getApproval());
			insertDayoffApply(vo);
			insertDayoffApplyDetail(vo.getDayoff_apply_detail());
		}catch (Exception e) {
			transactionManager.rollback(status);
			throw e;
		}
		transactionManager.commit(status);
	}

	public void insertDocument(DayoffApplyVO vo) throws Exception {
		session.insert("dayoff.insertDocument", vo);
	}

	public void insertApproval(List<ApprovalVO> approval) throws Exception  {
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
	
	public void insertDayoffApply(DayoffApplyVO vo) throws Exception  {
		session.insert("dayoff.insertDayoffApply",vo);
	}
	public void insertDayoffApplyDetail(List<DayoffApplyDetailVO> list) throws Exception  {
		for(int i=0; i < list.size() ; i++) {
			session.insert("dayoff.insertDayoffApplyDetail",list.get(i));			
		}
	}

	public int selectUseDate(Map<String, Object> map) {
		return session.selectOne("dayoff.selectUseDate",map);
	}
	
	public List<DayoffApplyVO> selectApplyList(EmployeeVO vo) {
		return session.selectList("dayoff.selectApplyList",vo);
	}

	public List<DayoffApplyVO> selectApplyListWithCriteria(DayoffApplyVO vo) {
		return session.selectList("dayoff.selectApplyListWithCriteria",vo);
	}

	public DayoffApplyVO dayoffApplyDetailList(DayoffApplyVO vo) {
		return session.selectOne("dayoff.dayoffApplyDetailList",vo);
	}

}
