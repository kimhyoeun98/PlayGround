package com.playground.controller.board;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.playground.framework.Controller;
import com.playground.board.BoardDAO;
import com.playground.board.BoardVO;
import com.playground.user.UserVO;

public class BoardWriteController implements Controller {
    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");

        // 비회원은 글쓰기 불가 -> 로그인 페이지로
        if (loginUser == null) return "redirect:/login.do";

        // [GET] 글쓰기 폼 보여주기
        if (request.getMethod().equalsIgnoreCase("GET")) {
            return "/boardWrite.jsp";
        }

        // [POST] DB 저장
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        BoardVO vo = new BoardVO();
        vo.setTitle(title);
        vo.setContent(content);
        vo.setWriter(loginUser.getUserId()); // 작성자는 로그인한 사람 ID

        BoardDAO dao = new BoardDAO();
        dao.insertBoard(vo);

        return "redirect:/boardList.do";
    }
}