package com.playground.controller.cart;

import java.io.PrintWriter;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.cart.CartDAO;
import com.playground.cart.CartVO;
import com.playground.framework.Controller;
import com.playground.game.GameDAO;
import com.playground.game.GameVO;
import com.playground.user.UserVO;

public class CartAddController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. 로그인 체크
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        if (loginUser == null) {
            return "redirect:/login.do";
        }
        
        // 2. 파라미터 받기 (gameDetail.jsp에서 넘겨준 gameNo)
        String gameNoStr = request.getParameter("gameNo");
        
        if (gameNoStr == null || gameNoStr.isEmpty()) {
            return "redirect:/gameList.do";
        }
        
        int gameNo = Integer.parseInt(gameNoStr);
        String userId = loginUser.getUserId();
        
        // 3. 게임 정보 조회 (판매 상태 확인용)
        GameDAO gameDAO = new GameDAO();
        GameVO game = gameDAO.selectOne(gameNo);
        
        // 판매 중지된 상품인지 서버에서 한 번 더 체크 (보안)
        if (game != null && game.getStatus() != 1) {
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('판매가 중지된 상품입니다. 구매할 수 없습니다.'); history.back();</script>");
            out.flush();
            return null; // 더 이상 진행하지 않음
        }
        
        // 4. 장바구니 추가 진행
        CartDAO dao = new CartDAO();
        CartVO vo = new CartVO(userId, gameNo);
        
        boolean isSuccess = dao.insert(vo);
        
        // 5. 결과 처리
        if (isSuccess) {
            // 성공 시 장바구니 목록으로 이동 
            return "redirect:/cartList.do"; 
        } else {
            // 이미 담겨있는 경우
            session.setAttribute("msg", "이미 장바구니에 담긴 게임입니다.");
            // 다시 해당 게임 상세 페이지로 이동
            return "redirect:/gameDetail.do?gameNo=" + gameNo;
        }
    }
}