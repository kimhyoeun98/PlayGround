<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${myInfo.userName}님의 프로필</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

    <style>
        /* 전체 배경 */
        body {
            background-color: #1b2838;
            background-image: linear-gradient(to bottom, #1b2838 0%, #171a21 100%);
            background-repeat: no-repeat;
            background-attachment: fixed;
            color: #c7d5e0;
            font-family: 'Inter', 'Noto Sans KR', sans-serif;
            font-weight: 400;
            margin: 0;
            display: flex;
            justify-content: center;
            padding-top: 100px;
            letter-spacing: 0.3px;
        }

        /* 글로벌 헤더 */
        .global-header {
            width: 100%;
            background: #171a21;
            padding: 20px 0;
            display: flex;
            justify-content: center;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            position: absolute; top: 0; left: 0; z-index: 100;
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
        	letter-spacing: 2px; 
        }
        
        .logo:hover { 
        	color: white; 
        }
        
        .user-menu a { 
        	color: #b8b6b4; 
       		text-decoration: none; 
        	font-size: 13px; 
        margin-left: 15px; 
        }
        
        .user-menu a:hover { 
        	color: white; 
        }

        /* 메인 컨테이너 */
        .profile-container {
            width: 900px;
            background-color: rgba(0, 0, 0, 0.4);
            padding: 20px;
            border-radius: 4px;
            display: flex;
            flex-direction: row;
            gap: 30px;
            backdrop-filter: blur(5px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        }

        /* --- 왼쪽 사이드바 --- */
        .left-column { 
        	width: 200px;
        	text-align: center;
        }
        
        .avatar-frame {
            width: 164px; height: 164px;
            border: 3px solid #66c0f4;
            padding: 2px;
            background: linear-gradient(to bottom, #53a4c4, #458097);
            margin: 0 auto 10px auto;
            box-shadow: 0 0 10px rgba(102, 192, 244, 0.3);
        }
        
        .avatar-img { 
       		width: 100%; 
        	height: 100%; 
        	background-color: #333; 
        }
        
        .status-text { 
        	color: #66c0f4; 
        	font-size: 18px; 
        	font-weight: 600; 
        	margin-bottom: 5px; 
        }
        
        .level-badge {
            display: inline-block;
            border: 2px solid #4c6c8c; 
            border-radius: 50%;
            width: 40px; 
            height: 40px; 
            line-height: 38px; 
            text-align: center;
            font-size: 20px; 
            font-weight: 700; 
            color: white; 
            margin-top: 10px;
            background-color: #171a21;
        }

        /* --- 오른쪽 정보 영역 --- */
        .right-column { 
        	flex: 1;
        }
        
        .profile-header {
            display: flex; 
            justify-content: space-between; 
            align-items: flex-start;
            border-bottom: 1px solid #363b45; 
            padding-bottom: 20px;
            margin-bottom: 20px;
        }
        
        .username { 
        	font-size: 32px; 
        	color: #ffffff; 
        	font-weight: 300; 
        	letter-spacing: 1px; 
        }
        
        .user-country { 
        	font-size: 14px; 
        	color: #8f98a0; 
        	margin-top: 8px; 
        }
        
        .flag { 
        	font-size: 16px; 
        	margin-right: 6px; 
        }

        /* 버튼 스타일 */
        .steam-btn {
            background-color: rgba(255, 255, 255, 0.1); 
            color: #ebebeb;
            border: 1px solid transparent; 
            padding: 10px 22px; 
            border-radius: 2px;
            font-size: 14px; 
            font-weight: 500; 
            cursor: pointer; 
            text-decoration: none;
            display: inline-block; 
            transition: all 0.2s; 
            text-align: center;
        }
        .steam-btn:hover { 
       	 	background-color: #66c0f4; 
       	 	color: white; 
       		border-color: #85d4ff; 
        }
        
        .steam-btn.danger:hover { 
        	background-color: #ff6b6b;
        	border-color: #ff9999; 
        }

        .charge-btn {
            background: linear-gradient(to right, #5c7e10, #76a113); 
            color: white;
            padding: 6px 12px; 
            font-size: 13px; 
            font-weight: 600; 
            border-radius: 3px;
            text-decoration: none; 
            margin-left: 15px; 
            box-shadow: 1px 1px 3px rgba(0,0,0,0.3);
        }
        .charge-btn:hover { 
        	background: linear-gradient(to right, #76a113, #8ed629);
        	transform: translateY(-1px); }

        /* 정보 박스 */
        .info-group {
            background-color: rgba(0, 0, 0, 0.25); 
            padding: 20px;
            border-radius: 4px;
			margin-bottom: 20px; 
			border: 1px solid rgba(255,255,255,0.05);
        }
        .info-title {
            color: #66c0f4; font-size: 17px; 
            margin-bottom: 18px; 
            font-weight: 600;
            text-transform: uppercase; 
            letter-spacing: 1px; 
            border-bottom: 1px solid #3d4450; 
            padding-bottom: 8px;
        }
        .info-row {
            display: flex; 
            align-items: center; 
            margin-bottom: 14px; 
            font-size: 15px;
            border-bottom: 1px solid #2a2e35; 
            padding-bottom: 10px;
        }
        .info-row:last-child { 
        	border-bottom: none; 
        	margin-bottom: 0; 
        }
        
        .label {
        	width: 130px; 
        	color: #96a3ae; 
        	font-weight: 500; 
        }
        
        .value { 
        	color: #ffffff; 
        	flex: 1; 
        	font-weight: 400; 
        }

        .admin-badge {
            background-color: #d9534f; 
            color: white; 
            padding: 3px 8px; 
            border-radius: 3px;
            font-size: 12px; 
            font-weight: 700; 
            vertical-align: middle;
            margin-left: 10px;
        }

        /* 🧾 구매 내역 테이블 */
        .history-table { 
        	width: 100%; 
        	border-collapse: collapse;
        	font-size: 13px; 
        }
        .history-table th {
            text-align: left; 
            padding: 10px; 
            color: #56646e; 
            border-bottom: 1px solid #3d4450;
        }
        .history-table td {
            padding: 10px; border-bottom: 1px solid #2a3f5a; color: #c7d5e0;
        }
        
        .history-table tr:last-child td { border-bottom: none; }
        .history-table tr:hover { background-color: rgba(255, 255, 255, 0.05); }
        .price-col { text-align: right; color: #fff; }
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
                        <span style="color:#66c0f4; font-weight:bold; margin-left: 10px; font-size: 13px;">
                            ${sessionScope.loginUser.userName}님
                        </span>
                        
                        <c:if test="${sessionScope.loginUser.userId != 'admin'}">
                            <span style="color:#a3cf06; font-weight:bold; margin-left: 10px; font-size: 13px;">
                                [ <fmt:formatNumber value="${sessionScope.loginUser.userPoint}" type="number"/> P ]
                            </span>
                            <a href="cartList.do">장바구니</a>
                            <a href="myOrderList.do">내 라이브러리</a>
                        </c:if>
                        
                        <a href="logout.do">로그아웃</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="profile-container">

        <div class="left-column">
            <div class="avatar-frame">
                <img src="https://avatars.akamai.steamstatic.com/fef49e7fa7e1997310d705b2a6158ff8dc1cdfeb_full.jpg" class="avatar-img" alt="Avatar">
            </div>
            <div class="status-text">현재 접속 중</div>
            
            <c:if test="${sessionScope.loginUser.userId != 'admin'}">
                <div class="level-badge">12</div>
            </c:if>
            
            <div style="margin-top: 35px; display: flex; flex-direction: column; gap: 12px; align-items: center;">
                <a href="gameList.do" class="steam-btn" style="width: 85%;">상점으로 가기</a>
                <a href="<%= path %>/logout.do" class="steam-btn" style="width: 85%;">로그아웃</a>
            </div>
        </div>

        <div class="right-column">

            <div class="profile-header">
                <div>
                    <div class="username">
                        ${myInfo.userName}
                        <c:if test="${sessionScope.loginUser.userId == 'admin'}">
                            <span class="admin-badge">관리자</span>
                        </c:if>
                    </div>
                    <div class="user-country">
                        <span class="flag">🇰🇷</span> 대한민국
                    </div>
                    <div style="margin-top: 12px; font-size: 14px; color: #66c0f4; font-weight: 500;">
                        ${myInfo.userEmail}
                    </div>
                </div>
                <div style="padding-top: 5px;">
                    <a href="<%= path %>/pwCheck.do" class="steam-btn">프로필 수정</a>
                </div>
            </div>

            <div class="info-group">
                <div class="info-title">계정 상세 정보</div>

                <c:if test="${sessionScope.loginUser.userId != 'admin'}">
                    <div class="info-row" style="background-color: rgba(163, 207, 6, 0.1); padding: 12px; border-radius: 4px; border-bottom: none;">
                        <span class="label" style="color: #b8e62c;">보유 포인트</span>
                        <span class="value" style="color: #b8e62c; font-weight: 700; font-size: 18px;">
                            <fmt:formatNumber value="${myInfo.userPoint}" type="number"/> P
                        </span>
                        <a href="<%= path %>/pointCharge.do" class="charge-btn">+ 충전하기</a>
                    </div>
                </c:if>

                <div class="info-row" style="margin-top: 10px;">
                    <span class="label">아이디</span>
                    <span class="value" style="font-family: 'Inter', monospace;">${myInfo.userId}</span>
                </div>
                <div class="info-row">
                    <span class="label">휴대전화</span>
                    <span class="value">${myInfo.userPhone}</span>
                </div>
                <div class="info-row">
                    <span class="label">주소</span>
                    <span class="value">${myInfo.userAddr}</span>
                </div>
                <div class="info-row">
                    <span class="label">가입일</span>
                    <span class="value">${myInfo.joinDate}</span>
                </div>
            </div>

            <c:if test="${sessionScope.loginUser.userId != 'admin'}">
                <div class="info-group">
                    <div class="info-title">자금 사용 기록 (Purchase History)</div>

                    <table class="history-table">
                        <thead>
                            <tr>
                                <th>날짜</th>
                                <th>항목 (게임명)</th>
                                <th>변동 유형</th>
                                <th style="text-align: right;">합계</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${myOrderList}">
                                <tr>
                                    <td>${order.orderDate}</td>
                                    <td>
                                        <a href="<%= path %>/gameDetail.do?gameNo=${order.gameNo}" style="color: #c7d5e0; text-decoration: none;">
                                            ${order.gameName}
                                        </a>
                                    </td>
                                    <td>Purchase</td>
                                    <td class="price-col">
                                        - ₩ <fmt:formatNumber value="${order.orderPrice}" type="number"/>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty myOrderList}">
                                <tr>
                                    <td colspan="4" style="text-align: center; padding: 20px; color: #556772;">
                                        구매 내역이 없습니다.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <c:if test="${sessionScope.loginUser.userId == 'admin'}">
                <div class="info-group" style="border: 1px solid #d9534f; background-color: rgba(217, 83, 79, 0.1);">
                    <div class="info-title" style="color: #ff7b77; border-bottom-color: #ff7b77;">관리자 전용 메뉴</div>
                    
                    <div class="admin-menu-group">
                        <a href="userList.do" class="steam-btn" style="background-color: rgba(217, 83, 79, 0.3);">
                            전체 회원 목록 조회
                        </a>
                        <a href="adminOrderList.do" class="steam-btn" style="background-color: rgba(217, 83, 79, 0.3);">
                            전체 주문 내역 조회
                        </a>
                    </div>
                </div>
            </c:if>

            <div style="text-align: right; margin-top: 25px;">
                <c:if test="${sessionScope.loginUser.userId != 'admin'}">
                    <a href="<%= path %>/userDeleteCheck.do"
                       onclick="return confirm('정말 탈퇴하시겠습니까? 구매 내역과 포인트가 모두 사라집니다.')"
                       class="steam-btn danger"
                       style="background: transparent; color: #777; font-size: 13px; padding: 8px 15px;">
                        회원 탈퇴
                    </a>
                </c:if>
            </div>

        </div>
    </div>

</body>
</html>