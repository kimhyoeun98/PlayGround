<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SECURITY CHECK</title>
<style>
    /* 배경: 스팀 클라이언트 느낌의 방사형 그라데이션 */
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
    
    /* 로고 영역 */
    .logo-area {
        margin-bottom: 30px;
        text-align: center;
        letter-spacing: 2px;
        font-size: 24px;
        font-weight: bold;
        color: #c7d5e0;
        text-transform: uppercase;
    }

    /* 메인 박스 */
    .login-box { 
        background-color: #181a21; /* 아주 어두운 회색 */
        padding: 40px 50px; 
        border-radius: 4px; /* 스팀은 둥근 정도가 작음 */
        width: 340px; 
        text-align: center; 
        box-shadow: 0 10px 30px rgba(0,0,0,0.5); 
        border: 1px solid #2a313b; /* 미세한 테두리 */
    }
    
    h2 { 
        color: #ffffff; 
        margin: 0 0 20px 0;
        font-size: 22px;
        font-weight: normal; /* 스팀 헤드라인은 보통 얇음 */
        letter-spacing: 0.5px;
        text-transform: uppercase;
    }
    
    p { 
        color: #b8b6b4; /* 톤 다운된 텍스트 */
        margin-bottom: 25px; 
        font-size: 13px; 
        line-height: 1.5;
    }
    
    /*  입력 필드 (핵심: 어둡고 각지게) */
    .input-group {
        text-align: left;
        margin-bottom: 5px;
    }
    
    label {
        color: #1999ff; /* 스팀 특유의 밝은 파랑 라벨 */
        font-size: 12px;
        text-transform: uppercase;
        font-weight: bold;
        display: block;
        margin-bottom: 5px;
        margin-left: 2px;
    }

    input { 
        width: 100%; 
        padding: 10px; 
        margin-bottom: 20px; 
        background-color: #32353c; /* 입력창 배경색 */
        border: 1px solid #101215; /* 안쪽 그림자 느낌의 테두리 */
        color: #e9e9e9; 
        box-sizing: border-box; 
        border-radius: 2px; 
        font-size: 15px;
        transition: border-color 0.2s;
    }
    
    input:focus {
        outline: none;
        border-color: #66c0f4; /* 포커스 시 밝은 파랑 */
        background-color: #393c44;
    }
   
    /* 버튼 (스팀 로그인 버튼 스타일) */
    button { 
        width: 100%; 
        padding: 12px; 
        /* 스팀 블루 그라데이션 */
        background: linear-gradient( to bottom, #47bfff 5%, #308ecb 95%); 
        color: white;
        border: none; 
        border-radius: 2px; 
        cursor: pointer; 
        font-size: 15px; 
        margin-top: 10px; 
        font-weight: normal; 
        text-shadow: 1px 1px 0px rgba(0,0,0,0.3);
        box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    }
    
    button:hover { 
        background: linear-gradient( to bottom, #5bcfff 5%, #3baee0 95%); 
    }
    
    /* 에러 메시지 */
    .error { 
        color: #cfae56; /* 노란빛 도는 경고색 (스팀 스타일) */
        margin-top: 15px; 
        font-size: 13px; 
        background: rgba(0,0,0,0.2);
        padding: 8px;
        border-radius: 2px;
        border: 1px solid #6b582b;
        text-align: center;
    }
    
    /* 취소 링크 */
    .cancel-link {
        display: block;
        margin-top: 25px;
        color: #b8b6b4;
        text-decoration: none;
        font-size: 12px;
        transition: color 0.2s;
    }
   
    .cancel-link:hover { 
        color: #ffffff; 
        text-decoration: underline; 
    }
</style>
</head>
<body>

    <div class="logo-area">PLAYGROUND SECURITY</div>

    <div class="login-box"> 
        <h2>재인증 필요</h2>
        
        <p>
            중요한 개인정보 변경을 위해<br>
            현재 비밀번호를 다시 확인합니다.
        </p>
        
        <form action="<%= path %>/pwCheck.do" method="post">
            <div class="input-group">
                <label for="currentPw">PASSWORD</label>
                <input type="password" id="currentPw" name="currentPw" required autofocus>
            </div>
            
            <button type="submit">인증 확인</button>
        </form>
        
        <c:if test="${not empty requestScope.msg}">
            <div class="error">⚠ ${requestScope.msg}</div>
        </c:if>
        
        <a href="myInfo.do" class="cancel-link">취소</a>
    </div>

</body>
</html>