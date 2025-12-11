package com.playground.controller.order;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.cart.CartDAO;
import com.playground.cart.CartVO;
import com.playground.framework.Controller;
import com.playground.order.OrderDAO;
import com.playground.order.OrderVO;
import com.playground.user.UserVO;

public class OrderController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. 로그인 체크
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        if (loginUser == null) {
            return "redirect:/login.do";
        }
        
        String userId = loginUser.getUserId();
        
        // 2. 장바구니 목록 가져오기
        CartDAO cartDao = new CartDAO();
        List<CartVO> cartList = cartDao.selectMyCart(userId);
        
        if (cartList == null || cartList.isEmpty()) {
            return "redirect:/gameList.do";
        }
        
        // 총 결제 금액 계산 
        int totalAmount = 0;
        for (CartVO cart : cartList) {
            totalAmount += cart.getGamePrice();
        }
        
        // 잔액 확인 
        if (loginUser.getUserPoint() < totalAmount) {
            // 돈이 부족하면 장바구니로 돌려보내고 메시지 띄움 
            session.setAttribute("msg", "포인트가 부족합니다! (잔액: " + loginUser.getUserPoint() + "원)");
            return "redirect:/cartList.do";
        }
        
        // 3. 주문 처리 시작
        OrderDAO orderDao = new OrderDAO();
        
        for (CartVO cart : cartList) {
            // A. 주문 내역 저장
            OrderVO order = new OrderVO();
            order.setUserId(userId);
            order.setGameNo(cart.getGameNo());
            order.setOrderPrice(cart.getGamePrice());
            orderDao.insertOrder(order);
            
            // B. 장바구니 삭제
            cartDao.delete(cart.getCartNo());
        }
        
        // 4. 포인트 차감
        orderDao.deductPoint(userId, totalAmount);
        
        // 5. 세션(화면)에 보이는 포인트도 갱신
        loginUser.setUserPoint(loginUser.getUserPoint() - totalAmount);
        
        System.out.println(">>> [결제 성공] 총 " + totalAmount + "원 차감 완료.");
        
        return "redirect:/myOrderList.do";
    }
}