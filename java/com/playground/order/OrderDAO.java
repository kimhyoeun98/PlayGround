package com.playground.order;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import com.playground.MyConfig;

public class OrderDAO {
	
	private SqlSession session;
	
	public OrderDAO() {
		session = new MyConfig().getSession();
	}
	
	// 1. 게임 구매 (주문 추가)
	public void insertOrder(OrderVO order) {
		try {
			session.insert("order.OrderDAO.insertOrder", order);
			session.commit();
			System.out.println("주문이 완료되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("주문 실패");
		}
	}
	
	// 2. 내 주문 내역 보기 (로그인한 사용자 ID로 조회)
	public List<OrderVO> getMyOrders(String userId) {
		List<OrderVO> list = session.selectList("order.OrderDAO.selectMyOrders", userId);
		return list;
	}

	// 포인트 차감 메서드
	public void deductPoint(String userId, int amount) {
	    OrderVO vo = new OrderVO();
	    vo.setUserId(userId);
	    vo.setOrderPrice(amount);
	    
	    session.update("order.OrderDAO.deductUserPoint", vo);
	    session.commit();
	}

	// 환불 처리 메서드
	public int refund(int orderNo) {
	    // 1. 주문 정보 조회 (얼마짜리인지 알아야 하니까)
	    OrderVO order = session.selectOne("order.OrderDAO.getOrderOne", orderNo);
	    
	    if (order == null) return 0; // 주문이 없으면 실패
	    
	    // 2. 포인트 돌려주기
	    session.update("order.OrderDAO.refundUserPoint", order);
	    
	    // 3. 주문 상태 '환불(0)'로 변경
	    int result = session.update("order.OrderDAO.updateRefundStatus", orderNo);
	    
	    session.commit();
	    
	    return order.getOrderPrice(); // 환불된 금액 리턴
	}

	// ID, 게임번호, 가격만 받아서 주문 생성
	public void insertOrder(String userId, int gameNo, int orderPrice) {
	    OrderVO vo = new OrderVO();
	    vo.setUserId(userId);
	    vo.setGameNo(gameNo);
	    vo.setOrderPrice(orderPrice);
	    
	    this.insertOrder(vo);
	}
}