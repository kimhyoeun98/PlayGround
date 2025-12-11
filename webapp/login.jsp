<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 - Playground</title>
<style>
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
        background-color: #2a475e; 
        padding: 40px; 
        border-radius: 5px; 
        width: 300px; 
        text-align: center; 
        box-shadow: 0 0 10px rgba(0,0,0,0.5); 
    }
    
    h2 { 
        color: #66c0f4; 
        margin-bottom: 30px; 
        letter-spacing: 2px; 
    }
    
    input {
        width: 100%; 
        padding: 12px; 
        margin: 10px 0; 
        background: #171a21; 
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
    }
    
    button:hover { 
        filter: brightness(1.1); 
    }
    
    .error { 
        color: #ff6b6b;
        margin-top: 15px; 
        font-size: 14px; 
    }
    
    a { 
        color: #c7d5e0; 
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
        <h2>SIGN IN</h2>
        
        <c:if test="${not empty sessionScope.successMsg}">
            <div class="message" style="color: #66c0f4; margin-bottom: 10px;">
                ${sessionScope.successMsg}
            </div>
            <c:remove var="successMsg" scope="session"/>
        </c:if>

        <form action="login.do" method="post">
            <input type="text" name="userId" placeholder="아이디" required>
            <input type="password" name="userPw" placeholder="비밀번호" required>
            <button type="submit">로그인</button>
        </form>
        
        <c:if test="${not empty requestScope.msg}">
            <div class="error">${requestScope.msg}</div>
        </c:if>
        
        <br>
        <a href="gameList.do">메인으로 돌아가기</a>
        <a href="signUp.do" style="margin-left: 20px;">회원가입</a> 
    </div>

</body>
</html>