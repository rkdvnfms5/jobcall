package com.poozim.jobcall.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.repository.configuration.EnableRedisRepositories;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.stereotype.Component;

import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.Work;

@Configuration
@Component
//@EnableRedisRepositories
public class RedisConfig {

	private LettuceConnectionFactory redisConnectionFactory;
	
	@Autowired
	public RedisConfig(LettuceConnectionFactory redisConnectionFactory) {
		this.redisConnectionFactory = redisConnectionFactory;
	}
	
	@Bean
	public RedisTemplate<String, Work> workRedisTemplate() {
		RedisTemplate<String, Work> workRedisTemplate = new RedisTemplate<>();
		workRedisTemplate.setConnectionFactory(redisConnectionFactory);
		workRedisTemplate.setKeySerializer(new StringRedisSerializer());
		workRedisTemplate.setValueSerializer(new Jackson2JsonRedisSerializer<Work>(Work.class));
		return workRedisTemplate;
	}
	
	@Bean
	public RedisTemplate<String, Member> memberRedisTemplate() {
		RedisTemplate<String, Member> memberRedisTemplate = new RedisTemplate<>();
		memberRedisTemplate.setConnectionFactory(redisConnectionFactory);
		memberRedisTemplate.setKeySerializer(new StringRedisSerializer());
		memberRedisTemplate.setValueSerializer(new Jackson2JsonRedisSerializer<Member>(Member.class));
		return memberRedisTemplate;
	}
}
