package com.kimsclub.groupware.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kimsclub.groupware.service.EditorService;

@Controller
public class EditorController {
	@Autowired
	EditorService fileService;
	
	/**
     * 이미지 업로드
     * @param request
     * @param response
     * @param upload
	 * @throws IOException 
     */
	@RequestMapping(value="/upload/ckeditor_upload.asp", method=RequestMethod.POST)
	public void ckeditorImageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) throws IOException{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset-utf-8");
		System.out.println("ckeditorImageUpload 메소드 실행");
		fileService.ckeditorImageUpload(request, response, upload);

	}
}
