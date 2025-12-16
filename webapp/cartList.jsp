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
        /* 기본 스타일 (장바구니 전용) */
        body { background-color: #1b2838; color: #c7d5e0; font-family: 'Inter', 'Noto Sans KR', sans-serif; margin: 0; padding-bottom: 50px; display: flex; flex-direction: column; align-items: center; }
        .global-header { width: 100%; background: #171a21; padding: 20px 0; display: flex; justify-content: center; box-shadow: 0 0 10px rgba(0,0,0,0.5); margin-bottom: 30px; }
        .header-content { width: 940px; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 24px; font-weight: bold; color: #c7d5e0; text-decoration: none; letter-spacing: 2px; }
        .user-menu a { color: #b8b6b4; text-decoration: none; font-size: 13px; margin-left: 15px; }
        .container { width: 940px; margin-top: 30px; }
        .cart-row { background-color: #212429; padding: 15px 20px; margin-bottom: 5px; display: flex; align-items: center; border-radius: 2px; }
        .cart-row:hover { background-color: #2a475e; }
        .cart-img { width: 120px; height: 56px; background-color: #000; margin-right: 20px; object-fit: cover; }
        .cart-info { flex: 1; }
        .cart-title { font-size: 16px; color: #ffffff; font-weight: bold; text-decoration: none; }
        .checkout-bar { background-color: #2a475e; padding: 20px; margin-top: 20px; display: flex; justify-content: space-between; align-items: center; }
        .btn-purchase { background: linear-gradient(to bottom, #75b022 5%, #588a1b 95%); color: #d2efa9; border: none; padding: 10px 30px; font-size: 16px; font-weight: bold; cursor: pointer; }

        /* 모달 스타일 */
        .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.8); z-index: 9999; backdrop-filter: blur(3px); }
        .modal-box { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #212429; width: 420px; padding: 30px; border-radius: 4px; border: 1px solid #3d4450; text-align: center; }
        .modal-btn-group { display: flex; justify-content: center; gap: 10px; margin-top: 20px; }
        .modal-btn { border: none; padding: 10px 20px; font-size: 14px; font-weight: bold; border-radius: 2px; cursor: pointer; color: white; }
        .modal-btn.charge { background: linear-gradient(to bottom, #66c0f4 5%, #4b96c4 95%); }
        .modal-btn.close { background-color: #3d4450; color: #c7d5e0; }
        .modal-btn.danger { background: linear-gradient(to bottom, #d9534f 5%, #c9302c 95%); }
    </style>
    
    <script>
        function calcTotal() {
            let total = 0;
            let checkboxes = document.querySelectorAll('input[name="rowCheck"]:checked');
            checkboxes.forEach(box => total += parseInt(box.getAttribute('data-price')));
            document.getElementById('totalDisplay').innerText = "₩ " + total.toLocaleString();
        }

        // 모달 관리
        function showModal(title, text, type) {
            document.getElementById('modalTitle').innerText = title;
            document.getElementById('modalText').innerHTML = text;
            
            // 버튼 제어 (결제 부족 시 충전하기 버튼 노출)
            document.getElementById('alertButtons').style.display = (type === 'charge') ? 'flex' : 'none';
            document.getElementById('deleteButtons').style.display = (type === 'delete') ? 'flex' : 'none';
            document.getElementById('simpleButtons').style.display = (type === 'simple') ? 'flex' : 'none';
            
            document.getElementById('customModal').style.display = 'block';
        }

        function closeModal() { document.getElementById('customModal').style.display = 'none'; }

        function submitDelete() {
            const checkedCount = document.querySelectorAll('input[name="rowCheck"]:checked').length;
            if (checkedCount === 0) {
                showModal("알림", "삭제할 항목을 선택해주세요.", "simple");
                return;
            }
            showModal("삭제 확인", checkedCount + "개의 상품을 삭제하시겠습니까?", "delete");
        }

        function executeDelete() {
            document.getElementById('cartForm').action = "<%= path %>/cartDeleteSelected.do";
            document.getElementById('cartForm').submit();
        }

        window.onload = function() {
            calcTotal();
            <c:if test="${not empty sessionScope.msg}">
                // 포인트 부족 알림 등 일반 메시지 처리 (중복 알림은 더 이상 여기서 오지 않음)
                showModal("알림", "${sessionScope.msg}", "charge");
                <% session.removeAttribute("msg"); %>
            </c:if>
        }
    </script>
</head>
<body>
    <div id="customModal" class="modal-overlay">
        <div class="modal-box">
            <div id="modalTitle" style="font-size:20px; color:white; margin-bottom:15px; font-weight:bold;"></div>
            <div id="modalText" style="margin-bottom:20px;"></div>
            
            <div id="alertButtons" class="modal-btn-group" style="display:none;">
                <button type="button" class="modal-btn charge" onclick="location.href='<%= path %>/pointCharge.do'">충전하기</button>
                <button type="button" class="modal-btn close" onclick="closeModal()">닫기</button>
            </div>
            
            <div id="deleteButtons" class="modal-btn-group" style="display:none;">
                <button type="button" class="modal-btn danger" onclick="executeDelete()">삭제</button>
                <button type="button" class="modal-btn close" onclick="closeModal()">취소</button>
            </div>

            <div id="simpleButtons" class="modal-btn-group" style="display:none;">
                <button type="button" class="modal-btn close" onclick="closeModal()">확인</button>
            </div>
        </div>
    </div>

    <div class="global-header">
        <div class="header-content">
            <a href="<%= path %>/gameList.do" class="logo">🎮 PLAYGROUND</a>
            <div class="user-menu">
                <span style="color: #66c0f4;">${sessionScope.loginUser.userName}님</span>
                <span style="color:#a3cf06; margin-left:10px;">[ <fmt:formatNumber value="${sessionScope.loginUser.userPoint}" type="number"/> P ]</span>
                <a href="<%= path %>/cartList.do">장바구니</a>
                <a href="<%= path %>/logout.do">로그아웃</a>
            </div>
        </div>
    </div>

    <div class="container">
        <div style="font-size: 24px; color: white; margin-bottom: 20px;">장바구니</div>
        <form id="cartForm" action="<%= path %>/cartBuy.do" method="post">
            <c:forEach var="cart" items="${cartList}">
                <div class="cart-row">
                    <input type="checkbox" name="rowCheck" value="${cart.cartNo}" data-price="${cart.gamePrice}" checked onclick="calcTotal()" style="margin-right:15px;">
                    <img src="${pageContext.request.contextPath}/upload/${cart.gameImg}" class="cart-img">
                    <div class="cart-info">
                        <a href="gameDetail.do?gameNo=${cart.gameNo}" class="cart-title">${cart.gameName}</a>
                    </div>
                    <div style="text-align: right; color: white;">
                        ₩ <fmt:formatNumber value="${cart.gamePrice}" type="number"/>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${not empty cartList}">
                <div class="checkout-bar">
                    <button type="button" onclick="submitDelete()" style="background:none; border:none; color:#8f98a0; cursor:pointer; text-decoration:underline;">선택 삭제</button>
                    <div style="text-align: right;">
                        <span style="font-size:14px; color:#b8b6b4;">합계:</span>
                        <span id="totalDisplay" style="font-size:24px; color:white; font-weight:bold; margin-left:10px;">₩ 0</span>
                        <button type="submit" class="btn-purchase" style="margin-left:20px;">결제하기</button>
                    </div>
                </div>
            </c:if>
        </form>
    </div>
</body>
</html>