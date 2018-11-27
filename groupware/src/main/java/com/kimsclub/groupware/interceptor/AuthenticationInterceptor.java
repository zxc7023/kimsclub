package com.kimsclub.groupware.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kimsclub.groupware.vo.EmployeeVO;

public class AuthenticationInterceptor extends HandlerInterceptorAdapter {
	
	
	private void saveDest(HttpServletRequest req) {

	    String uri = req.getRequestURI();  //URI

	    String query = req.getQueryString();  //파라미터

	    if (query == null || query.equals("null")) {
	      query = "";
	    } else {
	      query = "?" + query;
	    }

	    if (req.getMethod().equals("GET")) {
	      req.getSession().setAttribute("dest", uri + query);
	    }
	  }
	
	
	// preHandle() : 컨트롤러보다 먼저 수행되는 메서드
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
    	System.out.println("preHandle 호출");
    	
        // session 객체를 가져옴
        HttpSession session = request.getSession();
        // login처리를 담당하는 사용자 정보를 담고 있는 객체를 가져옴
        Object obj = session.getAttribute("loginInfo");
         
        if ( obj == null ){
        	System.out.println("로그인 없는상태 및 destnation 있음");
        	saveDest(request);
            // 로그인이 안되어 있는 상태임으로 로그인 폼으로 다시 돌려보냄(redirect)
            response.sendRedirect(request.getContextPath()+"/login");
            return false; // 더이상 컨트롤러 요청으로 가지 않도록 false로 반환함
        }
         
        // preHandle의 return은 컨트롤러 요청 uri로 가도 되냐 안되냐를 허가하는 의미임
        // 따라서 true로하면 컨트롤러 uri로 가게 됨.
        return true;
    }
 
    // 컨트롤러가 수행되고 화면이 보여지기 직전에 수행되는 메서드
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
    	
    	HttpSession session = request.getSession();    	
    	EmployeeVO empvo = (EmployeeVO) session.getAttribute("loginInfo");
    	String dest = (String) session.getAttribute("dest");
    	session.removeAttribute("dest");
    	
    	//로그인된 상태이고 경로가 있다면 해당 redirect사용
    	if(empvo != null && dest != null) {
    		response.sendRedirect(dest);
    	}
    
    	
    }

	
}
