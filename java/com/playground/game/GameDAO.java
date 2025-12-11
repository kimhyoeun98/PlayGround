package com.playground.game;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import com.playground.MyConfig;

public class GameDAO {
	
	private SqlSession session;
	
	public GameDAO() {
		session = new MyConfig().getSession();
	}
	
	public List<GameVO> selectAll() {
		List<GameVO> list =  session.selectList("game.GameDAO.selectAll");
		System.out.println("=== 게임 전체 목록 ===");
		for(GameVO vo: list) {
			System.out.println(vo);
		}
		return list;
	}
	
	public GameVO selectOne(int gameNo) {
		GameVO game = session.selectOne("game.GameDAO.selectOne", gameNo);
		
		if(game != null) {
			System.out.println("=== [" + game.getGameName() + "] 상세 정보 ===");
			System.out.println(game);
		} else {
			System.out.println("존재하지 않는 게임입니다.");
		}
		return game;
	}

	// 조회
	public List<GameVO> selectByFind(GameVO vo) {
	    return session.selectList("game.GameDAO.selectByFind", vo);
	}
	
	// 등록
	public void insert(GameVO game) {	
		
		int count = session.selectOne("game.GameDAO.checkGameExist", game);
		
		if (count > 0) {
	        System.out.println("[" + game.getGameName() + "]과(와) 동일한 게임이 이미 존재합니다.");
	        return;
	    }		
		
		session.insert("game.GameDAO.insertGame", game);
		session.commit();
		System.out.println("게임 [" + game.getGameName() + "] 등록 완료");				
	}
	
	// 수정 
	public void update(GameVO game) {
		int result = session.update("game.GameDAO.updateGame", game);	
		if(result > 0) {			
			System.out.println("게임 정보 수정 완료");
			session.commit();
		} else {
			System.out.println("수정 실패 (게임 번호를 확인하세요)");
		}
	}
	
	// 삭제 
	public void delete(int gameNo) {
	    
	    int count = session.selectOne("game.GameDAO.checkOrderExist", gameNo);
	    	   
	    if(count > 0) {
	        int result = session.update("game.GameDAO.stopSellingGame", gameNo);
	        session.commit();
	        
	    } else {
	        int result = session.delete("game.GameDAO.deleteGameReal", gameNo);
	        session.commit();
	        
	    }
	}
	
	// 신제품 조회
	public List<GameVO> selectNewReleases() {
	    return session.selectList("game.GameDAO.selectNewReleases");
	}
	
	// 베스트 셀러 조회
	public List<GameVO> selectBestSellers() {
	    return session.selectList("game.GameDAO.selectBestSellers");
	}
	
	public boolean checkUserOwnership(String userId, int gameNo) {
	    Map<String, Object> map = new HashMap<>();
	    map.put("userId", userId);
	    map.put("gameNo", gameNo);
	    
	    int count = session.selectOne("game.GameDAO.checkUserOwnership", map);
	    
	    return count > 0; // 0보다 크면 true(구매함), 아니면 false
	}
	
	public void work() {
        // 테스트 코드는 필요하면 여기에 작성
	}
}