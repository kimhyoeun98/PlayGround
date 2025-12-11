package com.playground.controller.cart;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.playground.framework.Controller;
import com.playground.cart.CartDAO;
import com.playground.user.UserVO;

public class CartClearController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        if (loginUser != null) {
            CartDAO dao = new CartDAO();
            dao.deleteAllCart(loginUser.getUserId());
        }
        
        return "redirect:/cartList.do";
    }
}