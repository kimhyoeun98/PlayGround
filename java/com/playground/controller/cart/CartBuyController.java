package com.playground.controller.cart;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.framework.Controller;
import com.playground.cart.CartDAO;
import com.playground.cart.CartVO;
import com.playground.order.OrderDAO;
import com.playground.user.UserDAO;
import com.playground.user.UserVO;

public class CartBuyController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login.do";
        
        // 1. 선택된 장바구니 번호 받기
        String[] cartNos = request.getParameterValues("rowCheck");
        
        if (cartNos == null || cartNos.length == 0) {
            return "redirect:/cartList.do";
        }
        
        CartDAO cartDAO = new CartDAO();
        OrderDAO orderDAO = new OrderDAO(); 
        UserDAO userDAO = new UserDAO();
        
        int totalPrice = 0;
        
        // 2. 가격 합산
        for (String cartNoStr : cartNos) {
            int cartNo = Integer.parseInt(cartNoStr);
            CartVO cart = cartDAO.selectOne(cartNo);
            totalPrice += cart.getGamePrice();
        }
        
        // 3. 포인트 잔액 체크 
        if (loginUser.getUserPoint() < totalPrice) {
            // 메시지를 세션에 저장하고, 장바구니 페이지로 다시 이동
            session.setAttribute("msg", "포인트가 부족합니다. (부족금액: " + (totalPrice - loginUser.getUserPoint()) + " P)");
            return "redirect:/cartList.do"; 
        }
        
        // 4. 결제 진행
        for (String cartNoStr : cartNos) {
            int cartNo = Integer.parseInt(cartNoStr);
            CartVO cart = cartDAO.selectOne(cartNo);
            
            orderDAO.insertOrder(loginUser.getUserId(), cart.getGameNo(), cart.getGamePrice());
            userDAO.payPoint(loginUser.getUserId(), cart.getGamePrice());
            cartDAO.delete(cartNo);
        }
        
        // 5. 포인트 갱신 및 이동
        loginUser.setUserPoint(loginUser.getUserPoint() - totalPrice);
        
        return "redirect:/myOrderList.do";
    }
}