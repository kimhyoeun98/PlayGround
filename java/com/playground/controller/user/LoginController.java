package com.playground.controller.user;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.framework.Controller;
import com.playground.user.UserDAO;
import com.playground.user.UserVO;

public class LoginController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. 단순히 로그인 화면을 요청한 경우 (GET 방식)
        if (request.getMethod().equalsIgnoreCase("GET")) {
            return "/login.jsp"; // 로그인 입력 화면으로 이동
        }
        
        // 2. 로그인 버튼을 눌러서 데이터를 보낸 경우 (POST 방식)
        
        // 한글 깨짐 방지 (혹시 모를 상황 대비)
        request.setCharacterEncoding("UTF-8");
        
        // 파라미터 받기 (HTML form의 name 속성과 일치해야 함)
        String userId = request.getParameter("userId");
        String userPw = request.getParameter("userPw");
        
        // DAO를 통해 DB 확인
        UserDAO dao = new UserDAO();
        
        // login 메서드는 성공 시 UserVO 객체, 실패 시 null을 리턴
        UserVO loginUser = dao.login(userId, userPw);
        
        System.out.println("로그인 시도: ID=" + userId + ", PW=" + userPw);
        
        // 로그인 성공 여부에 따른 분기 처리
        if (loginUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loginUser", loginUser); // "loginUser"라는 이름표로 저장
            
            // 로그인 성공 후 게임 목록 페이지로 이동 (redirect 사용)
            return "redirect:/gameList.do"; 
            
        } else {
            // [실패]
            request.setAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
            
            // 다시 로그인 화면을 보여줍니다.
            return "/login.jsp";
        }
    }
}