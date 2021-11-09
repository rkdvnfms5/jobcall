package com.poozim.jobcall.config;

import java.io.IOException;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
//import org.springframework.data.redis.connection.RedisSocketConfiguration;
//import org.springframework.data.redis.connection.RedisStandaloneConfiguration;
//import org.springframework.data.redis.connection.lettuce.LettuceClientConfiguration;
//import org.springframework.data.redis.connection.lettuce.LettuceClientConfiguration.LettuceClientConfigurationBuilder;
//import org.springframework.data.redis.core.RedisTemplate;
//import org.springframework.data.redis.repository.configuration.EnableRedisRepositories;
//import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;

import com.poozim.jobcall.util.PropertiesUil;

@Configuration
//@EnableRedisRepositories
public class RedisConfig {
	
//	@Bean
//	public LettuceConnectionFactory redisConnectionFactory() throws IOException {
//		PropertiesUil propsUtil = new PropertiesUil();
//		String host = propsUtil.getProperty("REDIS_HOST");
//		int port = Integer.parseInt(propsUtil.getProperty("REDIS_PORT"));
//		return new LettuceConnectionFactory(new RedisStandaloneConfiguration(host, port));
//	}
//	
//	@Bean
//	public RedisTemplate<?, ?> redisTemplate() throws IOException {
//		RedisTemplate<byte[], byte[]> redisTemplate = new RedisTemplate<>();
//		redisTemplate.setConnectionFactory(redisConnectionFactory());
//		return redisTemplate;
//	}
	
	
}
