package com.playground.controller.user;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.playground.framework.Controller;
import com.playground.user.UserDAO;
import com.playground.user.UserVO;

public class LoginProcessController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 1. 로그인 화면에서 보낸 아이디, 비번 받기
		String userId = request.getParameter("userId");
		String userPw = request.getParameter("userPw");
		
		// 2. UserDAO를 불러서 확인하기
		UserDAO dao = new UserDAO();
		
		// DAO에 만들어두신 login(String, String) 메서드 호출
		UserVO user = dao.login(userId, userPw); 
		
		// 3. 로그인 성공/실패 여부에 따라 처리
		if(user != null) {
			// [성공]
			// 세션(Session)에 로그인 정보 저장 
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
			
			// 메인 화면으로 이동 (리다이렉트)
			return "redirect:/gameList.do";
			
		} else {
			// [실패]
			// 다시 로그인 화면으로 보내면서 에러 표시
			return "redirect:/login.do?error=1";
		}
	}
}