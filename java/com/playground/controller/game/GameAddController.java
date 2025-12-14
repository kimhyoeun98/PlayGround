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

        // 3. 파일 업로드 처리 (기존 로직 유지)
        Part filePart = request.getPart("gameImgFile");
        String fileName = "";
        
        if (filePart != null && filePart.getSize() > 0) {
            String originalName = filePart.getSubmittedFileName();
            fileName = originalName; 
            filePart.write(savePath + File.separator + fileName);
        }

        // 4. 일반 데이터 받기
        String gameName = request.getParameter("gameName");
        String gameGenre = request.getParameter("gameGenre");
        String gameDev = request.getParameter("gameDev");
        String priceStr = request.getParameter("gamePrice");
        int gamePrice = (priceStr == null || priceStr.isEmpty()) ? 0 : Integer.parseInt(priceStr);
        String gameDesc = request.getParameter("gameDesc");
        
        // 5. GameVO 생성 및 중복 체크 준비
        GameVO vo = new GameVO();
        vo.setGameName(gameName);
        vo.setGameGenre(gameGenre);
        vo.setGameDev(gameDev);
        vo.setGamePrice(gamePrice);
        vo.setGameDesc(gameDesc);
        vo.setGameImg(fileName);
        
        GameDAO dao = new GameDAO();
        
        // 🚨 [핵심] 6. 중복 게임 조회 시도
        GameVO existingGame = dao.selectDuplicate(vo);
        
        if (existingGame != null) {
            // 중복된 게임이 있다면, 해당 정보를 request에 담고 JSP로 포워딩
            // 등록 폼 JSP에서 'duplicateGame' 객체를 이용해 기존 정보를 보여줄 수 있습니다.
            request.setAttribute("duplicateGame", existingGame);
            request.setAttribute("inputGame", vo); // 사용자가 입력한 데이터도 넘겨줌
            request.setAttribute("msg", "[" + gameName + "]과 동일한 게임이 이미 등록되어 있습니다.");
            
            // 기존 등록 폼 JSP로 포워딩하여 중복 정보를 표시하고 사용자에게 확인 요청
            return "/gameRegister.jsp";
        }
        
        // 7. 중복이 없으면 삽입 진행
        dao.insert(vo); 
        
        return "redirect:/gameList.do";
    }
}