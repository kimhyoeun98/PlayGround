package com.playground.game;

import java.sql.Date;

public class GameVO {
	
	//  변수들
	private int gameNo;
	private String gameName;
	private String gameGenre;
	private String gameDev;
	private int gamePrice;
	
	// 상세 정보 및 상태
	private String gameDesc;
	private String gameImg;
	private Date regDate;
	private int status; 
	
	// 1. 기본 생성자 
	public GameVO() {
    }

	// 2. 전체 데이터를 다 받아오는 생성자 (DB에서 꺼내올 때 주로 씀)
	public GameVO(int gameNo, String gameName, String gameGenre, String gameDev, int gamePrice, String gameDesc,
			String gameImg, Date regDate, int status) {
		super();
		this.gameNo = gameNo;
		this.gameName = gameName;
		this.gameGenre = gameGenre;
		this.gameDev = gameDev;
		this.gamePrice = gamePrice;
		this.gameDesc = gameDesc;
		this.gameImg = gameImg;
		this.regDate = regDate;
		this.status = status;
	}

	// 3. 게임 추가할 때 편하게 쓰는 생성자 (필수 정보만)
	public GameVO(String gameName, String gameGenre, String gameDev, int gamePrice, String gameDesc) {
		super();
		this.gameName = gameName;
		this.gameGenre = gameGenre;
		this.gameDev = gameDev;
		this.gamePrice = gamePrice;
		this.gameDesc = gameDesc;
	}
	
	// Getter / Setter 메서드들
	public int getGameNo() {
		return gameNo;
	}
	public void setGameNo(int gameNo) {
		this.gameNo = gameNo;
	}
	public String getGameName() {
		return gameName;
	}
	public void setGameName(String gameName) {
		this.gameName = gameName;
	}
	public String getGameGenre() {
		return gameGenre;
	}
	public void setGameGenre(String gameGenre) {
		this.gameGenre = gameGenre;
	}
	public String getGameDev() {
		return gameDev;
	}
	public void setGameDev(String gameDev) {
		this.gameDev = gameDev;
	}
	public int getGamePrice() {
		return gamePrice;
	}
	public void setGamePrice(int gamePrice) {
		this.gamePrice = gamePrice;
	}
	public String getGameDesc() {
		return gameDesc;
	}
	public void setGameDesc(String gameDesc) {
		this.gameDesc = gameDesc;
	}
	public String getGameImg() {
		return gameImg;
	}
	public void setGameImg(String gameImg) {
		this.gameImg = gameImg;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}

	// toString
	@Override
	public String toString() {
		String statusStr = (status == 1) ? "판매중" : "판매중지"; // 보기 좋게 변환
		return "게임정보 [번호=" + gameNo + ", 이름=" + gameName + ", 장르=" + gameGenre + ", 개발사="
				+ gameDev + ", 가격=" + gamePrice + ", 상태=" + statusStr + ", 등록일=" + regDate + "]";
	}
}