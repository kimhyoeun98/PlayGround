package com.playground;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.jupiter.api.Disabled;

import com.playground.game.GameDAO;

public class MainTest {

	public void SqlSession테스트() throws Exception {
		SqlSession session = new MyConfig().getSession();
		assertNotNull(session);
	}

	public void gameDAOSqlSessionTEST() throws Exception {	
		GameDAO dao = new GameDAO();
		dao.work();
		
	}

}
