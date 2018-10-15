package com.kimsclub.groupware.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;


@Service("editorservice")
public class EditorServiceImpl implements EditorService {

	@SuppressWarnings("resource")
	public void ckeditorImageUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile file) throws IOException {
		// TODO Auto-generated method stub
		OutputStream out = null;
		PrintWriter printWriter = null;	
		String fileName = file.getOriginalFilename();
		byte[] bytes = file.getBytes();
		String uploadPath =  "D:/workspace_spring/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/groupware/resources/upload/" + fileName;
		System.out.println(uploadPath);
		out = new FileOutputStream(new File(uploadPath));
		out.write(bytes);
		String callback = request.getParameter("CKEditorFuncNum");
		printWriter = response.getWriter();
		String fileUrl = request.getContextPath()+"/resources/upload/"+fileName; //url 경로
		
		 printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
                 + callback
                 + ",'"
                 + fileUrl
                 + "','이미지를 업로드 하였습니다.'"
                 + ")</script>");
	       printWriter.flush();
	}

}
