package com.poozim.jobcall.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Component;

import com.poozim.jobcall.model.Work;

@Component
public class RedisUtil {

	private static RedisTemplate<String, Work> workRedisTemplate;
	private static ValueOperations<String, Work> workValueOps;
	
	@Autowired
	private static StringRedisTemplate stringRedisTemplate;
	
	@Autowired
	public RedisUtil(RedisTemplate<String, Work> workRedisTemplate) {
		this.workRedisTemplate = workRedisTemplate;
		workValueOps = workRedisTemplate.opsForValue();
	}
	
	public static int insertWorkRedis(Work work) {
		workValueOps.set("work_"+work.getSeq(), work);
		return 1;
	}
	
	public static Work getWorkRedis(int workseq) {
		
		return workValueOps.get("work_"+workseq);
	}
	
	public static int deleteByKey(String key) {
		ValueOperations<String, String> stringStringValueOperations = stringRedisTemplate.opsForValue();
		return (stringStringValueOperations.getOperations().delete(key)? 1:0);
	}
}
