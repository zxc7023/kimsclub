package com.kimsclub.groupware.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimsclub.groupware.dao.TransmissionDAO;
import com.kimsclub.groupware.vo.TransmissionVO;

@Service
public class TransmissionServiceImpl implements TransmissionService {
	@Autowired
	TransmissionDAO tdao;
	@Override
	public void sendDocs(List<TransmissionVO> tlist) {
		tdao.sendDocs(tlist);
	}
	@Override
	public List<TransmissionVO> getTransmissionList(Map<String, Object> map) {
		return tdao.getTransmissionList(map);
	}

}
