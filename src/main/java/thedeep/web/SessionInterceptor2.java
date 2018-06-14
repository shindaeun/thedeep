package thedeep.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SessionInterceptor2 extends HandlerInterceptorAdapter {

	/*
	 * Controller가 수행되기 전R
	 */
    public boolean preHandle(
    			HttpServletRequest request, 
    			HttpServletResponse response, 
    			Object handler) throws Exception {
        
    	     System.out.println("11111");
    	     HttpSession session = request.getSession();
    	     if(session == null || session.getAttribute("ThedeepALoginCert")==null) {
    	    	 response.sendRedirect("/adminLogin.do");
    	    	 return false;
    	     /*} else if(session.getAttribute("ThedeepALoginCert")==null) {
    	    	 response.sendRedirect("/adminLogin.do");
    	    	 return false;*/
    	     } else {
    	    	 
    	     }
    	     
    	     
        return true;
    }
    
    /*
	 * Controller 수행 후 View를 호출하기 전
	 */
	public void postHandle(
                HttpServletRequest request, 
                HttpServletResponse response, 
                Object handler, 
                ModelAndView modelAndView) throws Exception {
		
		System.out.println("22222");
        	
	}
	
	/*
	 * View 작업 완료 후 호출
	 */
	public void afterCompletion(
                HttpServletRequest request, 
                HttpServletResponse response, 
                Object handler, 
                Exception ex) throws Exception {
		
		System.out.println("33333");
        	
	}
 
}
