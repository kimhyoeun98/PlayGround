package com.playground.controller.game;

import java.util.List;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.playground.framework.Controller;
import com.playground.game.GameDAO;
import com.playground.game.GameVO;

public class NewGameController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        GameDAO dao = new GameDAO();
        
        // 1. 신제품 목록 가져오기
        List<GameVO> list = dao.selectNewReleases();
        
        // 2. 결과 저장
        request.setAttribute("gList", list);
        
        request.setAttribute("pageTitle", "신규 출시 (최근 7일)");
        
        // 3. 기존 리스트 화면 재활용
        return "/gameList.jsp";
    }
}