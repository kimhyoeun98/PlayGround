package com.playground.controller.cart;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.framework.Controller;
import com.playground.cart.CartDAO;
import com.playground.user.UserVO;

public class CartDeleteSelectedController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login.do";
        
        // 1. 체크된 장바구니 번호들(cartNo)을 배열로 받음
        String[] cartNos = request.getParameterValues("rowCheck");
        
        if (cartNos == null || cartNos.length == 0) {
            // 선택된 항목이 없으면 장바구니로 복귀
            session.setAttribute("msg", "삭제할 항목을 선택해 주세요.");
            return "redirect:/cartList.do";
        }
        
        CartDAO cartDAO = new CartDAO();
        int deletedCount = 0;
        
        // 2. 선택된 항목을 하나씩 DB에서 삭제
        for (String cartNoStr : cartNos) {
            int cartNo = Integer.parseInt(cartNoStr);
            cartDAO.delete(cartNo); // 기존에 만든 개별 삭제 메서드 재활용
            deletedCount++;
        }
        
        // 3. 결과 메시지 설정 후 장바구니 목록으로 복귀
        if (deletedCount > 0) {
            session.setAttribute("msg", deletedCount + "개의 상품이 장바구니에서 삭제되었습니다.");
        }
        
        return "redirect:/cartList.do";
    }
}