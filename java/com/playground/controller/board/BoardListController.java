package com.playground.controller.board;

import java.util.List;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.playground.framework.Controller;
import com.playground.board.BoardDAO;
import com.playground.board.BoardVO;

public class BoardListController implements Controller {
    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        BoardDAO dao = new BoardDAO();
        List<BoardVO> list = dao.selectAll();
        request.setAttribute("boardList", list);
        return "/boardList.jsp";
    }
}