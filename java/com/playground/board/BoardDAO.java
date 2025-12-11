package com.playground.board;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import com.playground.MyConfig;

public class BoardDAO {
    
    private SqlSession session;
    
    // 생성자에서 세션 연결 (GameDAO와 동일한 방식)
    public BoardDAO() {
        session = new MyConfig().getSession();
    }
    
    // 1. 전체 목록 조회
    public List<BoardVO> selectAll() {
        List<BoardVO> list = session.selectList("board.BoardDAO.selectAll");
        System.out.println("=== 게시판 전체 목록 (" + list.size() + "건) ===");
        return list;
    }

    // 2. 상세 조회 (조회수 증가 로직 포함)
    public BoardVO selectOne(int boardNo) {
        // (1) 조회수 먼저 증가 (updateHit -> updateViewCnt)
        session.update("board.BoardDAO.updateViewCnt", boardNo);
        session.commit(); // 조회수 증가 반영
        
        // (2) 게시글 내용 조회
        BoardVO vo = session.selectOne("board.BoardDAO.selectOne", boardNo);
        
        if(vo != null) {
            System.out.println("=== [" + boardNo + "번 글] 상세 조회 ===");
        } else {
            System.out.println("존재하지 않는 게시글입니다.");
        }
        return vo;
    }

    // 3. 글 쓰기
    public void insertBoard(BoardVO vo) {
        int result = session.insert("board.BoardDAO.insertBoard", vo);
        
        if (result > 0) {
            session.commit(); // 커밋 필수
            System.out.println("게시글 [" + vo.getTitle() + "] 등록 완료");
        } else {
            System.out.println("게시글 등록 실패");
        }
    }
    
    // 4. 글 삭제
    public void deleteBoard(int boardNo) {
        int result = session.delete("board.BoardDAO.deleteBoard", boardNo);
        
        if (result > 0) {
            session.commit(); // 커밋 필수
            System.out.println(boardNo + "번 게시글 삭제 완료");
        } else {
            System.out.println("삭제 실패 (글 번호를 확인하세요)");
        }
    }
}