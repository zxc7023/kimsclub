package com.kimsclub.groupware.service;

import java.util.ArrayList;
import java.util.List;

import com.kimsclub.groupware.vo.EmployeeVO;
import com.kimsclub.groupware.vo.WorkRecodeVO;

public interface WorkRecodeService {

	List<WorkRecodeVO> getWorkRecodes(EmployeeVO vo);

}
