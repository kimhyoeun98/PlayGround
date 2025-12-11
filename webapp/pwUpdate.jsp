<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 비밀번호 입력</title>
<style>
    /* 스팀 다크 테마 기반 스타일 */
    body { 
        background-color: #1b2838; 
        color: #c7d5e0; 
        font-family: Arial, sans-serif; 
        display: flex; 
        justify-content: center; 
        align-items: center; 
        height: 100vh; 
        margin: 0; 
    }
    .login-box { 
        background-color: #171a21; /* 배경을 더 어둡게 */
        padding: 40px; 
        border-radius: 5px; 
        width: 350px; 
        text-align: center; 
        box-shadow: 0 0 15px rgba(0,0,0,0.7); 
    }
    
    h2 { 
        color: #66c0f4; /* 스팀 블루 */
        margin-bottom: 25px; 
        border-bottom: 1px solid #335470;
        padding-bottom: 10px;
        font-size: 24px;
    }
    
    p { 
        color: #99c0e0; 
        margin-bottom: 30px; 
        font-size: 14px; 
    }
    
    input { 
        width: 100%; 
        padding: 12px; 
        margin: 10px 0; 
        background: #1b2838; 
        border: 1px solid #4582a5; 
        color: white; 
        box-sizing: border-box; 
        border-radius: 3px; 
    }
    
    input:focus {
        outline: none;
        border-color: #66c0f4;
    }
   
    button { 
        width: 100%; 
        padding: 12px; 
        background: linear-gradient(to right, #47bfff, #1a44c2); 
        color: white;
        border: none; 
        border-radius: 3px; 
        cursor: pointer; 
        font-size: 16px; 
        margin-top: 20px; 
        font-weight: bold; 
        transition: filter 0.2s;
    }
    
    button:hover { 
        filter: brightness(1.1); 
    }
    
    .error { 
        color: #ff6b6b; 
        margin-top: 15px; 
        font-size: 14px; 
        background: #333;
        padding: 5px;
        border-radius: 3px;
    }
    
    a { 
        color: #b8b6b4; 
        text-decoration: none; 
        font-size: 13px; 
        margin-top: 15px; 
        display: inline-block;
    }
   
    a:hover { 
        color: white; 
        text-decoration: underline; 
    }
</style>
</head>
<body>

   <div class="login-box"> 
        <h2>새 비밀번호 입력</h2>
        
        <p>새로운 비밀번호를 입력해 주세요.</p>
        <p>변경 후 보안을 위해 로그아웃됩니다.</p>
        
        <form action="<%= path %>/pwUpdate.do" method="post">
            <input type="password" name="newPw" placeholder="새 비밀번호" required>
            <input type="password" name="newPwCheck" placeholder="새 비밀번호 확인" required>
            <button type="submit">비밀번호 변경</button>
        </form>
        
        <c:if test="${not empty requestScope.msg}">
            <div class="error">${requestScope.msg}</div>
        </c:if>
        
        <br>
        <a href="myInfo.do">취소하고 돌아가기</a>
    </div>

</body>
</html>