package com.playground.controller.game;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.framework.Controller;
import com.playground.game.GameDAO;
import com.playground.user.UserVO;

public class GameDeleteController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
    	
    	
        // 1. 보안 검사: 관리자(admin)가 맞는지 확인
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        if (loginUser == null || !loginUser.getUserId().equals("admin")) {
            // 관리자가 아니면 메인으로 쫓아냄
            session.setAttribute("msg", "관리자만 접근 가능한 기능입니다.");
            return "redirect:/gameList.do";
        }
        
        // 2. 파라미터 받기 (삭제할 게임 번호)
        String gameNoStr = request.getParameter("gameNo");
        
        
        
        if (gameNoStr == null || gameNoStr.isEmpty()) {
            
            return "redirect:/gameList.do";
        }

        
        int gameNo = Integer.parseInt(gameNoStr);
        
        // 3. DAO 호출하여 삭제 (또는 판매 중지) 처리
        GameDAO dao = new GameDAO();
        
                
        dao.delete(gameNo); 
        
        
        // 4. 처리 후 게임 목록으로 이동
        return "redirect:/gameList.do";
    }
}