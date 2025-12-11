package com.playground.cart;

import java.sql.Date;

public class CartVO {
    
    private int cartNo;     // 장바구니 번호 (PK)
    private String userId;  // 사용자 ID (FK)
    private int gameNo;     // 게임 번호 (FK)
    private Date regDate;   // 담은 날짜
    
    // 조인을 위해 필요한 추가 필드 
    private String gameName;
    private int gamePrice;
    private String gameImg; 
    
    // 기본 생성자
    public CartVO() {
    	super();
    }

    // 기본 생성자
    public CartVO(String userId, int gameNo) {
        this.userId = userId;
        this.gameNo = gameNo;
    }

    // Getter & Setter
    public int getCartNo() {
        return cartNo;
    }

    public void setCartNo(int cartNo) {
        this.cartNo = cartNo;
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

    public Date getRegDate() {
        return regDate;
    }

    public void setRegDate(Date regDate) {
        this.regDate = regDate;
    }

    public String getGameName() {
        return gameName;
    }

    public void setGameName(String gameName) {
        this.gameName = gameName;
    }

    public int getGamePrice() {
        return gamePrice;
    }

    public void setGamePrice(int gamePrice) {
        this.gamePrice = gamePrice;
    }

    public String getGameImg() {
        return gameImg;
    }

    public void setGameImg(String gameImg) {
        this.gameImg = gameImg;
    }
}