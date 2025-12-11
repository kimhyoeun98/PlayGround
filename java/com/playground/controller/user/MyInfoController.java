package com.playground.controller.user;

import java.util.List;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.framework.Controller;
import com.playground.order.OrderDAO;
import com.playground.order.OrderVO;
import com.playground.user.UserDAO;
import com.playground.user.UserVO;

public class MyInfoController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        // 1. 로그인 체크 (세션 만료 시 로그인 페이지로)
        if (loginUser == null) {
            return "redirect:/login.do";
        }

        String userId = loginUser.getUserId();
        UserDAO userDAO = new UserDAO();

        
        // [GET] 내 정보 페이지 보여주기
        if (request.getMethod().equalsIgnoreCase("GET")) {
            
            // (1) 회원 상세 정보 조회 (최신 포인트 정보 갱신)
            UserVO myInfo = userDAO.getUser(userId);
            request.setAttribute("myInfo", myInfo);
            
            // (2) 내 구매 내역 조회
            OrderDAO orderDAO = new OrderDAO();
            List<OrderVO> myOrderList = orderDAO.getMyOrders(userId);
            request.setAttribute("myOrderList", myOrderList);
            
            return "/myInfo.jsp";
            
         // [POST] 비밀번호 수정 요청 처리
        } else {
            request.setCharacterEncoding("UTF-8");
            String newPw = request.getParameter("newPw");
            
            if (newPw != null && !newPw.isEmpty()) {
                userDAO.updatePw(userId, newPw);
            }
            
            return "redirect:/myInfo.do";
        }
    }
}