package com.playground;

import java.io.InputStream;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MyConfig {
    
    private static SqlSessionFactory sqlSessionFactory;
    
    static {
        try {
            String resource = "mybatis-config.xml"; 
            InputStream inputStream = Resources.getResourceAsStream(resource);
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("MyBatis 설정 파일 로딩 실패!");
        }
    }
    
    public SqlSession getSession() {
        return sqlSessionFactory.openSession(true); 
    }
}