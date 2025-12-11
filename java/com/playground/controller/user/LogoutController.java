package com.playground.controller.user;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.framework.Controller; 

public class LogoutController implements Controller {
	
    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession(false); 
        
        if(session != null) {
            session.invalidate();
        }
        
        return "redirect:/gameList.do";
    }
}