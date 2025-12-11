package com.playground.controller.cart;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.cart.CartDAO;
import com.playground.cart.CartVO;
import com.playground.framework.Controller;
import com.playground.user.UserVO;

public class CartListController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		// 1. 로그인 체크
		if (loginUser == null) {
			return "redirect:/login.do";
		}
		
		// 2. 내 장바구니 목록 조회
		CartDAO dao = new CartDAO();
		List<CartVO> cartList = dao.selectMyCart(loginUser.getUserId());
		
		// 3. 총 결제 금액 계산
		int totalPrice = 0;
		for (CartVO cart : cartList) {
			totalPrice += cart.getGamePrice();
		}
		
		// 4. 데이터 저장 후 JSP 이동
		request.setAttribute("cartList", cartList);
		request.setAttribute("totalPrice", totalPrice);
		
		return "/cartList.jsp";
	}
}