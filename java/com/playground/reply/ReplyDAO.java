package com.playground.reply;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import com.playground.MyConfig;

public class ReplyDAO {
    private SqlSession session;
    
    public ReplyDAO() {
        session = new MyConfig().getSession();
    }
    
    // 특정 게시글의 댓글 목록 가져오기
    public List<ReplyVO> selectAll(int boardNo) {
        return session.selectList("reply.ReplyDAO.selectAll", boardNo);
    }
    
    // 댓글 쓰기
    public void insertReply(ReplyVO vo) {
        session.insert("reply.ReplyDAO.insertReply", vo);
        session.commit();
    }
    
    // 댓글 삭제
    public void deleteReply(int replyNo) {
        session.delete("reply.ReplyDAO.deleteReply", replyNo);
        session.commit();
    }
}