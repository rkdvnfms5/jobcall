package com.poozim.jobcall.config;

import java.time.Duration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializationContext;
import org.springframework.data.redis.serializer.StringRedisSerializer;

@Configuration
public class CacheConfig {
	private LettuceConnectionFactory redisConnectionFactory;

	private final int EXPIRE_SECONDS = 600;
	private final int EXPIRE_MINUTES = 10;
	
	@Autowired
	public CacheConfig(LettuceConnectionFactory redisConnectionFactory) {
		this.redisConnectionFactory = redisConnectionFactory;
	}
	
	@Bean
	public RedisCacheManager redisCacheManager() {
		RedisCacheConfiguration redisCacheConfiguration = 
				RedisCacheConfiguration.defaultCacheConfig()
				.serializeKeysWith(RedisSerializationContext
							.SerializationPair
							.fromSerializer(new StringRedisSerializer()))
				.serializeValuesWith(RedisSerializationContext
							.SerializationPair
							.fromSerializer(new GenericJackson2JsonRedisSerializer()))
				.entryTtl(Duration.ofMinutes(EXPIRE_MINUTES));
		
		return RedisCacheManager
				.RedisCacheManagerBuilder
				.fromConnectionFactory(redisConnectionFactory)
				.cacheDefaults(redisCacheConfiguration)
				.build();
	}
}
