package com.playground.controller.game;

import java.io.File;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import com.playground.framework.Controller;
import com.playground.game.GameDAO;
import com.playground.game.GameVO;
import com.playground.user.UserVO;

public class GameAddController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. 관리자 체크 (공통)
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null || !loginUser.getUserId().equals("admin")) {
            return "redirect:/gameList.do";
        }

        // GET 방식이면 -> 등록 폼 페이지(JSP)만 보여주고 끝낸다.
        if (request.getMethod().equalsIgnoreCase("GET")) {
            return "/gameRegister.jsp"; 
        }
        
        // POST 방식 일 때
        // 2. 파일 저장 경로 설정
        String savePath = request.getServletContext().getRealPath("/upload");
        File dir = new File(savePath);
        if (!dir.exists()) dir.mkdirs();

        // 3. 파일 업로드 처리
        Part filePart = request.getPart("gameImgFile");
        String fileName = "";
        
        if (filePart != null && filePart.getSize() > 0) {
            String originalName = filePart.getSubmittedFileName();
            fileName = originalName; 
            
            // 파일 저장
            filePart.write(savePath + File.separator + fileName);
        }

        // 4. 일반 데이터 받기
        String gameName = request.getParameter("gameName");
        String gameGenre = request.getParameter("gameGenre");
        String gameDev = request.getParameter("gameDev");
        String priceStr = request.getParameter("gamePrice");
        int gamePrice = (priceStr == null || priceStr.isEmpty()) ? 0 : Integer.parseInt(priceStr);
        String gameDesc = request.getParameter("gameDesc");
        
        // 5. DB 저장
        GameVO vo = new GameVO();
        vo.setGameName(gameName);
        vo.setGameGenre(gameGenre);
        vo.setGameDev(gameDev);
        vo.setGamePrice(gamePrice);
        vo.setGameDesc(gameDesc);
        vo.setGameImg(fileName);
        
        GameDAO dao = new GameDAO();
        dao.insert(vo); 
        
        return "redirect:/gameList.do";
    }
}