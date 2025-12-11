package com.playground.controller.user;

import com.playground.framework.Controller;
import com.playground.user.UserDAO;
import com.playground.user.UserVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class PwCheckController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		if (loginUser == null) {
			session.setAttribute("msg","로그인이 필요한 서비스입니다.");
			return "redirect:/login.do";
			
		}
		
		if (request.getMethod().equalsIgnoreCase("GET")) {
            return "/pwCheck.jsp"; // 비밀번호 확인 화면으로 이동
        }

        // 2. 입력된 비밀번호 가져오기
        String inputPw = request.getParameter("currentPw"); // 폼에서 입력받을 필드명
        String userId = loginUser.getUserId();

        // 3. DAO를 통해 비밀번호 검증 (로그인 로직 재사용)
        UserDAO dao = new UserDAO();
        UserVO verifiedUser = dao.login(userId, inputPw); // ID와 입력된 PW로 재로그인 시도

        if (verifiedUser == null) {
            // 검증 실패
            request.setAttribute("msg", "현재 비밀번호가 일치하지 않습니다.");
            return "/pwCheck.jsp"; // 다시 폼으로 돌아감
        }

        // 4. 검증 성공 -> 비밀번호 변경 폼으로 리다이렉트
        
        // 검증이 성공했음을 세션에 표시 (일회성 토큰 역할)
        session.setAttribute("pwCheckSuccess", true);
        
        // 새 비밀번호 입력 화면으로 이동
        return "redirect:/pwUpdate.do"; 
    }

}
