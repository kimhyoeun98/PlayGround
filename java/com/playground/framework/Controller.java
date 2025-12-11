package com.playground.framework;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface Controller {
	
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception;
}