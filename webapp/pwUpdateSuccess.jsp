<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>변경 완료</title>
<style>
    /* 배경: 보안 흐름(pwCheck -> pwUpdate)과 동일한 방사형 그라데이션 */
    body { 
        background: radial-gradient(circle at center, #2b3e50 0%, #1b2838 100%);
        color: #c7d5e0; 
        font-family: "Motiva Sans", Arial, Helvetica, sans-serif; 
        display: flex; 
        flex-direction: column;
        justify-content: center; 
        align-items: center; 
        height: 100vh; 
        margin: 0; 
    }

    /* 상단 로고 텍스트 */
    .logo-area {
        margin-bottom: 30px;
        text-align: center;
        letter-spacing: 2px;
        font-size: 24px;
        font-weight: bold;
        color: #c7d5e0;
        text-transform: uppercase;
    }

    /* 메인 컨테이너 */
    .success-box { 
        background-color: #181a21; /* 짙은 회색 배경 */
        padding: 50px 40px; 
        border-radius: 4px; 
        width: 360px; 
        text-align: center; 
        box-shadow: 0 10px 30px rgba(0,0,0,0.5); 
        border: 1px solid #2a313b; 
    }
    
    /* 성공 아이콘 (스팀 도전과제 느낌) */
    .success-icon {
        width: 60px;
        height: 60px;
        border: 3px solid #a3cf06; /* 스팀 그린 */
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 25px auto;
        color: #a3cf06;
        font-size: 30px;
        font-weight: bold;
        box-shadow: 0 0 15px rgba(163, 207, 6, 0.2);
    }
    
    h2 { 
        color: #ffffff; 
        margin: 0 0 15px 0;
        font-size: 24px;
        font-weight: normal; 
        text-transform: uppercase;
        letter-spacing: 1px;
    }
    
    p { 
        color: #8f98a0; 
        margin-bottom: 35px; 
        font-size: 14px; 
        line-height: 1.6;
    }
    
    .highlight {
        color: #66c0f4; /* 스팀 블루 */
        font-weight: bold;
    }

    /* 로그인 버튼 (일관성 유지) */
    button { 
        width: 100%; 
        padding: 13px; 
        background: linear-gradient( to bottom, #47bfff 5%, #308ecb 95%); 
        color: white;
        border: none; 
        border-radius: 2px; 
        cursor: pointer; 
        font-size: 15px; 
        font-weight: normal; 
        text-shadow: 1px 1px 0px rgba(0,0,0,0.3);
        box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        letter-spacing: 0.5px;
    }
    
    button:hover { 
        background: linear-gradient( to bottom, #5bcfff 5%, #3baee0 95%); 
    }
    
</style>
</head>
<body>

    <div class="logo-area">PLAYGROUND SECURITY</div>

    <div class="success-box"> 
        
        <div class="success-icon">✔</div>

        <h2>SUCCESS!</h2>
        
        <p>
            비밀번호가 안전하게 변경되었습니다.<br>
            <span class="highlight">다시 로그인</span>하여 서비스를 이용해 주세요.
        </p>
        
        <form action="<%= path %>/login.do" method="get">
            <button type="submit">SIGN IN</button>
        </form>
        
    </div>

</body>
</html>