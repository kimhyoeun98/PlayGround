<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PG 커뮤니티 글쓰기</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body { 
            background-color: #1b2838; 
            color: #c7d5e0; 
            font-family: 'Inter', 'Noto Sans KR', sans-serif; 
            display: flex; 
            justify-content: center; 
            padding-top: 50px; 
            margin: 0;
        }

        .container { 
            width: 800px; 
            background: #212429; 
            padding: 30px; 
            border-radius: 4px; 
            border: 1px solid #3d4450; 
        }

        h2 { 
            margin-top: 0; 
            color: #66c0f4; 
            text-transform: uppercase; 
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #8f98a0;
        }

        input, textarea { 
            width: 100%; 
            padding: 10px; 
            background: #1b2838; 
            border: 1px solid #4b5663; 
            color: white; 
            margin-bottom: 20px; 
            box-sizing: border-box; 
            border-radius: 3px;
        }

        textarea { 
            height: 300px; 
            resize: none; 
            font-family: inherit;
        }
        
        button { 
            background: #5c7e10; 
            color: white; 
            border: none; 
            padding: 10px 20px; 
            cursor: pointer; 
            font-weight: bold; 
            font-size: 16px; 
            border-radius: 2px;
        }

        button:hover { 
            background: #76a113; 
        }
        
        .cancel-btn {
            color: #8f98a0; 
            text-decoration: none; 
            margin-left: 15px;
            font-size: 14px;
        }
        
        .cancel-btn:hover {
            color: white;
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>글 작성하기</h2>
        
        <form action="<%= path %>/boardWrite.do" method="post">
            <label>제목</label>
            <input type="text" name="title" required placeholder="제목을 입력하세요">
            
            <label>내용</label>
            <textarea name="content" required placeholder="내용을 입력하세요"></textarea>
            
            <div style="text-align: right;">
                <button type="submit">작성 완료</button>
                <a href="<%= path %>/boardList.do" class="cancel-btn">취소</a>
            </div>
        </form>
    </div>

</body>
</html>