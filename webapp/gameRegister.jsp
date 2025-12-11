<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PGWORKS</title>
<style>
    /* 🌑 배경: 스팀웍스 스타일의 차분한 다크 그레이 */
    body { 
        background-color: #1b2838; 
        color: #dcdedf; 
        font-family: "Motiva Sans", Arial, sans-serif; 
        margin: 0; 
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
    }
    
    /* 📦 메인 폼 컨테이너 */
    .admin-container { 
        width: 600px; 
        background-color: #212429; 
        padding: 40px; 
        border-radius: 4px;
        box-shadow: 0 0 20px rgba(0,0,0,0.5);
        border-top: 3px solid #66c0f4; 
    }
    
    /* 🏷️ 헤더 영역 */
    .header-area {
        border-bottom: 1px solid #3d4450;
        padding-bottom: 20px;
        margin-bottom: 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    h2 { 
        margin: 0;
        color: #ffffff;
        font-weight: 300;
        letter-spacing: 1px;
        text-transform: uppercase;
        font-size: 24px;
    }
    
    .badge {
        background: #3d4450;
        color: #66c0f4;
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
    
    /* ✨ [수정됨] 파일 입력창(input[type="file"]) 디자인 추가 */
    input[type="text"], 
    input[type="number"], 
    input[type="file"],
    textarea { 
        width: 100%; 
        padding: 12px; 
        background-color: #2a3f5a; 
        border: 1px solid #45556c; 
        color: white; 
        box-sizing: border-box; 
        border-radius: 3px;
        font-size: 14px;
        transition: border-color 0.2s, background-color 0.2s;
    }
    
    input:focus, textarea:focus { 
        outline: none;
        border-color: #66c0f4;
        background-color: #324b6b;
    }

    textarea {
        resize: vertical; 
        line-height: 1.5;
    }
    
    /* 💡 도움말 텍스트 */
    .help-text {
        font-size: 12px;
        color: #8f98a0;
        margin-top: 5px;
    }

    /* 🟢 등록 버튼 */
    button { 
        margin-top: 30px; 
        width: 100%; 
        padding: 15px; 
        background: linear-gradient( to bottom, #5c7e10 5%, #4b6a0a 95%); 
        color: white; 
        border: none; 
        border-radius: 3px;
        cursor: pointer; 
        font-size: 16px;
        font-weight: bold;
        text-shadow: 1px 1px 0px rgba(0,0,0,0.5);
        transition: brightness 0.2s;
    }
    
    button:hover { 
        filter: brightness(1.2);
    }
    
    /* 🔗 하단 링크 */
    .bottom-link {
        display: block; 
        text-align: center; 
        margin-top: 20px;
        color: #8f98a0;
        text-decoration: none;
        font-size: 13px;
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
        <h2>New App Creation</h2>
        <span class="badge">ADMIN DASHBOARD</span>
    </div>
    
    <form action="<%= path %>/gameAdd.do" method="post" enctype="multipart/form-data">
        
        <div class="form-group">
            <label for="gameName">Product Name</label>
            <input type="text" id="gameName" name="gameName" placeholder="게임 제목을 입력하세요" required>
        </div>
        
        <div class="form-group" style="display: flex; gap: 20px;">
            <div style="flex: 1;">
                <label for="gameGenre">Genre</label>
                <input type="text" id="gameGenre" name="gameGenre" placeholder="예: RPG, FPS" required>
            </div>
            <div style="flex: 1;">
                <label for="gameDev">Developer</label>
                <input type="text" id="gameDev" name="gameDev" placeholder="개발사 이름" required>
            </div>
        </div>
        
        <div class="form-group">
            <label for="gamePrice">Price (KRW)</label>
            <input type="number" id="gamePrice" name="gamePrice" placeholder="0" required>
            <div class="help-text">무료 게임일 경우 0을 입력하세요.</div>
        </div>

        <div class="form-group">
            <label for="gameImgFile">Game Cover Image</label>
            <input type="file" id="gameImgFile" name="gameImgFile" accept="image/*" required>
            <div class="help-text">jpg, png 파일만 업로드 가능합니다. (권장 사이즈: 600x900)</div>
        </div>
        
        <div class="form-group">
            <label for="gameDesc">Store Description</label>
            <textarea id="gameDesc" name="gameDesc" rows="6" placeholder="상점 페이지에 표시될 상세 설명을 입력하세요. HTML 태그 사용 가능."></textarea>
        </div>
        
        <button type="submit">PUBLISH TO STORE</button>
    </form>
    
    <a href="gameList.do" class="bottom-link">취소하고 상점 목록으로 돌아가기</a>
</div>

</body>
</html>