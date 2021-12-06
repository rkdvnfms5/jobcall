package com.poozim.jobcall.aop;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.model.WorkCategory;
import com.poozim.jobcall.model.WorkGroup;
import com.poozim.jobcall.service.WorkService;
import com.poozim.jobcall.util.LoginUtil;
import com.poozim.jobcall.util.RedisUtil;

@Component
@Aspect
public class WorkAspect {
	private static final Logger log = LoggerFactory.getLogger(WorkAspect.class);
	
	@Autowired
	private WorkService workService;
	
	@Before("@annotation(com.poozim.jobcall.aop.WorkLnbSet)")
	//@Before("execution(* com.poozim.jobcall.controller.WorkController.*(...))")
	public void setWorkLnbAttr() throws Throwable {
		log.info("======================================set WorkLNBAttrs Logic");
		HttpServletRequest request = ((ServletRequestAttributes)(RequestContextHolder.currentRequestAttributes())).getRequest();
		HttpServletResponse response = ((ServletRequestAttributes)(RequestContextHolder.currentRequestAttributes())).getResponse();
		HttpSession session = request.getSession();
		if(LoginUtil.getLoginCheck(request, response)) {
			Member member= LoginUtil.getLoginMember(request, response);
			request.setAttribute("member", member);
			
			Work work = workService.getWorkOne(member.getWork_seq());
			request.setAttribute("LnbWork", work);
			session.setAttribute("WorkInfo", work);
			
			WorkGroup workGroup = new WorkGroup();
			workGroup.setMember_seq(member.getSeq());
			workGroup.setWork_seq(work.getSeq());;
			List<WorkGroup> workGroupList = workService.getWorkGroupList(workGroup);
			request.setAttribute("LnbWorkGroupList", workGroupList);
			
			WorkCategory workCategory = new WorkCategory();
			workCategory.setWork_seq(work.getSeq());
			workCategory.setMember_seq(member.getSeq());
			List<WorkCategory> workCategoryList = workService.getWorkCategoryList(workCategory);
			request.setAttribute("LnbWorkCategoryList", workCategoryList);
			
		}
	}
}
