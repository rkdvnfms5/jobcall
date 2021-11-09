package com.poozim.jobcall.util;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/*.xml", 
								   "file:src/main/webapp/WEB-INF/spring/appServlet/*.xml"})
public class RedisTest {
	
	@Autowired
	StringRedisTemplate redisTemplate;
	
	@Test
	public void test() {

	    final ValueOperations<String, String> stringStringValueOperations = redisTemplate.opsForValue();
	    
	   // stringStringValueOperations.set("testKey", "testValue"); // redis set
	   
	    // String result = stringStringValueOperations.get("testKey"); // redis get
	    
	   // stringStringValueOperations.getOperations().delete("sabarada"); // redis delete
	    
	   // stringStringValueOperations.getOperations().rename("testKey", "testKey2"); //key명 변경
	   
	   stringStringValueOperations.set("testKey2", "testValue2"); // redis 덮어쓰기
	   
	}
}
