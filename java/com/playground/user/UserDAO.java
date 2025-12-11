package com.playground.user;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.playground.MyConfig;

public class UserDAO {
	
	private SqlSession session;
	
	public UserDAO() {
		session = new MyConfig().getSession();
	}
	
	// 회원가입
	public int signUp(UserVO user) {
		// 1. 아이디 중복 체크 먼저 수행
		int count = session.selectOne("user.UserDAO.checkIdExist", user.getUserId());
	    
	    if(count > 0) {
	        // 중복 시 -1 리턴 (실패 코드)
	        return -1; 
	    }
	    
	    // 2. 중복이 아니면 가입 진행 (1 리턴)
	    int result = session.insert("user.UserDAO.signUp", user);
	    session.commit();
	    return result; // 1 (성공) 리턴
	}
	
	// 로그인
	// 성공하면 로그인한 회원 정보를 리턴, 실패하면 null 리턴
	public UserVO login(String id, String pw) {
		// 파라미터로 전달하기 위해 임시 VO 객체 생성
		UserVO tempUser = new UserVO();
		tempUser.setUserId(id);
		tempUser.setUserPw(pw);
		
		UserVO loginUser = session.selectOne("user.UserDAO.login", tempUser);
		
		return loginUser;
	}
	
	//내 정보 상세 조회  
	public UserVO getUser(String userId) { 
	    
	    UserVO user = session.selectOne("user.UserDAO.getUser", userId);
	    
	    // 최종적으로 DB에서 가져온 UserVO 객체를 호출자에게 돌려줍니다.
	    return user; 
	}
	
	// 회원 정보 수정 (비밀번호 변경)
	public void updatePw(String userId, String newPw) {
		UserVO user = new UserVO();
		user.setUserId(userId);
		user.setUserPw(newPw);
		
		int result = session.update("user.UserDAO.updatePw", user);
		
		if(result > 0) {
			session.commit();
			System.out.println("비밀번호 변경이 완료되었습니다.");
		} else {
			System.out.println("변경 실패: 시스템 오류");
		}
	}
	
	// 회원 탈퇴 
	public void deleteUser(String userId) {
	    try {
	        session.delete("user.UserDAO.deleteUserOrders", userId);

	        int result = session.delete("user.UserDAO.deleteUser", userId);
	        
	        if(result > 0) {
	            session.commit(); 
	            System.out.println("탈퇴가 완료되었습니다. (주문 내역 포함 삭제됨)");
	        } else {
	            System.out.println("탈퇴 실패: 존재하지 않는 아이디입니다.");
	        }
	        
	    } catch (Exception e) {
	        session.rollback(); 
	        System.out.println("오류 발생: 탈퇴 처리 중 문제가 생겼습니다.");
	        e.printStackTrace();
	    }
	}
	
	//전체 회원 목록 (관리자용) 
	public List<UserVO> selectAll() { 
	    
	    List<UserVO> list = session.selectList("user.UserDAO.selectAll");
	    
	    return list;
	}

	// 포인트 충전 메서드
	public void chargePoint(String userId, int amount) {
	    UserVO vo = new UserVO();
	    vo.setUserId(userId);
	    vo.setUserPoint(amount); // 여기서는 충전할 금액을 userPoint에 잠시 담습니다.
	    
	    session.update("user.UserDAO.chargePoint", vo);
	    session.commit();
	}

	// 포인트 결제 (차감) 메서드
	public void payPoint(String userId, int amount) {
	    UserVO vo = new UserVO();
	    vo.setUserId(userId);
	    vo.setUserPoint(amount); // 차감할 금액을 userPoint에 담음
	    
	    session.update("user.UserDAO.payPoint", vo);
	    session.commit();
	    System.out.println("포인트 결제 완료: -" + amount);
	}

}