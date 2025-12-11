package com.playground.controller.game;

import java.io.File;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import com.playground.framework.Controller;
import com.playground.game.GameDAO;
import com.playground.game.GameVO;

public class GameUpdateController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        GameDAO dao = new GameDAO();
        
        // [GET] 수정 화면 보여주기
        if (request.getMethod().equalsIgnoreCase("GET")) {
            String gameNoStr = request.getParameter("gameNo");
            int gameNo = Integer.parseInt(gameNoStr);
            GameVO vo = dao.selectOne(gameNo);
            request.setAttribute("game", vo);
            return "/gameUpdate.jsp";
        }
        
        // [POST] 수정 처리
        System.out.println("========== [수정 요청 시작] ==========");
        
        // 1. 파라미터 확인
        int gameNo = Integer.parseInt(request.getParameter("gameNo"));
        String oldGameImg = request.getParameter("oldGameImg");
        System.out.println(">>> 1. 기존 이미지 파일명: " + oldGameImg);

        // 2. 파일 처리
        String savePath = request.getServletContext().getRealPath("/upload");
        String newFileName = oldGameImg; // 기본값: 기존 파일 유지

        Part filePart = request.getPart("gameImgFile");
        
        if (filePart != null && filePart.getSize() > 0) {
            // 새 파일이 들어옴!
            newFileName = filePart.getSubmittedFileName();
            System.out.println(">>> 2. [NEW] 새 이미지 감지됨! 파일명: " + newFileName);
            
            // 저장 폴더 없으면 생성
            File dir = new File(savePath);
            if (!dir.exists()) dir.mkdirs();
            
            // 파일 저장
            filePart.write(savePath + File.separator + newFileName);
            System.out.println(">>> 3. 파일 저장 성공: " + savePath);
        } else {
            System.out.println(">>> 2. [SKIP] 새 이미지가 없음. 기존 이미지 유지.");
        }

        // 3. DB 업데이트 준비
        GameVO vo = new GameVO();
        vo.setGameNo(gameNo);
        vo.setGameName(request.getParameter("gameName"));
        vo.setGameGenre(request.getParameter("gameGenre"));
        vo.setGameDev(request.getParameter("gameDev"));
        vo.setGamePrice(Integer.parseInt(request.getParameter("gamePrice")));
        vo.setGameDesc(request.getParameter("gameDesc"));
        vo.setStatus(Integer.parseInt(request.getParameter("status")));
        
        // 여기서 최종 파일명이 들어가는지 확인
        vo.setGameImg(newFileName); 
        System.out.println(">>> 4. DB에 들어갈 최종 파일명: " + newFileName);
        
        // 4. DB 실행
        dao.update(vo);
        System.out.println("========== [수정 요청 종료] ==========");
        
        return "redirect:/gameDetail.do?gameNo=" + gameNo;
    }
}