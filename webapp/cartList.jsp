<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 장바구니</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        /* 🌑 기본 레이아웃 스타일 */
        body { background-color: #1b2838; color: #c7d5e0; font-family: 'Inter', 'Noto Sans KR', sans-serif; margin: 0; padding-bottom: 50px; display: flex; flex-direction: column; align-items: center; }
        .global-header { width: 100%; background: #171a21; padding: 20px 0; display: flex; justify-content: center; box-shadow: 0 0 10px rgba(0,0,0,0.5); margin-bottom: 30px; }
        .header-content { width: 940px; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 24px; font-weight: bold; color: #c7d5e0; text-decoration: none; letter-spacing: 2px; }
        .user-menu a { color: #b8b6b4; text-decoration: none; font-size: 13px; margin-left: 15px; }
        .user-menu a:hover { color: white; }
        .active-link { color: white !important; text-decoration: underline !important; }
        .container { width: 940px; margin-top: 30px; }
        .page-title { font-size: 28px; color: white; text-transform: uppercase; margin-bottom: 20px; font-weight: 300; letter-spacing: 1px; }

        /* 장바구니 리스트 스타일 */
        .cart-row { background-color: #212429; padding: 15px 20px; margin-bottom: 5px; display: flex; align-items: center; border-radius: 2px; transition: background-color 0.2s; }
        .cart-row:hover { background-color: #2a475e; }
        .cart-check { margin-right: 15px; transform: scale(1.5); cursor: pointer; }
        .cart-img { width: 120px; height: 56px; background-color: #000; margin-right: 20px; object-fit: cover; flex-shrink: 0; }
        .cart-info { flex: 1; }
        .cart-title { font-size: 16px; color: #ffffff; font-weight: bold; margin-bottom: 5px; text-decoration: none; }
        .cart-title:hover { color: #66c0f4; text-decoration: underline; }
        .cart-price { color: #c7d5e0; font-size: 14px; text-align: right; }

        /* 하단 결제 바 및 버튼 */
        .checkout-bar { background-color: #2a475e; padding: 20px; margin-top: 20px; display: flex; justify-content: space-between; align-items: center; border-radius: 2px; }
        .total-price-label { font-size: 14px; color: #b8b6b4; }
        .total-price-value { font-size: 24px; color: #ffffff; font-weight: bold; margin-left: 10px; }
        .btn-purchase { background: linear-gradient( to bottom, #75b022 5%, #588a1b 95%); color: #d2efa9; border: none; padding: 10px 30px; font-size: 16px; font-weight: bold; border-radius: 2px; cursor: pointer; text-shadow: 1px 1px 0px rgba(0,0,0,0.3); }
        .btn-purchase:hover { background: linear-gradient( to bottom, #8ed629 5%, #6aa621 95%); color: white; }
        .btn-clear { color: #8f98a0; text-decoration: none; font-size: 13px; cursor: pointer; margin-right: 20px; border-bottom: 1px dashed #8f98a0; background: none; border: none; padding: 0; font-family: inherit; }
        .btn-clear:hover { color: white; border-bottom: 1px solid white; }
        .delete-text { color: #8f98a0; font-weight: bold; margin-right: 20px; text-decoration: none; border-bottom: 1px dashed #ff6b6b; transition: color 0.2s, border-bottom 0.2s; background: none; border: none; padding: 0; cursor: pointer; }
        .delete-text:hover { color: #d9534f; border-bottom: 1px solid #d9534f; }
        .empty-cart { padding: 50px; text-align: center; color: #8f98a0; font-size: 18px; background: rgba(0,0,0,0.2); }

        /* 🚨 모달(팝업) 스타일 복구 */
        .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.8); z-index: 9999; backdrop-filter: blur(3px); }
        .modal-box { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #212429; width: 420px; padding: 30px; border-radius: 4px; border: 1px solid #3d4450; box-shadow: 0 10px 30px rgba(0,0,0,0.5); text-align: center; }
        .modal-icon { font-size: 40px; margin-bottom: 15px; }
        .modal-title { font-size: 20px; color: #ffffff; margin-bottom: 10px; font-weight: bold; }
        .modal-text { font-size: 15px; color: #c7d5e0; margin-bottom: 30px; line-height: 1.5; }
        .modal-btn-group { display: flex; justify-content: center; gap: 10px; }
        .modal-btn { border: none; padding: 10px 20px; font-size: 14px; font-weight: bold; border-radius: 2px; cursor: pointer; color: white; transition: 0.2s; }
        .modal-btn.charge { background: linear-gradient( to bottom, #66c0f4 5%, #4b96c4 95%); }
        .modal-btn.close { background-color: #3d4450; color: #c7d5e0; }
        .modal-btn.danger { background: linear-gradient(to bottom, #d9534f 5%, #c9302c 95%); }
    </style>
    
    <script>
        function calcTotal() {
            let total = 0;
            let checkboxes = document.querySelectorAll('input[name="rowCheck"]:checked');
            checkboxes.forEach(function(box) { total += parseInt(box.getAttribute('data-price')); });
            document.getElementById('totalDisplay').innerText = "₩ " + total.toLocaleString();
        }
        
        function showModal(title, msg, type) {
            document.getElementById('modalTitle').innerText = title;
            document.getElementById('modalText').innerHTML = msg;
            document.getElementById('alertButtons').style.display = (type === 'alert') ? 'flex' : 'none';
            document.getElementById('deleteButtons').style.display = (type === 'delete') ? 'flex' : 'none';
            document.getElementById('customModal').style.display = 'block';
        }

        function closeModal() { document.getElementById('customModal').style.display = 'none'; }

        function submitDelete() {
            const checkedItems = document.querySelectorAll('input[name="rowCheck"]:checked');
            if (checkedItems.length === 0) {
                showModal("알림", "삭제할 항목을 1개 이상 선택해 주세요.", "alert");
                return;
            }
            showModal("장바구니 항목 삭제", "선택된 <b>" + checkedItems.length + "개</b>의 상품을 삭제하시겠습니까?", "delete");
        }

        function executeDelete() {
            const form = document.getElementById('cartForm');
            form.action = "<%= path %>/cartDeleteSelected.do";
            form.submit();
        }
        
        window.onload = function() {
            calcTotal();
            <c:if test="${not empty sessionScope.msg}">
                showModal("알림", "${sessionScope.msg}", "alert");
                <% session.removeAttribute("msg"); %>
            </c:if>
        }
    </script>
</head>
<body>
    <div id="customModal" class="modal-overlay">
        <div class="modal-box">
            <div id="modalIcon" class="modal-icon">⚠️</div>
            <div id="modalTitle" class="modal-title"></div>
            <div id="modalText" class="modal-text"></div>
            <div id="alertButtons" class="modal-btn-group" style="display:none;">
                <button type="button" class="modal-btn charge" onclick="location.href='<%= path %>/pointCharge.do'">충전하기</button>
                <button type="button" class="modal-btn close" onclick="closeModal()">확인</button>
            </div>
            <div id="deleteButtons" class="modal-btn-group" style="display:none;">
                <button type="button" class="modal-btn danger" onclick="executeDelete()">삭제</button>
                <button type="button" class="modal-btn close" onclick="closeModal()">취소</button>
            </div>
        </div>
    </div>

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
                        <span style="color: #66c0f4; font-weight: bold; font-size: 13px;">${sessionScope.loginUser.userName}님</span>
                        <c:if test="${sessionScope.loginUser.userId != 'admin'}">
                            <span style="color:#a3cf06; font-weight:bold; margin-left: 10px;">[ <fmt:formatNumber value="${sessionScope.loginUser.userPoint}" type="number"/> P ]</span>
                            <a href="<%= path %>/cartList.do" class="active-link">장바구니</a>
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
        <div class="page-title">나의 장바구니</div>
        <form id="cartForm" action="<%= path %>/cartBuy.do" method="post">
            <c:if test="${empty cartList}">
                <div class="empty-cart">장바구니가 비어있습니다.<br><a href="gameList.do" style="color: #66c0f4; display: block; margin-top: 10px;">상점으로 돌아가기</a></div>
            </c:if>
            <c:forEach var="cart" items="${cartList}">
                <div class="cart-row">
                    <input type="checkbox" name="rowCheck" value="${cart.cartNo}" data-price="${cart.gamePrice}" class="cart-check" checked onclick="calcTotal()">
                    <img src="${pageContext.request.contextPath}/upload/${cart.gameImg}" class="cart-img">
                    <div class="cart-info">
                        <a href="gameDetail.do?gameNo=${cart.gameNo}" class="cart-title">${cart.gameName}</a>
                        <div style="font-size: 12px; color: #8f98a0;">Windows</div>
                    </div>
                    <div style="text-align: right;">
                        <div class="cart-price"><c:choose><c:when test="${cart.gamePrice == 0}">무료</c:when><c:otherwise>₩ <fmt:formatNumber value="${cart.gamePrice}" type="number"/></c:otherwise></c:choose></div>
                        <a href="<%= path %>/cartDelete.do?cartNo=${cart.cartNo}" style="color: #66c0f4; font-size: 12px; text-decoration: underline; display: block; margin-top: 5px;">제거</a>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${not empty cartList}">
                <div class="checkout-bar">
                    <div style="display: flex; gap: 15px; align-items: center;">
                        <button type="button" onclick="submitDelete()" class="delete-text">선택 상품 삭제</button>
                        <a href="<%= path %>/cartClear.do" onclick="return confirm('장바구니를 모두 비우시겠습니까?')" class="btn-clear">장바구니 비우기</a>
                        <a href="gameList.do" class="btn-clear">쇼핑 계속하기</a>
                    </div>
                    <div style="text-align: right; display: flex; align-items: center;">
                        <div><span class="total-price-label">예상 합계:</span><div id="totalDisplay" class="total-price-value">₩ 0</div></div>
                        <button type="submit" class="btn-purchase" style="margin-left: 30px;">선택 상품 구매</button>
                    </div>
                </div>
            </c:if>
        </form>
    </div>
</body>
</html>