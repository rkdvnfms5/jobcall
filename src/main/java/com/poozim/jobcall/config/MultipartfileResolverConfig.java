package com.poozim.jobcall.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = { "com.poozim.jobcall.controller" })
public class MultipartfileResolverConfig {
	private final int MAX_SIZE = 100 * 1024 * 1024;
	
	@Bean(name = "multipartResolver")
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
		multipartResolver.setMaxUploadSize(MAX_SIZE); // 10MB
		multipartResolver.setMaxUploadSizePerFile(MAX_SIZE); // 10MB
		multipartResolver.setMaxInMemorySize(0);
		multipartResolver.setDefaultEncoding("utf-8");
		multipartResolver.setResolveLazily(true);
		return multipartResolver;
	}
}
