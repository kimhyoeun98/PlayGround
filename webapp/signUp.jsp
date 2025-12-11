<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - Playground</title>
<style>
    body { 
        background-color: #1b2838; 
        color: #c7d5e0; 
        font-family: Arial, sans-serif; 
        display: flex; 
        justify-content: center; 
        align-items: center; 
        min-height: 100vh; 
        margin: 0; 
    }
    .register-box { 
        background-color: #2a475e; 
        padding: 40px; 
        border-radius: 5px; 
        width: 400px; 
        box-shadow: 0 0 15px rgba(0,0,0,0.7); 
    }
    h2 { 
        color: #66c0f4; 
        margin-bottom: 30px; 
        text-align: center;
    }
    label {
        display: block;
        text-align: left;
        margin-top: 15px;
        margin-bottom: 5px;
        font-weight: bold;
        font-size: 14px;
    }
    input {
        width: 100%; 
        padding: 10px; 
        background: #171a21; 
        border: 1px solid #4582a5; 
        color: white; 
        box-sizing: border-box; 
        border-radius: 3px; 
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
        margin-top: 30px; 
        font-weight: bold; 
    }
    .message { 
        color: #ff6b6b;
        margin-top: 15px; 
        text-align: center;
        font-weight: bold;
    }
    .sub-link {
        margin-top: 20px;
        text-align: center;
    }
    .sub-link a {
        color: #c7d5e0; 
        text-decoration: none;
        font-size: 13px;
    }
</style>
</head>
<body>

    <div class="register-box">
        <h2>회원가입 (CREATE ACCOUNT)</h2>
        
        <form action="signUp.do" method="post">
            
            <label for="userId">아이디 (ID)</label>
            <input type="text" id="userId" name="userId" required maxlength="20">
            
            <label for="userPw">비밀번호 (Password)</label>
            <input type="password" id="userPw" name="userPw" required maxlength="20">
            
            <label for="userName">이름</label>
            <input type="text" id="userName" name="userName" required maxlength="20">
            
            <label for="userEmail">이메일</label>
            <input type="email" id="userEmail" name="userEmail" required maxlength="50">
            
            <label for="userPhone">전화번호 (선택)</label>
            <input type="text" id="userPhone" name="userPhone" maxlength="20">
            
            <label for="userAddr">주소 (선택)</label>
            <input type="text" id="userAddr" name="userAddr" maxlength="200">
            
            <button type="submit">Playground 계정 생성</button>
        </form>

        <c:if test="${not empty requestScope.msg}">
            <div class="message">${requestScope.msg}</div>
        </c:if>
        
        <div class="sub-link">
            <a href="login.do">이미 계정이 있으신가요? (로그인)</a>
        </div>
    </div>

</body>
</html>