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
        try {        
            int count = session.selectOne("cart.CartDAO.checkCart", vo); 
            if (count > 0) return false;

            session.insert("cart.CartDAO.insertCart", vo);
            session.commit();
            return true;
        } catch (Exception e) {
            session.rollback();
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
	 
	 // 장바구니 중복 체크
	 public int checkDuplicate(CartVO vo) {
		 return session.selectOne("cart.CartDAO.checkCart", vo);
	}
	 // 장바구니 체크
	 public int checkCart(CartVO vo) {
		    return session.selectOne("cart.CartDAO.checkCart", vo);
	}
}