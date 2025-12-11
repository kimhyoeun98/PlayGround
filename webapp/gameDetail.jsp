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
        /* 기본 테마 */
        body { 
            background-color: #1b2838; 
            color: #c7d5e0; 
            font-family: 'Inter', 'Noto Sans KR', sans-serif; 
            margin: 0; 
            padding-bottom: 50px; 
        }
        
        /* 글로벌 헤더 */
        .global-header { 
            background-color: #171a21; 
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
            margin: 0 auto; 
        }
        
        /* 빵 부스러기 네비게이션 */
        .breadcrumbs { 
            font-size: 12px; 
            color: #8f98a0; 
            margin-bottom: 10px; 
        }
        .breadcrumbs a { 
            color: #8f98a0; 
            text-decoration: none; 
        }
        .breadcrumbs a:hover { color: white; }
        
        .game-title-header { 
            font-size: 26px; 
            color: white; 
            margin-bottom: 15px; 
            font-weight: normal; 
        }

        /* 히어로 섹션 */
        .hero-section { 
            display: flex; 
            background: rgba(0,0,0,0.2); 
            margin-bottom: 25px; 
        }
        
        .hero-media { 
            width: 600px; 
            height: 337px; 
            background: linear-gradient(135deg, #1b2838, #2a475e); 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            color: #66c0f4; 
            font-size: 40px; 
            border: 1px solid #000; 
            overflow: hidden; 
            padding: 0; 
        }
        
        .hero-details { 
            flex: 1; 
            padding: 15px; 
            background-color: rgba(0, 0, 0, 0.4); 
            font-size: 13px; 
            position: relative; 
        }
        
        .detail-img { 
            width: 100%; 
            height: 120px; 
            background-color: #0f1012; 
            margin-bottom: 15px; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            color: #333; 
            overflow: hidden; 
        }
        
        .detail-desc { 
            color: #c6d4df; 
            line-height: 1.5; 
            height: 100px; 
            overflow: hidden; 
            margin-bottom: 10px; 
        }
        
        .detail-row { 
        	display: flex; 
        	margin-bottom: 5px; 
        }
        
        .detail-label { 
        	color: #556772; 
        	width: 80px; 
        }
        
        .detail-value { 
        	color: #66c0f4;
        }

        /* 구매 박스 */
        .purchase-area { 
            background: linear-gradient(to right, rgba(0,0,0,0.5), rgba(0,0,0,0.2)); 
            padding: 20px; 
            border-radius: 2px; 
            position: relative; 
            margin-bottom: 40px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
        }
        
        .purchase-title { 
        	font-size: 20px; 
        	color: white; 
        }
        
        .purchase-action { 
            background-color: #000; 
            padding: 2px; 
            border-radius: 2px; 
            display: flex; 
            align-items: center; 
        }
        
        .price-tag { 
            color: #c7d5e0; 
            padding: 0 15px; 
            font-size: 14px; 
        }
        
        /* 버튼 스타일 */
        .btn-buy { 
            background: linear-gradient( to bottom, #75b022 5%, #588a1b 95%); 
            background-color: #75b022; 
            border-radius: 2px; 
            border: none; 
            display: inline-block; 
            cursor: pointer; 
            color: #d2efa9; 
            font-family: Arial; 
            font-size: 15px; 
            padding: 8px 25px; 
            text-decoration: none; 
            text-shadow: 0px 1px 0px rgba(0,0,0,0.3); 
        }
        .btn-buy:hover { 
            background: linear-gradient( to bottom, #8ed629 5%, #6aa621 95%); 
            color: white; 
        }
        
        /* 구매 불가 버튼 스타일 */
        .btn-disabled {
            background: #3d4450; 
            color: #8f98a0; 
            cursor: not-allowed;
            border: none;
            padding: 8px 25px;
            font-size: 15px;
            border-radius: 2px;
        }

        /* 📝 본문 레이아웃 */
        .content-area { display: flex; gap: 30px; }
        .left-col { width: 616px; }
        .right-col { flex: 1; }
        
        .about-game { 
            border-top: 1px solid #363c44; 
            padding-top: 10px; 
        }
        
        .section-title { 
            color: white; 
            text-transform: uppercase; 
            margin-bottom: 10px; 
            font-size: 14px; 
            border-left: 3px solid #66c0f4; 
            padding-left: 10px; 
        }
        
        .description-text { 
            font-size: 14px; 
            line-height: 1.6; 
            color: #acb2b8; 
        }
        
        .sidebar-block { 
            background-color: rgba(0,0,0,0.2); 
            padding: 10px; 
            margin-bottom: 10px; 
            font-size: 13px; 
        }
        
        .sidebar-label { 
        	color: #56646e; 
        	margin-bottom: 3px; 
        }
        	
        .sidebar-link { 
        	color: #66c0f4; 
        	text-decoration: none; 
        }
        	
        .sidebar-link:hover { 
        	color: white;
        }
        	
    </style>
</head>
<body>

    <div class="global-header">
        <div class="header-content">
            <a href="gameList.do" class="logo">🎮 PLAYGROUND</a>
            <div class="user-menu">
                <c:choose>
                    <c:when test="${empty sessionScope.loginUser}"> 
                        <a href="login.do">로그인</a>
                    </c:when>
                    <c:otherwise>
                        <span style="color:#66c0f4">${sessionScope.loginUser.userName}님
                            <c:if test="${sessionScope.loginUser.userId == 'admin'}">(관리자)</c:if>
                        </span>
                        
                        <c:if test="${sessionScope.loginUser.userId != 'admin'}">
                            <span style="color:#a3cf06; font-weight:bold; margin-left: 10px; font-size: 13px;">
                                [ <fmt:formatNumber value="${sessionScope.loginUser.userPoint}" type="number"/> P ]
                            </span>
                            <a href="cartList.do">장바구니</a>
                            <a href="myOrderList.do">내 라이브러리</a>
                        </c:if>
                        
                        <a href="myInfo.do">마이페이지</a>
                        <a href="logout.do">로그아웃</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="container">
        
        <c:choose>
            <c:when test="${not empty game}">
                
                <div class="breadcrumbs">
                    <a href="<%= path %>/gameList.do">모든 게임</a> &gt; 
                    <a href="<%= path %>/gameList.do?keyword=${game.gameGenre}">${game.gameGenre}</a> &gt; 
                    <span>${game.gameName}</span>
                </div>

                <div class="game-title-header">${game.gameName}</div>

                <div class="hero-section">
                    
                    <div class="hero-media">
                        <c:choose>
                            <c:when test="${not empty game.gameImg}">
                                <img src="${pageContext.request.contextPath}/upload/${game.gameImg}" 
                                     alt="${game.gameName}" 
                                     style="width: 100%; height: 100%; object-fit: cover;">
                            </c:when>
                            <c:otherwise>
                                🎬
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="hero-details">
                        <div class="detail-img">
                            <c:if test="${not empty game.gameImg}">
                                <img src="${pageContext.request.contextPath}/upload/${game.gameImg}" 
                                     style="width: 100%; height: 100%; object-fit: cover;">
                            </c:if>
                            <c:if test="${empty game.gameImg}">
                                Game Logo
                            </c:if>
                        </div>
                        
                        <div class="detail-desc">
                            ${game.gameDesc != null ? game.gameDesc : '상세 설명이 준비되어 있지 않습니다.'}
                        </div>
                        
                        <div class="detail-row">
                            <span class="detail-label">출시일:</span>
                            <span class="detail-value">${game.regDate}</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">개발자:</span>
                            <span class="detail-value">${game.gameDev}</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">태그:</span>
                            <span class="detail-value" style="background:#24323f; padding:2px 5px; border-radius:2px;">${game.gameGenre}</span>
                        </div>
                    </div>
                </div>

                <div class="purchase-area">
                    <div class="price-tag">
                        <c:choose>
                            <%-- 판매 중지 상태 먼저 체크 --%>
                            <c:when test="${game.status != 1}">
                                <span style="color: #8f98a0;">판매 중지</span>
                            </c:when>
                            <c:when test="${game.gamePrice == 0}">
                                무료 플레이
                            </c:when>
                            <c:otherwise>
                                ₩ <fmt:formatNumber value="${game.gamePrice}" type="number"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                
                    <form action="<%= path %>/cartAdd.do" method="post" style="margin: 0;">
                        <input type="hidden" name="gameNo" value="${game.gameNo}">
                        
                        <c:choose>
                            <%-- 1. 이미 구매한 유저는 판매 상태와 상관없이 플레이 가능 --%>
                            <c:when test="${isOwned}">
                                <button type="button" class="btn-buy" 
                                        onclick="alert('게임 실행 중... 🎮 (가상 실행)')" 
                                        style="background: linear-gradient(to bottom, #4f9eea 5%, #207cca 95%); color: white;">
                                    ▶ 지금 플레이
                                </button>
                            </c:when>
                            
                            <%--  2. 판매 중지된 상품 (구매 안 한 경우) --%>
                            <c:when test="${game.status != 1}">
                                <button type="button" class="btn-disabled" disabled>
                                    구매 불가
                                </button>
                            </c:when>
                            
                            <%-- 3. 무료 게임 (구매 안 함, 판매 중) --%>
                            <c:when test="${game.gamePrice == 0}">
                                <button type="button" class="btn-buy" onclick="alert('무료 게임 설치 시작!')">
                                    게임 플레이
                                </button>
                            </c:when>
                            
                            <%-- 4. 유료 게임 (구매 안 함, 판매 중) --%>
                            <c:otherwise>
                                <button type="submit" class="btn-buy">
                                    장바구니에 추가
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </form>
                </div>
                
                <div class="content-area">
                    <div class="left-col">
                        <div class="about-game">
                            <div class="section-title">게임에 대해</div>
                            <div class="description-text">
                                ${game.gameDesc}<br><br>
                                이 게임은 ${game.gameDev}에서 개발한 ${game.gameGenre} 장르의 게임입니다. 
                                플레이어들에게 최고의 경험을 선사하기 위해 제작되었습니다.
                            </div>
                        </div>
                    </div>
                    
                    <div class="right-col">
                        <div class="sidebar-block">
                            <div class="sidebar-label">기능</div>
                            <div style="color: #66c0f4;">☁ 싱글 플레이어</div>
                            <div style="color: #66c0f4;">☁ 멀티 플레이어</div>
                        </div>
                        
                        <c:if test="${sessionScope.loginUser.userId == 'admin'}">
                            <div class="sidebar-block" style="border: 1px solid #d9534f;">
                                <div class="sidebar-label" style="color: #d9534f;">관리자 도구</div>
                                <a href="gameUpdate.do?gameNo=${game.gameNo}" class="sidebar-link">게임 정보 수정</a><br>
                                <a href="gameDelete.do?gameNo=${game.gameNo}" class="sidebar-link" onclick="return confirm('삭제하시겠습니까?')">게임 삭제</a>
                            </div>
                        </c:if>
                        
                        <a href="gameList.do" style="color: #b8b6b4; font-size: 13px; display: block; margin-top: 20px;">
                            &lt; 목록으로 돌아가기
                        </a>
                    </div>
                </div>

            </c:when>
            
            <c:otherwise>
                <div style="padding: 50px; text-align: center;">
                    <h2>존재하지 않는 게임입니다.</h2>
                    <a href="gameList.do" style="color: #66c0f4;">상점으로 돌아가기</a>
                </div>
            </c:otherwise>
        </c:choose>

    </div>

</body>
</html>