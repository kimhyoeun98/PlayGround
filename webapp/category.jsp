<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PG 카테고리</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

<style>
    /* 🌑 기본 테마 설정 */
    body {
        background-color: #1b2838;
        color: #c7d5e0;
        font-family: 'Inter', 'Noto Sans KR', sans-serif;
        margin: 0;
        display: flex;
        flex-direction: column;
        align-items: center;
        padding-top: 30px;
        padding-bottom: 50px;
    }

    /* 🟦 글로벌 헤더 스타일 */
    .global-header { 
        width: 100%; 
        background: #171a21; 
        padding: 20px 0; 
        display: flex; 
        justify-content: center; 
        box-shadow: 0 0 10px rgba(0,0,0,0.5); 
        margin-bottom: 30px;
    }
    
    .header-content { width: 940px; display: flex; justify-content: space-between; align-items: center; }
    .logo { font-size: 24px; font-weight: bold; color: #c7d5e0; text-decoration: none; letter-spacing: 2px; }
    .logo:hover { color: white; }
    .user-menu a { color: #b8b6b4; text-decoration: none; font-size: 13px; margin-left: 15px; }
    .user-menu a:hover { color: white; }
    .active-link { color: white !important; text-decoration: underline !important; } 


    .container { width: 940px; }

    .page-title {
        font-size: 28px;
        color: white;
        text-transform: uppercase;
        font-weight: 300;
        margin-bottom: 30px;
        letter-spacing: 1px;
        border-bottom: 1px solid #363b45;
        padding-bottom: 10px;
    }

    /* 카테고리 그리드 레이아웃 */
    .category-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 20px;
    }

    /* 🚨 [수정됨] 개별 카테고리 카드 스타일 (배경 통일) */
    .category-card {
        height: 160px;
        border-radius: 4px;
        display: flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
        position: relative;
        overflow: hidden;
        
        /* 기본 배경색 (모든 카드가 동일) */
        background-color: #2a475e; 
        
        /* 테두리 및 그림자 효과 */
        box-shadow: 0 0 10px rgba(0,0,0,0.5), inset 0 0 5px rgba(102, 192, 244, 0.2);
        transition: transform 0.2s, box-shadow 0.2s, filter 0.2s;
        border: 1px solid #2a475e;
    }

    .category-card:hover {
        transform: translateY(-4px); 
        /* 호버 시 강조 (모든 카드가 동일한 파란색 강조 효과) */
        box-shadow: 0 10px 20px rgba(0,0,0,0.7), inset 0 0 15px rgba(102, 192, 244, 0.5); 
        filter: brightness(1.1);
    }

    /* 텍스트 스타일 */
    .card-title {
        color: white;
        font-size: 26px;
        font-weight: 700;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.8);
        z-index: 2;
        text-transform: uppercase;
        letter-spacing: 2px;
        text-align: center;
    }

    /* 🚨 장르별 배경색 클래스는 제거함 */

    /* 뒤로가기 */
    .back-link {
        display: block;
        margin-top: 30px;
        color: #8f98a0;
        text-decoration: none;
        font-size: 13px;
    }
    .back-link:hover { color: white; }
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
                        <c:if test="${sessionScope.loginUser.userId == 'admin'}">(관리자)</c:if>
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
    <div class="page-title">장르별 찾아보기</div>

    <div class="category-grid">
        
        <a href="<%= path %>/gameList.do?keyword=Action" class="category-card">
            <span class="card-title">액션 (Action)</span>
        </a>

        <a href="<%= path %>/gameList.do?keyword=RPG" class="category-card">
            <span class="card-title">RPG</span>
        </a>
        
        <a href="<%= path %>/gameList.do?keyword=FPS" class="category-card">
            <span class="card-title">FPS / 슈팅</span>
        </a>

        <a href="<%= path %>/gameList.do?keyword=Simulation" class="category-card">
            <span class="card-title">시뮬레이션</span>
        </a>

        <a href="<%= path %>/gameList.do?keyword=Strategy" class="category-card">
            <span class="card-title">전략 (Strategy)</span>
        </a>

        <a href="<%= path %>/gameList.do?keyword=Sports" class="category-card">
            <span class="card-title">스포츠 / 레이싱</span>
        </a>
        
        <a href="<%= path %>/gameList.do?keyword=Adventure" class="category-card">
            <span class="card-title">어드벤처</span>
        </a>
        
        <a href="<%= path %>/gameList.do?keyword=Horror" class="category-card">
            <span class="card-title">공포 (Horror)</span>
        </a>
        
        <a href="<%= path %>/gameList.do" class="category-card">
            <span class="card-title">모든 게임 보기</span>
        </a>
    </div>

    <a href="gameList.do" class="back-link">&lt; 상점 메인으로 돌아가기</a>
</div>

</body>
</html>