<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${board.title} - PG 커뮤니티</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        /* 기본 테마 */
        body {
            background-color: #1b2838;
            color: #c7d5e0;
            font-family: 'Inter', 'Noto Sans KR', sans-serif;
            margin: 0;
            padding-bottom: 50px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* 글로벌 헤더 스타일 */
        .global-header {
            width: 100%;
            background: #171a21;
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
            background-color: #212429;
            padding: 30px;
            border-radius: 4px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            border: 1px solid #3d4450;
        }

        /* 게시글 헤더 */
        .post-header {
            border-bottom: 1px solid #363b45;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }

        .post-title {
            font-size: 26px;
            color: white;
            font-weight: bold;
            margin-bottom: 10px;
            line-height: 1.4;
        }

        .post-meta {
            font-size: 13px;
            color: #8f98a0;
        }

        .author-name {
            color: #66c0f4;
            font-weight: bold;
            margin-right: 10px;
        }

        .meta-divider {
            margin: 0 5px;
            color: #4b5663;
        }

        /* 본문 내용 */
        .post-content {
            font-size: 15px;
            line-height: 1.8;
            color: #acb2b8;
            min-height: 200px;
            white-space: pre-wrap; /* 엔터키(줄바꿈) 적용 */
        }

        /* 댓글 영역 스타일 */
        .reply-area {
            margin-top: 40px;
            border-top: 1px solid #363b45;
            padding-top: 20px;
        }

        .reply-title {
            font-size: 18px;
            color: white;
            margin-bottom: 15px;
            font-weight: bold;
        }

        /* 댓글 입력폼 */
        .reply-form {
            background: rgba(0, 0, 0, 0.2);
            padding: 15px;
            border-radius: 4px;
            display: flex;
            gap: 10px;
        }

        .reply-input {
            flex: 1;
            background: #1b2838;
            border: 1px solid #4b5663;
            color: white;
            padding: 10px;
            border-radius: 2px;
        }

        .btn-reply {
            background: #66c0f4;
            color: white;
            border: none;
            padding: 0 20px;
            font-weight: bold;
            cursor: pointer;
            border-radius: 2px;
        }

        .btn-reply:hover {
            background: #4b96c4;
        }

        /* 댓글 목록 */
        .reply-list {
            margin-top: 20px;
        }

        .reply-item {
            padding: 15px 0;
            border-bottom: 1px solid #2a3f5a;
            display: flex;
            justify-content: space-between;
        }

        .reply-writer {
            color: #66c0f4;
            font-weight: bold;
            font-size: 14px;
            margin-bottom: 5px;
        }

        .reply-content {
            color: #c7d5e0;
            font-size: 14px;
        }

        .reply-date {
            color: #56646e;
            font-size: 12px;
            margin-left: 10px;
        }

        .btn-del-reply {
            color: #a94847;
            font-size: 12px;
            text-decoration: none;
            margin-left: 10px;
            border: 1px solid #a94847;
            padding: 2px 6px;
            border-radius: 2px;
        }

        .btn-del-reply:hover {
            background-color: #a94847;
            color: white;
        }

        /* 하단 버튼 영역 */
        .btn-area {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #363b45;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .btn-list {
            background-color: #3d4450;
            color: white;
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 2px;
            font-size: 14px;
        }

        .btn-list:hover {
            background-color: #4b5663;
        }

        .btn-delete {
            background-color: transparent;
            color: #a94847;
            padding: 8px 15px;
            text-decoration: none;
            border: 1px solid #a94847;
            border-radius: 2px;
            font-size: 14px;
        }

        .btn-delete:hover {
            background-color: #a94847;
            color: white;
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

        <div class="post-header">
            <div class="post-title">${board.title}</div>
            <div class="post-meta">
                <span class="author-name">👤 ${board.writer}</span>
                <span class="meta-divider">|</span>
                <span>작성일: ${board.regDate}</span>
                <span class="meta-divider">|</span>
                <span>조회: ${board.viewCnt}</span>
            </div>
        </div>

        <div class="post-content">${board.content}</div>

        <div class="reply-area">
            <div class="reply-title">💬 댓글</div>

            <c:if test="${not empty sessionScope.loginUser}">
                <form action="<%= path %>/replyAdd.do" method="post" class="reply-form">
                    <input type="hidden" name="boardNo" value="${board.boardNo}">
                    <input type="text" name="content" class="reply-input" placeholder="댓글을 입력하세요..." required>
                    <button type="submit" class="btn-reply">등록</button>
                </form>
            </c:if>
            <c:if test="${empty sessionScope.loginUser}">
                <div style="padding: 15px; background: rgba(0,0,0,0.2); color: #8f98a0; text-align: center; border-radius: 4px;">
                    로그인 후 댓글을 작성할 수 있습니다.
                </div>
            </c:if>

            <div class="reply-list">
                <c:forEach var="reply" items="${replyList}">
                    <div class="reply-item">
                        <div>
                            <div class="reply-writer">
                                ${reply.writer}
                                <span class="reply-date">${reply.regDate}</span>
                            </div>
                            <div class="reply-content">${reply.content}</div>
                        </div>

                        <c:if test="${sessionScope.loginUser.userId == reply.writer || sessionScope.loginUser.userId == 'admin'}">
                            <div>
                                <a href="<%= path %>/replyDelete.do?replyNo=${reply.replyNo}&boardNo=${board.boardNo}"
                                   onclick="return confirm('댓글을 삭제하시겠습니까?')"
                                   class="btn-del-reply">✕ 삭제</a>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>

                <c:if test="${empty replyList}">
                    <div style="padding: 20px; text-align: center; color: #56646e;">
                        아직 작성된 댓글이 없습니다.
                    </div>
                </c:if>
            </div>
        </div>

        <div class="btn-area">
            <a href="<%= path %>/boardList.do" class="btn-list">목록으로</a>

            <c:if test="${sessionScope.loginUser.userId == board.writer || sessionScope.loginUser.userId == 'admin'}">
                <a href="<%= path %>/boardDelete.do?no=${board.boardNo}" 
                   onclick="return confirm('정말 게시글을 삭제하시겠습니까? 복구할 수 없습니다.')" 
                   class="btn-delete">🗑️ 게시글 삭제</a>
            </c:if>
        </div>

    </div>

</body>
</html>