package com.playground.controller.board;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.playground.framework.Controller;
import com.playground.board.BoardDAO;
import com.playground.board.BoardVO;

public class BoardDetailController implements Controller {
    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String noStr = request.getParameter("no");
        int boardNo = Integer.parseInt(noStr);

        BoardDAO dao = new BoardDAO();
        BoardVO vo = dao.selectOne(boardNo); // 조회수 증가 + 데이터 가져오기

        request.setAttribute("board", vo);
        
        // 댓글 목록 가져오기
        com.playground.reply.ReplyDAO replyDAO = new com.playground.reply.ReplyDAO();
        java.util.List<com.playground.reply.ReplyVO> replyList = replyDAO.selectAll(boardNo);
        
        request.setAttribute("replyList", replyList); // 화면에 전달
        
        
        return "/boardDetail.jsp";
    }
}