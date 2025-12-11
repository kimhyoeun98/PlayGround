package com.playground.controller.game;

import java.util.List;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.playground.framework.Controller;
import com.playground.game.GameDAO;
import com.playground.game.GameVO;

public class BestGameController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        GameDAO dao = new GameDAO();
        
        // 1. 판매량 순(인기순) 목록 가져오기
        List<GameVO> list = dao.selectBestSellers();
        
        // 2. 결과 저장
        request.setAttribute("gList", list);
        
        // 3. 페이지 제목 설정
        request.setAttribute("pageTitle", "최고 인기 제품 (판매량 순)");
        
        return "/gameList.jsp";
    }
}