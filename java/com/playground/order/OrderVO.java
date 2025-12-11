package com.playground.order;

import java.sql.Date;

public class OrderVO {
    
    private int orderNo;
    private String userId;
    private int gameNo;
    private int orderPrice;
    private Date orderDate;
    private int status; // 1:구매완료, 0:환불
    
    // 조인(JOIN) 결과를 담기 위한 변수 (게임 제목, 이미지)
    private String gameName;
    private String gameImg;

    // 기본 생성자
    public OrderVO() {}

    // Getters and Setters
    public int getOrderNo() { 
    	return orderNo; 
    	}
    public void setOrderNo(int orderNo) { 
    	this.orderNo = orderNo; 
    	}

    public String getUserId() { 
    	return userId; 
    	}
    
    public void setUserId(String userId) {
    	this.userId = userId; 
    	}

    public int getGameNo() { 
    	return gameNo;
    	}
    
    public void setGameNo(int gameNo) {
    	this.gameNo = gameNo; 
    	}

    public int getOrderPrice() { 
    	return orderPrice; 
    	}
    
    public void setOrderPrice(int orderPrice) {
    	this.orderPrice = orderPrice; 
    	}

    public Date getOrderDate() {
    	return orderDate; 
    	}
    
    public void setOrderDate(Date orderDate) {
    	this.orderDate = orderDate;
    	}

    public int getStatus() {
    	return status; 
    	}
    
    public void setStatus(int status) {
    	this.status = status; 
    	}

    public String getGameName() { 
    	return gameName;
    	}
    
    public void setGameName(String gameName) {
    	this.gameName = gameName;
    	}

    public String getGameImg() {
    	return gameImg;
    	}
    
    public void setGameImg(String gameImg) {
    	this.gameImg = gameImg; 
    	}

    @Override
    public String toString() {
        return "OrderVO [orderNo=" + orderNo + ", userId=" + userId + ", gameName=" + gameName + "]";
    }
}