<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PGWORKS</title>
<style>
    /* 🌑 배경 및 기본 폰트 */
    body { 
        background-color: #1b2838; 
        color: #dcdedf; 
        font-family: "Motiva Sans", Arial, sans-serif; 
        display: flex; 
        justify-content: center; 
        align-items: center; 
        min-height: 100vh; 
        margin: 0; 
    }

    /* 📦 메인 폼 컨테이너 */
    .admin-container { 
        width: 600px; 
        background-color: #212429; 
        padding: 40px; 
        border-radius: 4px; 
        box-shadow: 0 0 20px rgba(0,0,0,0.5); 
        border-top: 3px solid #f0ad4e; 
    }

    /* 🏷️ 헤더 영역 */
    .header-area { 
        border-bottom: 1px solid #3d4450; 
        padding-bottom: 20px; 
        margin-bottom: 20px; 
        display: flex; 
        justify-content: space-between; 
        align-items: center; 
    }

    h2 { 
        margin: 0; 
        color: #ffffff; 
        font-size: 24px; 
        font-weight: 300; 
        text-transform: uppercase; 
    }

    .badge { 
        background: #3d4450; 
        color: #f0ad4e; 
        padding: 5px 10px; 
        font-size: 12px; 
        border-radius: 2px; 
        font-weight: bold; 
    }
    
    /* 📝 입력 폼 스타일 */
    .form-group { 
        margin-bottom: 20px; 
    }

    label { 
        display: block; 
        margin-bottom: 8px; 
        color: #66c0f4; 
        font-size: 13px; 
        font-weight: bold; 
        text-transform: uppercase; 
    }
    
    input[type="text"], input[type="number"], textarea, select, input[type="file"] { 
        width: 100%; 
        padding: 12px; 
        background-color: #2a3f5a; 
        border: 1px solid #45556c; 
        color: white; 
        box-sizing: border-box; 
        border-radius: 3px; 
        font-size: 14px; 
    }

    input:focus, textarea:focus, select:focus { 
        outline: none; 
        border-color: #f0ad4e; 
        background-color: #324b6b; 
    }
    
    /* 🔒 읽기 전용 필드 스타일 (수정 불가) */
    .read-only {
        background-color: #1b1e24; /* 더 어두운 배경 */
        color: #6a7680; /* 흐릿한 글씨 */
        border: 1px solid #2a313b;
        cursor: not-allowed; /* 금지 커서 */
    }
    
    .read-only:focus { 
        border-color: #2a313b; 
        background-color: #1b1e24; 
    }

    /* ⚠️ 안내 박스 */
    .info-box {
        background: rgba(240, 173, 78, 0.1);
        border: 1px solid #f0ad4e;
        color: #f0ad4e;
        padding: 15px;
        font-size: 13px;
        margin-bottom: 20px;
        line-height: 1.6;
    }

    /* 버튼 및 링크 */
    button { 
        margin-top: 20px; 
        width: 100%; 
        padding: 15px; 
        background: linear-gradient( to bottom, #1a9fff 5%, #106db0 95%); 
        color: white; 
        border: none; 
        border-radius: 3px; 
        cursor: pointer; 
        font-size: 16px; 
        font-weight: bold; 
    }

    button:hover { 
        filter: brightness(1.2); 
    }

    .bottom-link { 
        display: block; 
        text-align: center; 
        margin-top: 20px; 
        color: #8f98a0; 
        text-decoration: none; 
        font-size: 13px; 
    }
    
    .current-file-info {
        font-size: 12px;
        color: #a3cf06;
        margin-top: 5px;
    }

    .bottom-link:hover { 
        color: white; 
        text-decoration: underline; 
    }
</style>
</head>
<body>

    <div class="admin-container">
        
        <div class="header-area">
            <h2>Edit Details</h2>
            <span class="badge">LIMITED UPDATE</span>
        </div>
        
        <div class="info-box">
            <strong>관리자 정책 알림:</strong><br>
            현재 <u>가격</u>, <u>제작사</u>, <u>이미지</u>, <u>판매 상태</u>만 수정 가능합니다.<br>
            <br>
            ※ 게임 이름이나 설명을 대폭 수정해야 한다면?<br>
            아래에서 <strong>[🔴 판매 중지]</strong>로 변경하여 저장한 후, <br>
            <strong>[게임 등록]</strong> 메뉴에서 새로 등록해 주세요.
        </div>
        
        <form action="<%= path %>/gameUpdate.do" method="post" enctype="multipart/form-data">
            
            <input type="hidden" name="gameNo" value="${game.gameNo}">
            
            <div class="form-group">
                <label>Product Name (Locked)</label>
                <input type="text" name="gameName" value="${game.gameName}" class="read-only" readonly>
            </div>
            
            <div class="form-group" style="display: flex; gap: 20px;">
                <div style="flex: 1;">
                    <label>Genre (Locked)</label>
                    <input type="text" name="gameGenre" value="${game.gameGenre}" class="read-only" readonly>
                </div>
                
                <div style="flex: 1;">
                    <label for="gameDev" style="color: #f0ad4e;">Developer (Edit)</label>
                    <input type="text" id="gameDev" name="gameDev" value="${game.gameDev}" required>
                </div>
            </div>
            
            <div class="form-group" style="display: flex; gap: 20px;">
                <div style="flex: 1;">
                    <label for="gamePrice" style="color: #f0ad4e;">Price (KRW) (Edit)</label>
                    <input type="number" id="gamePrice" name="gamePrice" value="${game.gamePrice}" required>
                </div>

                <div style="flex: 1;">
                    <label for="status" style="color: #f0ad4e;">Sale Status (Edit)</label>
                    <select id="status" name="status">
                        <option value="1" <c:if test="${game.status == 1}">selected</c:if>>🟢 On Sale (판매 중)</option>
                        <option value="0" <c:if test="${game.status == 0}">selected</c:if>>🔴 Stop Selling (판매 중지)</option>
                    </select>
                </div>
            </div>
            
            <div class="form-group">
                <label>Store Description (Locked)</label>
                <textarea name="gameDesc" class="read-only" rows="6" readonly>${game.gameDesc}</textarea>
            </div>
            
            <div class="form-group">
                 <label style="color: #f0ad4e;">Game Image (Edit)</label>
                 <input type="file" name="gameImgFile" accept="image/*" style="color: #c7d5e0;">
                 
                 <input type="hidden" name="oldGameImg" value="${game.gameImg}">
                 
                 <c:if test="${not empty game.gameImg}">
                    <div class="current-file-info">
                        ℹ️ 현재 파일: ${game.gameImg} (파일을 선택하지 않으면 유지됩니다)
                    </div>
                 </c:if>
            </div>
            
            <button type="submit">UPDATE INFO</button>
        </form>
        
        <a href="gameDetail.do?gameNo=${game.gameNo}" class="bottom-link">취소하고 돌아가기</a>
    </div>

</body>
</html>