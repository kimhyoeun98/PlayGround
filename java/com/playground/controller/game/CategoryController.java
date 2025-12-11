package com.playground.controller.game;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.playground.framework.Controller;

public class CategoryController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 카테고리 선택 화면으로 이동
        return "/category.jsp";
    }
}