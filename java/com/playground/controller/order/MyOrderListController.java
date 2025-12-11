package com.playground.controller.order;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.framework.Controller;
import com.playground.order.OrderDAO;
import com.playground.order.OrderVO;
import com.playground.user.UserVO;

public class MyOrderListController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		if (loginUser == null) return "redirect:/login.do";
		
		// 주문 내역 조회
		OrderDAO dao = new OrderDAO();

		List<OrderVO> list = dao.getMyOrders(loginUser.getUserId());
		
		request.setAttribute("orderList", list);
		
		return "/myOrderList.jsp";
	}
}