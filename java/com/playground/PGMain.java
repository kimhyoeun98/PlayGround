package com.playground;

import com.playground.game.GameDAO;

public class PGMain {
	
	public static void main(String[] args) {
		
		GameDAO dao = new GameDAO();
		dao.work();
	}

}
