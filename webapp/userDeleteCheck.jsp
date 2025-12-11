<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%-- 💡 Context Path를 동적으로 가져와 경로 문제 해결 --%>
<% String path = request.getContextPath(); %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴 재확인</title>
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
    .check-box { 
        background-color: #171a21; /* 더 어두운 배경 */
        padding: 40px; 
        border-radius: 5px; 
        width: 350px; 
        text-align: center; 
        box-shadow: 0 0 20px rgba(0,0,0,0.8); /* 그림자 강조 */
        border: 1px solid #ff6b6b; /* 위험 강조 테두리 */
    }
    h2 { 
        color: #ff6b6b; /* 위험 색상 */
        margin-bottom: 25px; 
        border-bottom: 1px solid #333;
        padding-bottom: 10px;
    }
    
    p { 
        margin-bottom: 30px; 
        font-size: 14px; 
        color: #99c0e0; /* 옅은 파랑 회색 */
    }
    
    input { 
        width: 100%; 
        padding: 12px; 
        margin: 10px 0; 
        background: #1b2838; /* 입력 필드 배경도 어둡게 */
        border: 1px solid #4582a5; 
        color: white; 
        box-sizing: border-box; 
        border-radius: 3px; 
    }
    
    button { 
        width: 100%; 
        padding: 12px; 
        background: #ff6b6b; /* 버튼도 위험 색상 */
        color: white; 
        border: none;
        border-radius: 3px; 
        cursor: pointer; 
        font-size: 16px; 
        margin-top: 20px; 
        font-weight: bold; 
        transition: background-color 0.2s;
    }

    button:hover {
        background: #e65a5a; /* 호버 시 색상 어둡게 */
    }
    
    .error { 
        color: #ffff00; /* 경고 메시지 색상 */
        margin-top: 15px; 
        font-size: 14px; 
        background: #333;
        padding: 5px;
    }
    
    a { 
        color: #66c0f4; /* 취소 링크는 스팀 블루 */
        text-decoration: none; 
        font-size: 13px; 
        margin-top: 20px; 
        display: inline-block;
    }
    
    a:hover {
        text-decoration: underline;
        color: white;
    }
    
</style>
</head>
<body>

   <div class="check-box">
        <h2>회원 탈퇴 재확인</h2>
        <p>회원 탈퇴를 진행하기 위해 비밀번호를 다시 한 번 입력해 주세요. <br>(**주의: 모든 정보가 영구 삭제됩니다**)</p>
        

        <form action="<%= path %>/userDeleteCheck.do" method="post">
            <input type="password" name="userPw" placeholder="비밀번호 재입력" required>
            <button type="submit">탈퇴 확인</button>
        </form>
        
        <c:if test="${not empty requestScope.msg}">
            <div class="error">${requestScope.msg}</div>
        </c:if>
        
        <a href="/myInfo.do">취소하고 돌아가기</a>
    </div>

</body>
</html>