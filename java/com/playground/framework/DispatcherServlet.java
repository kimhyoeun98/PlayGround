package com.playground.framework;

import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("*.do")
@MultipartConfig

public class DispatcherServlet extends HttpServlet {

    private HandlerMapping mapping;
    
    @Override
    public void init(ServletConfig config) throws ServletException {
        mapping = new HandlerMapping();
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();
        String context = request.getContextPath();
        uri = uri.substring(context.length()); 
        
        System.out.println("요청 URI : " + uri);
        
        try {
            Controller control = mapping.getController(uri);
            
            if(control != null) {
                String view = control.handleRequest(request, response);
                
                if(view.startsWith("redirect:")) {
                    response.sendRedirect(context + view.substring(9)); 
                } else {
                    RequestDispatcher rd = request.getRequestDispatcher(view);
                    rd.forward(request, response); 
                }
            } else {
                System.out.println("매핑된 컨트롤러가 없습니다: " + uri);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}