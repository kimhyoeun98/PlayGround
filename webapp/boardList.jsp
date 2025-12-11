<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PG 커뮤니티</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        /* 기본 테마 */
        body {
            background-color: #1b2838;
            color: #c7d5e0;
            font-family: 'Inter', 'Noto Sans KR', sans-serif;
            margin: 0;
            padding-bottom: 50px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* 글로벌 헤더 스타일 */
        .global-header {
            width: 100%;
            background: #171a21;
            padding: 20px 0;
            display: flex;
            justify-content: center;
            box-shadow: 0 0 10px rgba(0,0,0,0.5);
            margin-bottom: 30px;
        }
        
        .header-content {
            width: 940px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo {
            font-size: 24px;
            font-weight: bold;
            color: #c7d5e0;
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        .logo:hover { color: white; }
        
        .user-menu a {
            color: #b8b6b4;
            text-decoration: none;
            font-size: 13px;
            margin-left: 15px;
        }
        .user-menu a:hover { color: white; }

        /* 컨테이너 */
        .container {
            width: 940px;
            margin-top: 30px;
        }

        /* 페이지 헤더 (제목 + 글쓰기 버튼) */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #363b45;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        .page-title {
            font-size: 24px;
            color: white;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-write {
            background: linear-gradient(to bottom, #66c0f4 5%, #4b96c4 95%);
            color: white;
            padding: 8px 15px;
            text-decoration: none;
            font-size: 14px;
            border-radius: 2px;
            font-weight: bold;
        }

        .btn-write:hover {
            background: linear-gradient(to bottom, #86d0f9 5%, #66c0f4 95%);
        }

        /* 게시판 테이블 */
        .board-table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(0, 0, 0, 0.2);
        }

        .board-table th {
            background: #000000;
            color: #8f98a0;
            padding: 10px;
            font-size: 13px;
            text-align: left;
        }

        .board-table td {
            padding: 10px;
            border-bottom: 1px solid #2a3f5a;
            font-size: 14px;
            color: #c6d4df;
        }

        .board-table tr:hover {
            background-color: #2a3f5a;
        }

        .title-link {
            color: #ffffff;
            text-decoration: none;
            font-weight: bold;
        }

        .title-link:hover {
            color: #66c0f4;
            text-decoration: underline;
        }

        /* 뒤로가기 링크 */
        .back-link {
            display: block;
            margin-top: 20px;
            color: #8f98a0;
            text-decoration: none;
        }

        .back-link:hover {
            color: white;
        }
    </style>
</head>
<body>

    <div class="global-header">
        <div class="header-content">
            <a href="<%= path %>/gameList.do" class="logo">🎮 PLAYGROUND</a>
            
            <div class="user-menu">
                <c:choose>
                    <c:when test="${empty sessionScope.loginUser}"> 
                        <a href="<%= path %>/login.do">로그인</a>
                        <a href="<%= path %>/signUp.do">회원가입</a>
                    </c:when>
                    <c:otherwise>
                        <span style="color: #66c0f4; font-weight: bold; font-size: 13px;">
                            ${sessionScope.loginUser.userName}님
                        </span>
                        
                        <c:if test="${sessionScope.loginUser.userId != 'admin'}">
                            <span style="color:#a3cf06; font-weight:bold; margin-left: 10px; font-size: 13px;">
                                [ <fmt:formatNumber value="${sessionScope.loginUser.userPoint}" type="number"/> P ]
                            </span>
                            <a href="<%= path %>/cartList.do">장바구니</a>
                            <a href="<%= path %>/myOrderList.do">내 라이브러리</a>
                        </c:if>
                        <a href="<%= path %>/myInfo.do">마이페이지</a>
                        <a href="<%= path %>/logout.do">로그아웃</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="container">
        
        <div class="page-header">
            <div class="page-title">커뮤니티 / 게시판</div>
            <a href="<%= path %>/boardWrite.do" class="btn-write">✏ 글쓰기</a>
        </div>

        <table class="board-table">
            <thead>
                <tr>
                    <th style="width: 60px; text-align: center;">번호</th>
                    <th>제목</th>
                    <th style="width: 120px;">작성자</th>
                    <th style="width: 100px;">작성일</th>
                    <th style="width: 60px; text-align: center;">조회</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="vo" items="${boardList}">
                    <tr>
                        <td style="text-align: center;">${vo.boardNo}</td>
                        <td>
                            <a href="<%= path %>/boardDetail.do?no=${vo.boardNo}" class="title-link">
                                ${vo.title}
                            </a>
                        </td>
                        <td>${vo.writer}</td>
                        <td>${vo.regDate}</td>
                        <td style="text-align: center;">${vo.viewCnt}</td>
                    </tr>
                </c:forEach>

                <c:if test="${empty boardList}">
                    <tr>
                        <td colspan="5" style="text-align: center; padding: 30px; color: #8f98a0;">
                            등록된 게시글이 없습니다. 첫 번째 글을 작성해보세요!
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <a href="<%= path %>/gameList.do" class="back-link">&lt; 상점으로 돌아가기</a>
    </div>

</body>
</html>