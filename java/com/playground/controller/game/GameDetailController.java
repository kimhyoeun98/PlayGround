package com.playground.controller.game;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.framework.Controller;
import com.playground.game.GameDAO;
import com.playground.game.GameVO;
import com.playground.user.UserVO;

public class GameDetailController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        String gameNoStr = request.getParameter("gameNo");
        int gameNo = Integer.parseInt(gameNoStr);
        
        GameDAO dao = new GameDAO();
        GameVO vo = dao.selectOne(gameNo);
        
        request.setAttribute("game", vo);
        
        // 로그인한 유저라면, 이 게임을 샀는지 확인!
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        boolean isOwned = false; // 기본값: 안 샀음
        
        if (loginUser != null) {
            // DB에 물어보기: "이 사람이 이 게임 샀나요?"
            isOwned = dao.checkUserOwnership(loginUser.getUserId(), gameNo);
        }
        
        // 결과(true/false)를 화면으로 보냄
        request.setAttribute("isOwned", isOwned);
        
        return "/gameDetail.jsp";
    }
}