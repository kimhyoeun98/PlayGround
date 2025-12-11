package com.playground.framework;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

public class HandlerMapping {
	
    private Map<String, Controller> mappings = new HashMap<>();
    
    public HandlerMapping() {
        Properties prop = new Properties();
        try {
        	
            InputStream is = this.getClass().getResourceAsStream("/bean.properties");
            if(is == null) {
            	System.out.println("bean.properties 파일을 찾을 수 없습니다.");
            	return;
            }
            prop.load(is);
            
            Set<Object> keys = prop.keySet();
            for(Object key : keys) {
                String uri = (String)key;
                String className = prop.getProperty(uri);
            
                Class<?> clz = Class.forName(className);
                mappings.put(uri, (Controller)clz.getDeclaredConstructor().newInstance());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public Controller getController(String uri) {
        return mappings.get(uri);
    }
}