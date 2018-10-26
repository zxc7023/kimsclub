package com.kimsclub.groupware.service;

import java.util.List;

import com.kimsclub.groupware.vo.FormVO;

public interface ApprovalService {

	List<FormVO> getUseFormlist();

	String loadForm(int form_no);

}
