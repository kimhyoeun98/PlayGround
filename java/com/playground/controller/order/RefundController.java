package com.playground.controller.order;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.framework.Controller;
import com.playground.order.OrderDAO;
import com.playground.user.UserVO;

public class RefundController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        if (loginUser == null) return "redirect:/login.do";
        
        // 1. 파라미터 받기 (주문 번호)
        String orderNoStr = request.getParameter("orderNo");
        if (orderNoStr == null || orderNoStr.isEmpty()) {
            return "redirect:/myOrderList.do";
        }
        
        int orderNo = Integer.parseInt(orderNoStr);
        
        // 2. 환불 처리 (DAO 호출)
        OrderDAO dao = new OrderDAO();
        int refundedPrice = dao.refund(orderNo);
        
        // 3. 세션 포인트 갱신 (화면에 바로 반영되도록)
        // 현재 포인트 + 환불된 금액
        loginUser.setUserPoint(loginUser.getUserPoint() + refundedPrice);
        
        System.out.println(">>> [환불 완료] " + refundedPrice + "포인트가 환불되었습니다.");
        
        return "redirect:/myOrderList.do";
    }
}