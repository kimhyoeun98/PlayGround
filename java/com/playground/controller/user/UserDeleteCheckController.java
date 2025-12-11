package com.playground.controller.user;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.framework.Controller;
import com.playground.user.UserDAO;
import com.playground.user.UserVO;

public class UserDeleteCheckController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");

        // 1. 로그인 체크
        if (loginUser == null) {
            session.setAttribute("msg", "잘못된 접근입니다. 로그인이 필요합니다.");
            return "redirect:/login.do";
        }


        if (request.getMethod().equalsIgnoreCase("GET")) {
            return "/userDeleteCheck.jsp"; 
        }
        
        
        String userId = loginUser.getUserId();
        
        // 관리자 계정(admin) 삭제 시도 차단
        if ("admin".equals(userId)) {
            request.setAttribute("msg", "관리자 계정은 삭제할 수 없습니다.");
            // 관리자 권한으로 로그인했으니 세션을 유지하고 폼으로 돌려보냄
            return "/userDeleteCheck.jsp"; 
        }

        // 2. 입력된 비밀번호 가져오기
        String inputPw = request.getParameter("userPw");
        

        // 3. DAO를 통해 비밀번호 검증 (로그인 로직 재사용)
        UserDAO dao = new UserDAO();
        UserVO verifiedUser = dao.login(userId, inputPw); // ID와 입력된 PW로 재로그인 시도

        if (verifiedUser == null) {
            // 검증 실패
            request.setAttribute("msg", "비밀번호가 일치하지 않습니다.");
            return "/userDeleteCheck.jsp"; // 다시 폼으로 돌아감
        }

        // 4. 검증 성공 -> 탈퇴 진행 
        
        // 주문 정보 및 회원 정보 삭제
        dao.deleteUser(userId); 

        // 세션 무효화 (로그아웃 처리)
        session.invalidate();
        
        // 탈퇴 완료 메시지를 담아 로그인 페이지로 리다이렉트
        session = request.getSession(); 
        session.setAttribute("successMsg", "회원 탈퇴가 완료되었습니다. 그동안 이용해 주셔서 감사합니다.");
        
        return "redirect:/login.do";
    }
}