<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Playground Store</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        /* 기본 테마 설정 */
        body { 
            background-color: #1b2838; 
            color: #c7d5e0; 
            font-family: 'Inter', 'Noto Sans KR', sans-serif; 
            margin: 0; 
        }
    
        /*  상단 네비게이션 (Global Header) */
        .global-header { 
            background-color: #171a21; 
            padding: 30px 20px; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            box-shadow: 0 0 10px rgba(0,0,0,0.5); 
        }
        
        .header-content {
            width: 940px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center;
        }
        
        .logo {
            font-size: 26px; 
            font-weight: bold; 
            color: #c7d5e0; 
            text-decoration: none; 
            text-transform: uppercase; 
            letter-spacing: 2px;
        }
        
        .logo:hover { 
        	color: white;
        }
    
        .user-menu a { 
            color: #b8b6b4; 
            text-decoration: none; 
            margin-left: 15px; 
            font-size: 13px; 
        }
        
        .user-menu a:hover { 
        	color: white;
        }
        
        /*  상점 메뉴 탭 (Store Nav) */
        .store-nav {
            background: linear-gradient(to bottom, #3e6786 5%, #3b5f7c 95%);
            height: 35px;
            display: flex;
            justify-content: center;
            align-items: center; 
            box-shadow: 0 0 4px rgba(0,0,0,0.4);
            margin-bottom: 20px;
        }
        
        .store-nav-content {
            width: 940px;
            display: flex;
            gap: 20px;
        }
        
        .nav-item {
            color: #e5e5e5; 
            text-decoration: none; 
            font-size: 13px; 
            font-weight: bold; 
            text-shadow: 1px 1px 0px rgba(0,0,0,0.3);
            padding: 0 10px; 
            line-height: 35px;
        }
        .nav-item:hover {
            background-color: rgba(255,255,255,0.1);
            color: white;
        }
        
        /* 검색창 스타일 */
        .search-box {
            background: #316282;
            border: 1px solid rgba(0,0,0,0.3);
            color: white;
            padding: 3px 5px;
            border-radius: 3px;
            box-shadow: inset 1px 1px 2px rgba(0,0,0,0.4);
            font-family: inherit;
        }
        .search-box::placeholder { color: #0e1c25; font-style: italic; }
    
        /* 메인 컨텐츠 영역 */
        .container { 
            width: 940px; 
            margin: 0 auto; 
            padding-bottom: 50px;
        }
        
        /* 페이지 헤더 영역 (제목 + 버튼) */
        .page-header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 30px;
            margin-bottom: 10px;
        }
        
        h1 { 
            color: #ffffff; 
            font-size: 24px; 
            margin: 0;
            text-transform: uppercase; 
            letter-spacing: 0.5px;
            font-weight: normal;
        }
        
        /* 스팀 그린 버튼 (관리자용) */
        .admin-btn {
            background: linear-gradient( to bottom, #75b022 5%, #588a1b 95%);
            box-shadow: 0 0 5px rgba(0,0,0,0.2);
            color: #d2efa9; 
            padding: 6px 15px; 
            text-decoration: none; 
            border-radius: 2px; 
            font-size: 14px; 
            font-weight: bold;
            text-shadow: 1px 1px 0px rgba(0,0,0,0.3);
            transition: 0.2s;
        }
        
        .admin-btn:hover { 
            background: linear-gradient( to bottom, #8ed629 5%, #6aa621 95%); 
            color: white; 
        }

        /* 스팀 스타일 탭 메뉴 바 */
        .steam-tab-bar {
            background: #2a475e;
            padding: 5px 10px;
            display: flex;
            align-items: center;
            border-radius: 3px 3px 0 0; /* 위쪽만 둥글게 */
            margin-bottom: 5px;
            box-shadow: 0 0 5px rgba(0,0,0,0.2);
        }

        .steam-tab {
            color: #2f89bc; /* 비활성 텍스트 색상 */
            text-decoration: none;
            padding: 8px 16px;
            font-size: 13px;
            font-weight: normal;
            transition: color 0.2s;
            cursor: pointer;
        }

        .steam-tab:hover {
            color: #ffffff;
        }

        /* 활성화된 탭 스타일 (가상) */
        .steam-tab.active {
            color: #ffffff;
            font-weight: bold;
            border-bottom: 3px solid #ffffff; /* 밑줄 포인트 */
            padding-bottom: 5px; /* 밑줄 위치 조정 */
        }
        
        .tab-divider {
            color: #2f89bc;
            font-size: 10px;
            margin: 0 5px;
        }
    
        /* 게임 리스트 아이템 */
        .game-row {
            display: flex;
            background-color: rgba(0, 0, 0, 0.2);
            margin-bottom: 5px;
            height: 69px; 
            align-items: center;
            text-decoration: none; 
            transition: background-color 0.2s;
        }
        .game-row:hover {
            background-color: #2a475e; /* 호버 시 파란색으로 변경 */
        }
        /* 호버 시 제목 색상 변경 안 함 (스팀 스타일) */
        
        /* 이미지 영역 스타일 */
        .game-img-placeholder {
            width: 150px; 
            height: 100%;
            background: linear-gradient(135deg, #2a475e, #1b2838);
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 24px;
            color: #66c0f4;
            font-weight: bold;
            flex-shrink: 0;
            overflow: hidden; 
            padding: 0;
        }
        
        .game-info {
            flex-grow: 1;
            padding-left: 20px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .game-title {
            color: #c7d5e0;
            font-size: 15px; 
            font-weight: bold;
            margin-bottom: 4px;
        }
        
        .game-meta {
            color: #384959; 
            font-size: 12px;
        }
        .game-meta span {
            color: #6d7984; 
        }
    
        .price-area {
            padding-right: 20px;
            text-align: right;
            min-width: 100px;
        }
    
        .price-tag {
            color: #c7d5e0; 
            font-size: 14px;
        }
        
        .price-free {
            color: #c7d5e0; 
            font-size: 14px;
        }
        
        .empty-list {
            text-align: center; 
            padding: 50px; 
            color: #8f98a0; 
            background: rgba(0,0,0,0.2);
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
    
    <div class="store-nav">
        <div class="store-nav-content">
            <a href="<%= path %>/gameList.do" class="nav-item">상점</a>
            <a href="<%= path %>/newGame.do" class="nav-item">신제품</a>
            <a href="<%= path %>/category.do" class="nav-item">카테고리</a>
            
            <c:if test="${sessionScope.loginUser.userId != 'admin'}">
    			<a href="<%= path %>/pointCharge.do" class="nav-item">포인트 상점</a>
			</c:if>
			
            <a href="<%= path %>/boardList.do" class="nav-item">커뮤니티</a>
            
            <div style="margin-left: auto; display: flex; align-items: center;">
                <form action="<%= path %>/gameList.do" method="get" style="margin: 0;">
                    <input type="text" 
                           name="keyword" 
                           placeholder="검색" 
                           value="${param.keyword}" 
                           class="search-box">
                </form>
            </div>
        </div>
    </div>

    <div class="container">
        
        <div class="page-header-section">
            <h1>${empty pageTitle ? '특집 및 추천 제품' : pageTitle}</h1>
            
            <c:if test="${sessionScope.loginUser.userId == 'admin'}">
                <a href="<%= path %>/gameAdd.do" class="admin-btn">➕ 게임 등록</a>
            </c:if>
        </div>

        <div class="steam-tab-bar">
            <a href="<%= path %>/newGame.do" class="steam-tab ${pageTitle.contains('신규') ? 'active' : ''}">
                신규 출시
            </a>
            <span class="tab-divider">|</span>
            <a href="<%= path %>/bestGame.do" class="steam-tab ${pageTitle.contains('인기') ? 'active' : ''}">
                최고 인기 제품
            </a>
        </div>

        <div class="game-list-area">
            
            <c:forEach var="game" items="${gList}">
                <a href="<%= path %>/gameDetail.do?gameNo=${game.gameNo}" class="game-row">
                    
                    <div class="game-img-placeholder">
                        <c:choose>
                            <c:when test="${not empty game.gameImg}">
                                <img src="${pageContext.request.contextPath}/upload/${game.gameImg}" 
                                     alt="cover" 
                                     style="width: 100%; height: 100%; object-fit: cover;">
                            </c:when>
                            <c:otherwise>
                                🎮 
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="game-info">
                        <div class="game-title">${game.gameName}</div>
                        <div class="game-meta">
                            <span style="color: #384959;">${game.gameGenre}</span>
                            <span style="color: #4c6c8c;">${game.gameDev}</span>
                        </div>
                        <div style="color: #384959; font-size: 11px; margin-top: 3px;">
                            <span style="background: #384959; color: #000; padding: 0 4px; border-radius: 2px;">WIN</span>
                        </div>
                    </div>
                    
                    <div class="price-area">
                        <c:choose>
                            <c:when test="${game.gamePrice == 0}">
                                <span class="price-free">무료 플레이</span>
                            </c:when>
                            <c:otherwise>
                                <span class="price-tag">₩ <fmt:formatNumber value="${game.gamePrice}" type="number"/></span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </a>
            </c:forEach>

            <c:if test="${empty gList}">
                <div class="empty-list">
                    현재 등록된 게임이 없습니다.
                </div>
            </c:if>

        </div> 
    </div>

</body>
</html>