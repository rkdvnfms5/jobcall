package com.poozim.jobcall.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.poozim.jobcall.mapper.WorkMapper;
import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.model.WorkGroup;
import com.poozim.jobcall.repository.WorkBoardFileRepository;
import com.poozim.jobcall.repository.WorkBoardRepository;
import com.poozim.jobcall.repository.WorkGroupMemberRepository;
import com.poozim.jobcall.repository.WorkGroupRepository;
import com.poozim.jobcall.repository.WorkRepository;
import com.querydsl.jpa.impl.JPAQueryFactory;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/*.xml", 
								   "file:src/main/webapp/WEB-INF/spring/appServlet/*.xml"})
public class WorkServiceTest {
	@Autowired
	private WorkRepository workRepository;
	
	@Autowired
	private WorkGroupRepository workGroupRepository;
	
	@Autowired
	private WorkGroupMemberRepository workGroupMemberRepository;
	
	@Autowired
	private WorkBoardRepository workBoardRepository;
	
	@Autowired
	private WorkBoardFileRepository workBoardFileRepository;
	
	@Autowired
	private WorkMapper workMapper;
	
	@Test
	@Transactional
	public void Test() {
		//Mybatis Mapper
		System.out.println(workMapper.getWorkGroupList(new WorkGroup()));
		
		//JPA Repository
		System.out.println(workGroupRepository.getWorkGroupList(10, 1));
	}
}
