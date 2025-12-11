package com.playground.controller.reply;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.playground.framework.Controller;
import com.playground.reply.ReplyDAO;
import com.playground.reply.ReplyVO;
import com.playground.user.UserVO;

public class ReplyAddController implements Controller {
    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        // 로그인 안 했으면 쫓아내기
        if(loginUser == null) return "redirect:/login.do";
        
        // 파라미터 받기
        int boardNo = Integer.parseInt(request.getParameter("boardNo"));
        String content = request.getParameter("content");
        
        // VO 담기
        ReplyVO vo = new ReplyVO();
        vo.setBoardNo(boardNo);
        vo.setContent(content);
        vo.setWriter(loginUser.getUserId());
        
        // DB 저장
        ReplyDAO dao = new ReplyDAO();
        dao.insertReply(vo);
        
        // 다시 그 게시글 상세 페이지로 복귀
        return "redirect:/boardDetail.do?no=" + boardNo;
    }
}