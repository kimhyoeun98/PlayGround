package com.playground.controller.cart;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.cart.CartDAO;
import com.playground.cart.CartVO;
import com.playground.framework.Controller;
import com.playground.user.UserVO;

public class CartAddController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        // 1. 로그인 체크
        if (loginUser == null) {
            return "redirect:/login.do";
        }
        
        // 2. 파라미터 받기
        String gameNoStr = request.getParameter("gameNo");
        if (gameNoStr == null || gameNoStr.isEmpty()) {
            return "redirect:/gameList.do";
        }
        
        int gameNo = Integer.parseInt(gameNoStr);
        String userId = loginUser.getUserId();
        
        CartDAO dao = new CartDAO();
        CartVO vo = new CartVO(userId, gameNo);

        // 3. 중복 체크 (DB 통신)
        // CartDAO에 checkCart(CartVO vo) 메서드가 구현되어 있어야 합니다.
        int checkCount = dao.checkCart(vo); 

        if (checkCount > 0) {
            // 중복 시 메시지를 세션에 담고 상세 페이지로 리다이렉트
            session.setAttribute("msg", "이미 장바구니에 담긴 게임입니다.");
            return "redirect:/gameDetail.do?gameNo=" + gameNo;
        }
        
        // 4. 장바구니 추가 진행
        boolean isSuccess = dao.insert(vo);
        
        if (isSuccess) {
            return "redirect:/cartList.do"; 
        } else {
            session.setAttribute("msg", "장바구니 추가 중 오류가 발생했습니다.");
            return "redirect:/gameDetail.do?gameNo=" + gameNo;
        }
    }
}