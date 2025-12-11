package com.playground.controller.user;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.framework.Controller;
import com.playground.user.UserDAO;
import com.playground.user.UserVO;

public class PwUpdateController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");

        // 1. 로그인 체크
        if (loginUser == null) {
            session.setAttribute("msg", "로그인이 필요한 서비스입니다.");
            return "redirect:/login.do";
        }

        // 2. 기존 비밀번호 확인 절차 체크 (보안 토큰)
        Boolean pwCheckSuccess = (Boolean) session.getAttribute("pwCheckSuccess");
        if (pwCheckSuccess == null || !pwCheckSuccess) {
            session.setAttribute("msg", "비밀번호 변경 전, 현재 비밀번호를 먼저 확인해주세요.");
            return "redirect:/pwCheck.do"; 
        }

        // GET 요청 시 화면 이동
        if (request.getMethod().equalsIgnoreCase("GET")) {
            return "/pwUpdate.jsp"; 
        }

        // --- POST 요청 처리 (비밀번호 변경 로직) ---

        // 3. 파라미터 받기
        String newPw = request.getParameter("newPw");
        String newPwCheck = request.getParameter("newPwCheck");

        // 4. 유효성 검사
        if (newPw == null || newPwCheck == null || !newPw.equals(newPwCheck)) {
            request.setAttribute("msg", "새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
            return "/pwUpdate.jsp";
        }
        
        // 5. DB 업데이트
        UserDAO dao = new UserDAO();
        dao.updatePw(loginUser.getUserId(), newPw); 
        

        session.invalidate(); 

        return "/pwUpdateSuccess.jsp"; 
    }
}