package com.kimsclub.groupware.service;

import java.util.List;

import com.kimsclub.groupware.vo.TransmissionVO;

public interface TransmissionService {

	void sendDocs(List<TransmissionVO> tlist);

}
