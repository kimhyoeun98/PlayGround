<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 목록 (관리자)</title>
    <style>
        body { 
            background-color: #1b2838; 
            color: #c7d5e0; 
            font-family: Arial, sans-serif; 
            margin: 0; 
        }
        .container { 
            width: 90%; 
            margin: 40px auto; 
        }
        h1 { 
            color: #ffffff; 
            border-bottom: 1px solid #2a475e; 
            padding-bottom: 10px; 
        }
        table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 20px; 
            background-color: #1e252e; 
        }
        th, td { 
            padding: 15px; 
            text-align: left; 
            border-bottom: 1px solid #2a475e; 
        }
        th { 
            background-color: #2a475e; 
            color: #66c0f4; 
            font-weight: normal; 
        }
        tr:hover { 
            background-color: #2a475e; 
            transition: 0.2s; 
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>관리자: 전체 회원 목록</h1>
        
        <a href="myInfo.do" style="color:#66c0f4;">&lt; 마이페이지로 돌아가기</a>
        
        <table>
            <thead>
                <tr>
                    <th>No</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>전화번호</th>
                    <th>주소</th>
                    <th>가입일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${requestScope.userList}">
                    <tr>
                        <td>${user.userNo}</td>
                        <td>${user.userId}</td>
                        <td>${user.userName}</td>
                        <td>${user.userEmail}</td>
                        <td>${user.userPhone}</td>
                        <td>${user.userAddr}</td>
                        <td>${user.joinDate}</td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty userList}">
                    <tr>
                        <td colspan="7" style="text-align: center; padding: 50px;">등록된 회원이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

</body>
</html>