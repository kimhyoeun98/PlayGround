package com.playground.controller.user;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.framework.Controller;
import com.playground.user.UserDAO;
import com.playground.user.UserVO;

public class UserDeleteController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. 세션에서 로그인 사용자 정보 확인
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");

        // 로그인 체크: 로그인되어 있지 않으면 로그인 페이지로 리다이렉트 
        if (loginUser == null) {
            session.setAttribute("msg", "잘못된 접근입니다. 로그인이 필요합니다.");
            return "redirect:/login.do";
        }
        
        // 2. 삭제할 사용자 ID 추출
        String userId = loginUser.getUserId();
        
        // 3. DAO 호출 (주문 정보와 회원 정보 모두 삭제)
        UserDAO dao = new UserDAO();
        dao.deleteUser(userId); 

        // 4. 세션 무효화 (로그아웃 처리)
        session.invalidate();
        
        // 5. 탈퇴 완료 메시지를 담아 메인 페이지로 리다이렉트
        session = request.getSession(); 
        session.setAttribute("successMsg", "회원 탈퇴가 완료되었습니다. 그동안 이용해 주셔서 감사합니다.");
        
        return "redirect:/login.do"; 
    }
}