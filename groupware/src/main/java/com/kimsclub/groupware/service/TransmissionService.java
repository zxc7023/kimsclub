package com.kimsclub.groupware.service;

import java.util.List;
import java.util.Map;

import com.kimsclub.groupware.vo.TransmissionVO;

public interface TransmissionService {

	void sendDocs(List<TransmissionVO> tlist);

	List<TransmissionVO> getTransmissionList(Map<String, Object> map);

	void sendPublicDoc(TransmissionVO tvo);

}
