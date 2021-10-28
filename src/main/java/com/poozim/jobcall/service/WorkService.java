package com.poozim.jobcall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.model.WorkGroup;
import com.poozim.jobcall.repository.MemberRepository;
import com.poozim.jobcall.repository.WorkBoardFileRepository;
import com.poozim.jobcall.repository.WorkBoardRepository;
import com.poozim.jobcall.repository.WorkGroupMemberRepository;
import com.poozim.jobcall.repository.WorkGroupRepository;
import com.poozim.jobcall.repository.WorkRepository;

@Service
public class WorkService {

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
	
	public List<Work> getWorkList() {
		return workRepository.findAll();
	}
	
	public Work getWorkOne(int seq) {
		return workRepository.findById(seq).get();
	}
	
	public Work getWorkByCode(String code) {
		return workRepository.getWorkOneByCode(code);
	}
	
	//WorkGroup CRUD and Logics
	public List<WorkGroup> getWorkGroupList(WorkGroup workGroup) {
		return workGroupRepository.getWorkGroupList(workGroup);
	}
	
	public WorkGroup getWorkGroupOne(int seq) {
		return workGroupRepository.findById(seq).get();
	}
	
	
	//WorkBoard CRUD and Logics
	
}
