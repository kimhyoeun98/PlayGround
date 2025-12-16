<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${game.gameName} on Playground</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        /* 기본 테마 및 레이아웃 */
        body { background-color: #1b2838; color: #c7d5e0; font-family: 'Inter', 'Noto Sans KR', sans-serif; margin: 0; padding-bottom: 50px; }
        .global-header { background-color: #171a21; padding: 20px 0; display: flex; justify-content: center; box-shadow: 0 0 10px rgba(0,0,0,0.5); margin-bottom: 30px; }
        .header-content { width: 940px; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 24px; font-weight: bold; color: #c7d5e0; text-decoration: none; text-transform: uppercase; letter-spacing: 2px; }
        .user-menu a { color: #b8b6b4; text-decoration: none; font-size: 13px; margin-left: 15px; }
        .container { width: 940px; margin: 0 auto; }
        
        /* 히어로 및 구매 구역 */
        .hero-section { display: flex; background: rgba(0,0,0,0.2); margin-bottom: 25px; }
        .hero-media { width: 600px; height: 337px; background: linear-gradient(135deg, #1b2838, #2a475e); display: flex; align-items: center; justify-content: center; overflow: hidden; }
        .hero-details { flex: 1; padding: 15px; background-color: rgba(0, 0, 0, 0.4); font-size: 13px; }
        .purchase-area { background: linear-gradient(to right, rgba(0,0,0,0.5), rgba(0,0,0,0.2)); padding: 20px; border-radius: 2px; display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; }
        
        /* 버튼 스타일 */
        .btn-buy { background: linear-gradient(to bottom, #75b022 5%, #588a1b 95%); border: none; cursor: pointer; color: #d2efa9; font-size: 15px; padding: 8px 25px; border-radius: 2px; text-decoration: none; }
        .btn-buy:hover { background: linear-gradient(to bottom, #8ed629 5%, #6aa621 95%); color: white; }

        /* 🚨 커스텀 모달 스타일 (장바구니 디자인 이식) */
        .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.8); z-index: 9999; backdrop-filter: blur(3px); }
        .modal-box { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #212429; width: 420px; padding: 30px; border-radius: 4px; border: 1px solid #3d4450; box-shadow: 0 10px 30px rgba(0,0,0,0.5); text-align: center; }
        .modal-icon { font-size: 40px; margin-bottom: 15px; }
        .modal-title { font-size: 20px; color: #ffffff; margin-bottom: 10px; font-weight: bold; }
        .modal-text { font-size: 15px; color: #c7d5e0; margin-bottom: 30px; line-height: 1.5; }
        .modal-btn-group { display: flex; justify-content: center; gap: 10px; }
        .modal-btn { border: none; padding: 10px 20px; font-size: 14px; font-weight: bold; border-radius: 2px; cursor: pointer; color: white; }
        .modal-btn.confirm { background: linear-gradient(to bottom, #66c0f4 5%, #4b96c4 95%); }
        .modal-btn.confirm:hover { background: linear-gradient(to bottom, #86d0f9 5%, #66c0f4 95%); }
    </style>
</head>
<body>

    <div class="global-header">
        <div class="header-content">
            <a href="gameList.do" class="logo">🎮 PLAYGROUND</a>
            <div class="user-menu">
                <c:choose>
                    <c:when test="${empty sessionScope.loginUser}"><a href="login.do">로그인</a></c:when>
                    <c:otherwise>
                        <span style="color:#66c0f4">${sessionScope.loginUser.userName}님</span>
                        <c:if test="${sessionScope.loginUser.userId != 'admin'}">
                            <span style="color:#a3cf06; font-weight:bold; margin-left: 10px;">[ <fmt:formatNumber value="${sessionScope.loginUser.userPoint}" type="number"/> P ]</span>
                            <a href="cartList.do">장바구니</a>
                            <a href="myOrderList.do">내 라이브러리</a>
                        </c:if>
                        <a href="logout.do">로그아웃</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="container">
        <c:choose>
            <c:when test="${not empty game}">
                <div class="game-title-header" style="font-size: 26px; color: white; margin-bottom: 15px;">${game.gameName}</div>
                
                <div class="hero-section">
                    <div class="hero-media">
                        <c:if test="${not empty game.gameImg}">
                            <img src="${pageContext.request.contextPath}/upload/${game.gameImg}" style="width: 100%; height: 100%; object-fit: cover;">
                        </c:if>
                    </div>
                    <div class="hero-details">
                        <div style="margin-bottom: 10px;">${game.gameDesc}</div>
                        <div>출시일: ${game.regDate}</div>
                        <div>개발자: ${game.gameDev}</div>
                    </div>
                </div>

                <div class="purchase-area">
                    <div class="price-tag">₩ <fmt:formatNumber value="${game.gamePrice}" type="number"/></div>
                    <form action="<%= path %>/cartAdd.do" method="post">
                        <input type="hidden" name="gameNo" value="${game.gameNo}">
                        <c:choose>
                            <c:when test="${isOwned}"><button type="button" class="btn-buy" style="background: #207cca;">▶ 플레이 가능</button></c:when>
                            <c:otherwise><button type="submit" class="btn-buy">장바구니에 추가</button></c:otherwise>
                        </c:choose>
                    </form>
                </div>
            </c:when>
            <c:otherwise><div style="text-align:center;">게임을 찾을 수 없습니다.</div></c:otherwise>
        </c:choose>
    </div>

    <div id="gameDetailModal" class="modal-overlay">
        <div class="modal-box">
            <div class="modal-icon">⚠️</div>
            <div class="modal-title">알림</div>
            <div id="modalText" class="modal-text"></div>
            <div class="modal-btn-group">
                <button type="button" class="modal-btn confirm" onclick="closeModal()">확인</button>
            </div>
        </div>
    </div>

    <script>
        function openModal(msg) {
            document.getElementById('modalText').innerText = msg;
            document.getElementById('gameDetailModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('gameDetailModal').style.display = 'none';
        }

        // 페이지 로드 시 세션에 msg가 있으면 모달 실행
        window.onload = function() {
            <c:if test="${not empty sessionScope.msg}">
                openModal("${sessionScope.msg}");
                <% session.removeAttribute("msg"); %>
            </c:if>
        }
    </script>
</body>
</html>