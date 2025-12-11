package com.playground.controller.cart;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.playground.cart.CartDAO;
import com.playground.framework.Controller;

public class CartDeleteController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 1. 파라미터 받기 (cartDetail.jsp에서 cartNo를 보냄)
		String cartNoStr = request.getParameter("cartNo");
		
		if (cartNoStr == null || cartNoStr.isEmpty()) {
			return "redirect:/cartList.do";
		}
		
		int cartNo = Integer.parseInt(cartNoStr);
		
		// 2. DAO 호출하여 삭제
		CartDAO dao = new CartDAO();
		dao.delete(cartNo);
		
		// 3. 다시 장바구니 목록으로 돌아가기
		return "redirect:/cartList.do";
	}
}