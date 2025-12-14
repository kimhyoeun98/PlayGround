package com.playground.controller.order;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.framework.Controller;
import com.playground.order.OrderDAO;
import com.playground.order.OrderVO;
import com.playground.user.UserVO;

public class AdminOrderListController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        // 1. 관리자 권한 체크
        if (loginUser == null || !loginUser.getUserId().equals("admin")) {
            session.setAttribute("msg", "관리자만 접근 가능합니다.");
            return "redirect:/login.do";
        }
        
        // 2. 전체 주문 내역 조회
        OrderDAO orderDAO = new OrderDAO();
        List<OrderVO> orderList = orderDAO.getAllOrders();
        
        // 3. View로 전달
        request.setAttribute("orderList", orderList);
        
        return "/adminOrderList.jsp";
    }
}