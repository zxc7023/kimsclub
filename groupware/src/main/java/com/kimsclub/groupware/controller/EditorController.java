package com.kimsclub.groupware.controller;

import java.io.IOException;

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
	@RequestMapping(value="/upload", method=RequestMethod.POST)
	public void ckeditorImageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) throws IOException{
		String callback = request.getParameter("CKEditorFuncNum");
		System.out.println(callback);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset-utf-8");

		fileService.ckeditorImageUpload(request, response, upload);

	}
}




/*@Controller
public class EditorController {
    *//**
     * 이미지 업로드
     * @param request
     * @param response
     * @param upload
     *//*
    @RequestMapping(value = "/upload/images", method = RequestMethod.POST)
    public void communityImageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) {
 
        OutputStream out = null;
        PrintWriter printWriter = null;
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
 
        try{
 
            String fileName = upload.getOriginalFilename();
            byte[] bytes = upload.getBytes();
            String realPath = this.getClass().getResource("../../../../../../resources/upload").getPath();
    		String uploadPath =  realPath.substring(1) + fileName;
    		System.out.println(uploadPath);
    		
            out = new FileOutputStream(new File(uploadPath));
            out.write(bytes);
            String callback = request.getParameter("CKEditorFuncNum");
 
            printWriter = response.getWriter();
            String fileUrl = request.getRequestURL()+"/resources/upload"+fileName;//url경로
            http://localhost:8080/groupware/upload/images/캡처1.JPG
            fileUrl = fileUrl.split("/upload")[0];
            System.out.println(fileUrl);
            printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
                    + callback
                    + ",'"
                    + fileUrl
                    + "','이미지를 업로드 하였습니다.'"
                    + ")</script>");
            printWriter.flush();
 
        }catch(IOException e){
            e.printStackTrace();
        } finally {
            try {
                if (out != null) {
                    out.close();
                }
                if (printWriter != null) {
                    printWriter.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
 
        return;
    }
}
*/