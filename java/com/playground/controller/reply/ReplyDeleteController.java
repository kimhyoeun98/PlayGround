package com.playground.controller.reply;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.playground.framework.Controller;
import com.playground.reply.ReplyDAO;

public class ReplyDeleteController implements Controller {
    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        int replyNo = Integer.parseInt(request.getParameter("replyNo"));
        int boardNo = Integer.parseInt(request.getParameter("boardNo")); // 돌아갈 곳 위치 파악용
        
        ReplyDAO dao = new ReplyDAO();
        dao.deleteReply(replyNo);
        
        return "redirect:/boardDetail.do?no=" + boardNo;
    }
}