package com.poozim.jobcall.repository;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.poozim.jobcall.model.Work;
import com.querydsl.jpa.impl.JPAQueryFactory;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/*.xml", 
								   "file:src/main/webapp/WEB-INF/spring/appServlet/*.xml"})
public class WorkRepositoryTest {

	@Autowired
	private WorkRepository wr;
	
	@Autowired
	private WorkCategoryRepository wcr;
	
	
	@Autowired
	private JPAQueryFactory jpaQueryFactory;
	
	public void test() {
		Work work = new Work();
		
		work.setUseyn("Y");
		work.setTitle("테스트");
		work.setEmail("test@test.com");
		work.setRegister("test");
		work.setMember_seq(6);
		
		work = wr.save(work);
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println(work);
		
		//fail("Not yet implemented");
	}
	
	@Test
	public void selectOneTest() {
		wcr.getWorkCategoryList(1);
	}

}
