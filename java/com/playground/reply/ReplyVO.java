package com.playground.reply;

import java.sql.Date;

public class ReplyVO {
    private int replyNo;
    private int boardNo;
    private String writer;
    private String content;
    private Date regDate;
    

    public ReplyVO() {
		super();
	}

	public ReplyVO(int replyNo, int boardNo, String writer, String content, Date regDate) {
		super();
		this.replyNo = replyNo;
		this.boardNo = boardNo;
		this.writer = writer;
		this.content = content;
		this.regDate = regDate;
	}

	// Getters and Setters
    public int getReplyNo() { 
    	return replyNo;
    	}
    
    public void setReplyNo(int replyNo) {
    	this.replyNo = replyNo;
    	}
    
    public int getBoardNo() { 
    	return boardNo; 
    	}
    
    public void setBoardNo(int boardNo) { 
    	this.boardNo = boardNo;
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
    
}