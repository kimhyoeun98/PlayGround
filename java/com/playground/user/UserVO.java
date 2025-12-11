package com.playground.user;

import java.sql.Date;

public class UserVO {
	
	private int userNo;
	private String userId;
	private String userPw;
	private String userName;
	private String userEmail;
	private String userPhone;
	private String userAddr;
	private Date joinDate;
	
	private int userPoint;
	
	
	// 1. 기본 생성자
	public UserVO(){
	}
	
	// 2. 전체 데이터 생성자 (DB 조회용)
	public UserVO(int userNo, String userId, String userPw, String userName, String userEmail, String userPhone, String userAddr,
			Date joinDate) {
		super();
		this.userNo = userNo;
		this.userId = userId;
		this.userPw = userPw;
		this.userName = userName;
		this.userEmail = userEmail;
		this.userPhone = userPhone;
		this.userAddr = userAddr;
		this.joinDate = joinDate;
	}
	
	// 3. 회원가입용 생성자 (필수 정보만)
	public UserVO(String userId, String userPw, String userName, String userEmail, String userPhone, String userAddr) {
		super();
		this.userId = userId;
		this.userPw = userPw;
		this.userName = userName;
		this.userEmail = userEmail;
		this.userPhone = userPhone;
        this.userAddr = userAddr;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getUserAddr() {
		return userAddr;
	}

	public void setUserAddr(String userAddr) {
		this.userAddr = userAddr;
	}

	public Date getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
	
	public int getUserPoint() {
        return userPoint;
    }
    public void setUserPoint(int userPoint) {
        this.userPoint = userPoint;
    }


	@Override
    public String toString() {
        return "회원정보 [번호=" + userNo + ", ID=" + userId + ", 이름=" + userName + ", 이메일=" + userEmail + "]";
    }

	
 
}
