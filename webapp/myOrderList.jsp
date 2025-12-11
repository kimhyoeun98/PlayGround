<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${sessionScope.loginUser.userName}의 라이브러리</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<style>
    /* 스팀 라이브러리 테마 */
    body { 
        background-color: #1b2838; 
        color: #c7d5e0; 
        font-family: 'Inter', 'Noto Sans KR', sans-serif; 
        margin: 0; 
        display: flex;
        flex-direction: column;
        align-items: center;
        padding-top: 50px;
    }
    
    /* 글로벌 헤더 (통일감 유지) */
    .global-header { 
        width: 100%;
        background: #171a21; 
        padding: 20px 0; 
        display: flex; 
        justify-content: center; 
        box-shadow: 0 0 10px rgba(0,0,0,0.5); 
        position: absolute; top: 0; left: 0;
    }
    
    .header-content { width: 940px; display: flex; justify-content: space-between; align-items: center; }
    .logo { font-size: 24px; font-weight: bold; color: #c7d5e0; text-decoration: none; letter-spacing: 2px; }
    .user-menu a { color: #b8b6b4; text-decoration: none; font-size: 13px; margin-left: 15px; }
    
    .library-container { 
        width: 940px; 
        margin-top: 40px; 
    }
    
    .header-area { 
        border-bottom: 1px solid #363c44; 
        padding-bottom: 15px; 
        margin-bottom: 20px; 
        display: flex; 
        justify-content: space-between; 
        align-items: end; 
    }
    
    h2 { 
        margin: 0; 
        color: #ffffff; 
        font-weight: normal; 
        font-size: 24px; 
        letter-spacing: 1px; 
    }
    
    /* 게임 리스트 */
    .game-row {
        background-color: rgba(0,0,0,0.2);
        padding: 15px; 
        margin-bottom: 5px; 
        display: flex; 
        align-items: center; 
        justify-content: space-between;
        transition: background-color 0.2s;
    }
    
    .game-row:hover { 
        background-color: #2a3f5a; 
    }
    
    .game-info { 
        display: flex; 
        align-items: center; 
        gap: 20px; 
    }
    
    /* 이미지 스타일 */
    .game-img {
        width: 120px; 
        height: 56px; 
        background-color: #000; 
        object-fit: cover;
        box-shadow: 0 0 5px rgba(0,0,0,0.5);
    }
    
    .game-name { 
        font-size: 16px; 
        color: white; 
        font-weight: bold; 
        text-decoration: none;
    }
    .game-name:hover { color: #66c0f4; }
    
    .play-time { 
        font-size: 12px; 
        color: #8f98a0; 
        margin-top: 5px; 
    }
    
    /* ▶️ 플레이 버튼 */
    .btn-play {
        background: linear-gradient( to bottom, #75b022 5%, #588a1b 95%);
        color: white; 
        border: none; 
        padding: 8px 25px; 
        font-weight: bold; 
        font-size: 14px; 
        border-radius: 2px; 
        cursor: pointer;
    }
    .btn-play:hover { filter: brightness(1.2); }
    
    .home-link { display: inline-block; margin-top: 30px; color: #66c0f4; text-decoration: none; }
</style>
</head>
<body>

    <div class="global-header">
        <div class="header-content">
            <a href="gameList.do" class="logo">🎮 PLAYGROUND</a>
            <div class="user-menu">
                <span style="color:#66c0f4">${sessionScope.loginUser.userName}님</span>
                <span style="color:#a3cf06; font-weight:bold; margin-left: 10px; font-size: 13px;">
                    [ <fmt:formatNumber value="${sessionScope.loginUser.userPoint}" type="number"/> P ]
                </span>
                <a href="<%= path %>/myInfo.do">마이페이지</a>
                <a href="<%= path %>/logout.do">로그아웃</a>
            </div>
        </div>
    </div>

    <div class="library-container">
        
        <div class="header-area">
            <h2>내 라이브러리 (${orderList != null ? orderList.size() : 0})</h2>
            <div style="color: #66c0f4; font-size: 14px;">${sessionScope.loginUser.userName}님의 계정</div>
        </div>
        
        <c:choose>
            <c:when test="${not empty orderList}">
                <c:forEach var="order" items="${orderList}">
                    <div class="game-row">
                        <div class="game-info">
                            <c:choose>
                                <c:when test="${not empty order.gameImg}">
                                    <img src="${pageContext.request.contextPath}/upload/${order.gameImg}" class="game-img">
                                </c:when>
                                <c:otherwise>
                                    <div class="game-img" style="display:flex; align-items:center; justify-content:center; color:#555; font-size:20px;">🎮</div>
                                </c:otherwise>
                            </c:choose>
                            
                            <div>
                                <a href="gameDetail.do?gameNo=${order.gameNo}" class="game-name">${order.gameName}</a>
                                <div class="play-time">구매일: ${order.orderDate}</div>
                            </div>
                        </div>
                        <div>
                            <button class="btn-play" onclick="alert('게임 실행 중... 🎮')">▶ 플레이</button>

                            <a href="refund.do?orderNo=${order.orderNo}" 
                               onclick="return confirm('정말 환불하시겠습니까?\n게임이 라이브러리에서 제거되고 포인트가 반환됩니다.')"
                               style="color: #8f98a0; font-size: 12px; margin-left: 10px; text-decoration: underline;">
                               환불 요청
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            
            <c:otherwise>
                <div style="text-align: center; padding: 50px; color: #8f98a0; background: rgba(0,0,0,0.2);">
                    보유한 게임이 없습니다.<br><br>
                    <a href="gameList.do" style="color: #66c0f4;">상점으로 이동하기</a>
                </div>
            </c:otherwise>
        </c:choose>
        
        <a href="gameList.do" class="home-link">← 상점으로 돌아가기</a>
    </div>

</body>
</html>