package com.kimsclub.groupware.service;

import java.util.List;
import java.util.Map;

import com.kimsclub.groupware.vo.WorkRecodeVO;

public interface WorkRecodeService {

	List<WorkRecodeVO> getWorkRecodes(Map<String, Object> map);

}
