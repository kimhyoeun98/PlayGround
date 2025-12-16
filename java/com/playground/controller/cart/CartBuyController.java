package com.playground.controller.cart;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.framework.Controller;

import java.util.ArrayList;
import java.util.List;

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
	    
	    String[] cartNos = request.getParameterValues("rowCheck");
	    if (cartNos == null || cartNos.length == 0) return "redirect:/cartList.do";
	    
	    CartDAO cartDAO = new CartDAO();
	    OrderDAO orderDAO = new OrderDAO(); 
	    UserDAO userDAO = new UserDAO();
	    
	    // 1. 결제할 대상 리스트를 메모리에 먼저 담기 (DB 조회를 루프 밖으로 뺌)
	    List<CartVO> targetList = new ArrayList<>();
	    int totalPrice = 0;
	    for (String cartNoStr : cartNos) {
	        CartVO cart = cartDAO.selectOne(Integer.parseInt(cartNoStr));
	        totalPrice += cart.getGamePrice();
	        targetList.add(cart);
	    }
	    
	    // 2. 포인트 잔액 체크
	    if (loginUser.getUserPoint() < totalPrice) {
	        session.setAttribute("msg", "포인트가 부족합니다.");
	        return "redirect:/cartList.do"; 
	    }
	    
	    // 3. 결제 처리
	    // 포인트는 한 번만 차감 (DB 부하 대폭 감소)
	    userDAO.payPoint(loginUser.getUserId(), totalPrice); 
	    
	    for (CartVO cart : targetList) {
	        // 주문 생성 및 장바구니 삭제
	        orderDAO.insertOrder(loginUser.getUserId(), cart.getGameNo(), cart.getGamePrice());
	        cartDAO.delete(cart.getCartNo());
	    }
	    
	    // 4. 세션 정보 갱신
	    loginUser.setUserPoint(loginUser.getUserPoint() - totalPrice);
	    
	    return "redirect:/myOrderList.do";
	}
}