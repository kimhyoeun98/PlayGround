package com.playground.controller.user;

import java.util.List;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.framework.Controller;
import com.playground.user.UserDAO;
import com.playground.user.UserVO;

public class UserListController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");

        // 관리자 권한 체크
        // 1. 로그인이 되어 있는지 확인
        if (loginUser == null) {
            session.setAttribute("msg", "로그인이 필요한 서비스입니다.");
            return "redirect:/login.do";
        }
        
        // 2. ID가 'admin'인지 확인
        if (!"admin".equals(loginUser.getUserId())) {
            session.setAttribute("msg", "접근 권한이 없습니다. 관리자만 이용 가능합니다.");
            return "redirect:/gameList.do"; // 일반 회원은 메인으로 돌려보냄
        }
        
        // 3. 관리자라면 전체 회원 목록 조회
        UserDAO dao = new UserDAO();
        List<UserVO> userList = dao.selectAll(); 

        // 4. request에 목록 저장
        request.setAttribute("userList", userList);

        // 5. 목록 화면으로 포워드
        return "/userList.jsp"; 
    }
}