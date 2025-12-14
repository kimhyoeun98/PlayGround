<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자: 전체 주문 내역</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        body { background-color: #1b2838; color: #c7d5e0; font-family: 'Inter', 'Noto Sans KR', sans-serif; margin: 0; padding-bottom: 50px; display: flex; flex-direction: column; align-items: center; }
        .container { width: 940px; margin-top: 30px; }
        .page-title { font-size: 28px; color: white; font-weight: 300; margin-bottom: 20px; border-bottom: 1px solid #363b45; padding-bottom: 10px; }
        .order-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .order-table th { background-color: #2a475e; color: white; padding: 12px; text-align: left; font-size: 14px; }
        .order-table td { background-color: #212429; padding: 12px; border-bottom: 1px solid #1b2838; font-size: 13px; }
        .order-table tr:hover td { background-color: #2c5172; cursor: default; }
        .status-complete { color: #75b022; font-weight: bold; }
        .status-refund { color: #d9534f; font-weight: bold; }
        .no-data { text-align: center; padding: 40px; background-color: #212429; color: #8f98a0; }
        .back-link { display: inline-block; margin-top: 20px; color: #66c0f4; text-decoration: none; font-size: 13px; }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>

    <div class="container">
        <div class="page-title">📦 관리자 대시보드: 전체 주문 내역</div>

        <table class="order-table">
            <thead>
                <tr>
                    <th style="width: 10%;">주문 번호</th>
                    <th style="width: 15%;">구매자 ID</th>
                    <th style="width: 35%;">게임 제목</th>
                    <th style="width: 15%; text-align: right;">결제 금액 (₩)</th>
                    <th style="width: 15%;">주문 일자</th>
                    <th style="width: 10%;">상태</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty orderList}">
                        <tr>
                            <td colspan="6" class="no-data">등록된 주문 내역이 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="order" items="${orderList}">
                            <tr>
                                <td>${order.orderNo}</td>
                                <td>${order.userId}</td>
                                <td>${order.gameName}</td>
                                <td style="text-align: right;"><fmt:formatNumber value="${order.orderPrice}" type="number"/></td>
                                <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.status == 1}">
                                            <span class="status-complete">구매 완료</span>
                                        </c:when>
                                        <c:when test="${order.status == 0}">
                                            <span class="status-refund">환불 완료</span>
                                        </c:when>
                                        <c:otherwise>
                                            -
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <a href="userList.do" class="back-link">← 관리자 회원 목록으로 돌아가기</a>
    </div>

</body>
</html>