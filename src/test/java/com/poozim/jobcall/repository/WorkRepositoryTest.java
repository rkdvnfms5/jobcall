package com.poozim.jobcall.repository;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.poozim.jobcall.model.Work;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/*.xml", 
								   "file:src/main/webapp/WEB-INF/spring/appServlet/*.xml"})
public class WorkRepositoryTest {

	@Autowired
	private WorkRepository wr;
	
	@Test
	public void test() {
		Work work = new Work();
		
		work.setMember_seq(1);
		work.setTitle("테스트");
		work.setEmail("test@test.com");
		work.setRegister("test");
		
		work = wr.save(work);
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println(work.getSeq());
		//fail("Not yet implemented");
	}

}
