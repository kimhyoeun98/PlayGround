package com.playground.cart;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import com.playground.MyConfig;

public class CartDAO {
    
    private SqlSession session;
    
    public CartDAO() {
        session = new MyConfig().getSession();
    }
    
    // 장바구니 추가
    public boolean insert(CartVO vo) {
        // 1. 이미 담겨있는지 중복 체크
        int count = session.selectOne("cart.CartDAO.checkCart", vo);
        
        if (count > 0) {
            System.out.println("이미 장바구니에 있는 게임입니다.");
            return false; // 이미 있음 (실패 처리)
        }
        
        // 2. 없으면 추가
        try {
            session.insert("cart.CartDAO.insertCart", vo);
            session.commit();
            System.out.println("장바구니 추가 완료");
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 내 장바구니 목록 조회
    public List<CartVO> selectMyCart(String userId) {
        return session.selectList("cart.CartDAO.selectMyCart", userId);
    }
    
    // 삭제
    public void delete(int cartNo) {
        session.delete("cart.CartDAO.deleteCart", cartNo);
        session.commit();
    }
    
	
	 // 장바구니 비우기
	 public void deleteAllCart(String userId) {
	     session.delete("cart.CartDAO.deleteAllCart", userId);
	     session.commit();
	 }
	
	 // 단일 장바구니 항목 조회 (선택 결제용)
	 public CartVO selectOne(int cartNo) {
	     return session.selectOne("cart.CartDAO.selectCartOne", cartNo);
	 }
}