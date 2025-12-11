package com.playground.controller.game;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.playground.framework.Controller;
import com.playground.game.GameDAO;
import com.playground.game.GameVO;

public class GameListController implements Controller {

    // 번역 사전 (영어 -> 한글)
    private static final Map<String, String> GENRE_MAP = new HashMap<>();
    
    static {
        GENRE_MAP.put("SIMULATION", "시뮬레이션");
        GENRE_MAP.put("ACTION", "액션");
        GENRE_MAP.put("STRATEGY", "전략");
        GENRE_MAP.put("SPORTS", "스포츠");
        GENRE_MAP.put("ADVENTURE", "어드벤처");
        GENRE_MAP.put("HORROR", "공포");
    }

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        GameDAO dao = new GameDAO();
        List<GameVO> list = null;
        
        String keyword = request.getParameter("keyword");
        
        if (keyword != null && !keyword.isEmpty()) {
            
            GameVO searchVO = new GameVO();
            
            // 1. 사용자가 입력한 원래 단어 (예: Simulation)를 이름 칸에 담음
            searchVO.setGameName(keyword);
            
            // 2. 혹시 번역할 수 있는 단어인지 확인
            String koreanGenre = GENRE_MAP.get(keyword.toUpperCase());
            
            if (koreanGenre != null) {
                // 번역된 단어(시뮬레이션)가 있으면 '장르' 칸에 몰래 담아 보냅니다.
                searchVO.setGameGenre(koreanGenre);
                System.out.println(">>> [듀얼 검색] " + keyword + " + " + koreanGenre);
            }
            
            list = dao.selectByFind(searchVO);
            
        } else {
            list = dao.selectAll();
        }
        
        request.setAttribute("gList", list);
        return "/gameList.jsp";
    }
}