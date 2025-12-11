package com.playground.controller.user;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.framework.Controller;
import com.playground.user.UserDAO;
import com.playground.user.UserVO;

public class SignUpController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. GET 요청: 회원가입 폼 화면 보여주기
        if (request.getMethod().equalsIgnoreCase("GET")) {
            return "/signUp.jsp"; 
        }
        
        request.setCharacterEncoding("UTF-8");
        
        // A. 폼 데이터 받기
        String userId = request.getParameter("userId");
        String userPw = request.getParameter("userPw");
        String userName = request.getParameter("userName");
        String userEmail = request.getParameter("userEmail");
        String userPhone = request.getParameter("userPhone"); 
        String userAddr = request.getParameter("userAddr");
        
        // B. VO 객체 생성 및 포장
        UserVO user = new UserVO(userId, userPw, userName, userEmail, userPhone, userAddr);
        
        // C. DAO를 통해 DB 처리
        UserDAO dao = new UserDAO();
        
        // DAO의 signUp 메서드가 -1(중복), 1(성공)을 리턴합니다.
        int result = dao.signUp(user);
        
        if (result == -1) {
            // 중복 아이디 처리
            request.setAttribute("msg", "이미 사용 중인 아이디입니다. 다른 아이디를 사용해주세요.");
            return "/signUp.jsp";
            
        } else if (result == 1) {
            // 가입 성공
        	HttpSession session = request.getSession();
            session.setAttribute("successMsg", "회원가입이 성공적으로 완료되었습니다! 로그인해 주세요.");       
            
           
            return "redirect:/login.do"; 
            
            
        } else {
            // 기타 DB 오류 (0이 리턴되거나 알 수 없는 오류)
            request.setAttribute("msg", "회원가입 처리 중 알 수 없는 오류가 발생했습니다.");
            return "/signUp.jsp"; 
        }
    }
}