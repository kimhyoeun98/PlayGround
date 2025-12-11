package com.playground.board;

import java.sql.Date;

public class BoardVO {
    private int boardNo;	// 게시물 번호
    private String title;	// 제목
    private String writer;	// 작성자
    private String content;	// 내용
    private Date regDate;	// 작성일
    private int viewCnt;	// 조회수
    
    // 기본 생성자
    public BoardVO() {
		super();
	}
    // 기본 생성자
	public BoardVO(int boardNo, String title, String writer, String content, Date regDate, int viewCnt) {
		super();
		this.boardNo = boardNo;
		this.title = title;
		this.writer = writer;
		this.content = content;
		this.regDate = regDate;
		this.viewCnt = viewCnt;
	}
	
	
	// Getter & Setter
	public int getBoardNo() { 
    	return boardNo; 
    	}
    
    public void setBoardNo(int boardNo) { 
    	this.boardNo = boardNo; 
    	}
    
    public String getTitle() { 
    	return title; 
    	}
    
    public void setTitle(String title) { 
    	this.title = title; 
    	}
    
    public String getWriter() {
    	return writer; 
    	}
    
    public void setWriter(String writer) { 
    	this.writer = writer; 
    	}
    
    public String getContent() { 
    	return content; 
    	}
    
    public void setContent(String content) { 
    	this.content = content; 
    	}
    
    public Date getRegDate() { 
    	return regDate; 
    	}
    
    public void setRegDate(Date regDate) { 
    	this.regDate = regDate; 
    	}

    public int getViewCnt() { 
    	return viewCnt; 
    	}
    
    public void setViewCnt(int viewCnt) { 
    	this.viewCnt = viewCnt; 
    	}
    
}