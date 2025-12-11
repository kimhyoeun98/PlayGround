package com.playground.controller.board;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.playground.framework.Controller;
import com.playground.board.BoardDAO;

public class BoardDeleteController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. 삭제할 글 번호 받기
        String noStr = request.getParameter("no");
        int boardNo = Integer.parseInt(noStr);
        
        // 2. DAO를 통해 삭제 실행
        BoardDAO dao = new BoardDAO();
        dao.deleteBoard(boardNo);
        
        // 3. 삭제 후 목록으로 이동
        return "redirect:/boardList.do";
    }
}