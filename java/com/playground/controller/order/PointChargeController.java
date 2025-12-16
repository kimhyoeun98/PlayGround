package com.playground.controller.order;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.framework.Controller;
import com.playground.user.UserDAO;
import com.playground.user.UserVO;

public class PointChargeController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        if (loginUser == null) return "redirect:/login.do";
        
        if ("admin".equals(loginUser.getUserId())) {
            response.setContentType("text/html; charset=UTF-8");
            java.io.PrintWriter out = response.getWriter();
            out.println("<script>alert('관리자는 이용할 수 없는 페이지입니다.'); history.back();</script>");
            out.flush();
            return null; // 더 이상 진행하지 않음
        }
        
        // 1. [GET 방식] 그냥 페이지에 들어온 경우 -> 충전 화면(JSP)을 보여줌
        if (request.getMethod().equalsIgnoreCase("GET")) {
            return "/pointCharge.jsp";
        }
        
        // 2. [POST 방식] 버튼을 눌러서 금액이 넘어온 경우 -> 충전 로직 수행
        String amountStr = request.getParameter("amount");
        
        // 금액이 없으면 다시 선택 화면으로
        if (amountStr == null || amountStr.isEmpty()) {
            return "redirect:/pointCharge.do";
        }
        
        int amount = Integer.parseInt(amountStr);
        
        // DB 업데이트
        UserDAO dao = new UserDAO();
        dao.chargePoint(loginUser.getUserId(), amount);
        
        // 세션 업데이트 (화면 상단 즉시 반영)
        loginUser.setUserPoint(loginUser.getUserPoint() + amount);
        
        // 완료 후 마이페이지로 이동
        return "redirect:/cartList.do";
    }
}