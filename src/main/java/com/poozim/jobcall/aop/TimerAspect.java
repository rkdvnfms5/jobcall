package com.poozim.jobcall.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;

@Component
@Aspect
public class TimerAspect {
	private static final Logger log = LoggerFactory.getLogger(TimerAspect.class);
	
	@Autowired
	private StopWatch stopWatch;
	
	@Around("@annotation(com.poozim.jobcall.aop.Timer)")
	public Object timeCheck(ProceedingJoinPoint joinPoint) throws Throwable {
		stopWatch.start();
		Object proceed = joinPoint.proceed();
		stopWatch.stop();
		
		log.info("========================== total time : " + stopWatch.getTotalTimeSeconds());
		
		return proceed;
	}
}
