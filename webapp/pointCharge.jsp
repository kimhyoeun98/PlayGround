<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PGCOIN 충전</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

<style>
    /* 스팀 기본 테마 */
    body {
        background-color: #1b2838;
        color: #c7d5e0;
        font-family: 'Inter', 'Noto Sans KR', sans-serif;
        margin: 0;
        /* 기존 padding-top 제거하고 flex 방향을 세로로 변경하여 헤더 배치 */
        display: flex;
        flex-direction: column; 
        align-items: center;
        min-height: 100vh;
    }
    
    /* 글로벌 헤더 (gameList.jsp와 동일) */
    .global-header { 
        background-color: #171a21; 
        padding: 20px 0; 
        width: 100%;
        display: flex; 
        justify-content: center; 
        box-shadow: 0 0 10px rgba(0,0,0,0.5); 
        margin-bottom: 50px; /* 본문과 간격 띄우기 */
    }
    
    .header-content { 
        width: 940px; /* 메인 컨텐츠와 너비 맞춤 */
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

    /* 컨텐츠 박스 */
    .container { width: 700px; padding-bottom: 50px; }
    
    /* 헤더 */
    .page-title {
        font-size: 28px;
        color: white;
        text-transform: uppercase;
        font-weight: 300;
        margin-bottom: 20px;
        letter-spacing: 1px;
    }
    
    /* 현재 잔액 박스 */
    .balance-area {
        background-color: #000000;
        padding: 15px;
        border-radius: 3px;
        margin-bottom: 30px;
        text-align: right;
        border: 1px solid #333;
    }
    
    .balance-label { font-size: 14px; color: #8f98a0; }
    .balance-value { font-size: 24px; color: #66c0f4; font-weight: bold; }

    /* 금액 선택 리스트 */
    .fund-option {
        background-color: rgba( 0, 0, 0, 0.2 );
        margin-bottom: 5px;
        padding: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        transition: background-color 0.2s;
    }
    .fund-option:hover { background-color: #2a475e; }
    
    .amount-text {
        font-size: 16px;
        color: #ffffff;
        font-weight: bold;
    }
    
    .min-amount { font-size: 12px; color: #8f98a0; margin-left: 10px; }

    /* 자금 추가 버튼 (스팀 그린) */
    .btn-add-fund {
        background: linear-gradient( to bottom, #5c7e10 5%, #4b6a0a 95%);
        color: #d2efa9;
        border: none;
        padding: 8px 15px;
        border-radius: 2px;
        font-size: 15px;
        cursor: pointer;
        text-decoration: none;
        font-weight: bold;
        text-shadow: 1px 1px 0px rgba(0,0,0,0.3);
        box-shadow: 0 0 5px rgba(0,0,0,0.2);
    }
    
    .btn-add-fund:hover {
        background: linear-gradient( to bottom, #8ed629 5%, #6aa621 95%);
        color: white;
    }
    
    /* 뒤로가기 링크 */
    .back-link {
        display: block;
        margin-top: 20px;
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
                <span style="color:#66c0f4">${sessionScope.loginUser.userName}님</span>
                <span style="color:#a3cf06; font-weight:bold; margin-left: 10px; font-size: 13px;">
                    [ <fmt:formatNumber value="${sessionScope.loginUser.userPoint}" type="number"/> P ]
                </span>
                <a href="<%= path %>/boardList.do" class="nav-item">커뮤니티</a>
                <a href="<%= path %>/myInfo.do">마이페이지</a>
                <a href="<%= path %>/logout.do">로그아웃</a>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="page-title">Playground 지갑에 자금 입금</div>
        
        <div class="balance-area">
            <span class="balance-label">현재 지갑 잔액:</span>
            <span class="balance-value">
                ₩ <fmt:formatNumber value="${sessionScope.loginUser.userPoint}" type="number"/>
            </span>
        </div>
    
        <div style="font-size: 14px; color: #c6d4df; margin-bottom: 15px;">
            Playground 지갑에 자금을 추가하여 게임을 구매하거나 게임 내 아이템을 구매하세요.
        </div>
    
        <div class="fund-option">
            <div><span class="amount-text">₩ 5,000</span></div>
            <form action="<%= path %>/pointCharge.do" method="post" style="margin:0;">
                <input type="hidden" name="amount" value="5000">
                <button type="submit" class="btn-add-fund">자금 추가</button>
            </form>
        </div>
    
        <div class="fund-option">
            <div><span class="amount-text">₩ 10,000</span></div>
            <form action="<%= path %>/pointCharge.do" method="post" style="margin:0;">
                <input type="hidden" name="amount" value="10000">
                <button type="submit" class="btn-add-fund">자금 추가</button>
            </form>
        </div>
        
        <div class="fund-option">
            <div><span class="amount-text">₩ 25,000</span></div>
            <form action="<%= path %>/pointCharge.do" method="post" style="margin:0;">
                <input type="hidden" name="amount" value="25000">
                <button type="submit" class="btn-add-fund">자금 추가</button>
            </form>
        </div>
    
        <div class="fund-option">
            <div><span class="amount-text">₩ 50,000</span></div>
            <form action="<%= path %>/pointCharge.do" method="post" style="margin:0;">
                <input type="hidden" name="amount" value="50000">
                <button type="submit" class="btn-add-fund">자금 추가</button>
            </form>
        </div>
        
        <div class="fund-option">
            <div><span class="amount-text">₩ 100,000</span></div>
            <form action="<%= path %>/pointCharge.do" method="post" style="margin:0;">
                <input type="hidden" name="amount" value="100000">
                <button type="submit" class="btn-add-fund">자금 추가</button>
            </form>
        </div>
    
        <a href="<%= path %>/gameList.do" class="back-link">&lt; 상점으로 돌아가기</a>
    </div>

</body>
</html>