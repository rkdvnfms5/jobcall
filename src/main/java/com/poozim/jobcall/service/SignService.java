package com.poozim.jobcall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.model.WorkGroup;
import com.poozim.jobcall.model.WorkGroupMember;
import com.poozim.jobcall.repository.MemberRepository;
import com.poozim.jobcall.repository.WorkGroupMemberRepository;
import com.poozim.jobcall.repository.WorkGroupRepository;
import com.poozim.jobcall.repository.WorkRepository;
import com.poozim.jobcall.util.TimeUtil;

@Service
public class SignService {

	@Autowired
	private WorkRepository workRepository;
	
	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private WorkGroupRepository workGroupRepository;
	
	@Autowired
	private WorkGroupMemberRepository workGroupMemberRepository;
	
	@Autowired
	private BCryptPasswordEncoder bcryEncoder;
	
	@Transactional
	public int signupWork(Work work, Member member) {
		member.setPassword(bcryEncoder.encode(member.getPassword()));
		
		//멤버 생성
		member = memberRepository.save(member);
		
		//업무 생성
		work.setMember_seq(member.getSeq());
		work = workRepository.save(work);
		member.setWork_seq(work.getSeq());
		
		workRepository.setWorkCode(work);
		
		//기본 그룹 생성
		WorkGroup workGroup = new WorkGroup();
		workGroup.setMember_seq(member.getSeq());
		workGroup.setWork_seq(work.getSeq());
		workGroup.setName("기본 그룹");
		workGroup.setAccess("public");
		workGroup.setRegister(member.getId());
		workGroup.setRegdate(work.getRegdate());
		
		workGroup = workGroupRepository.save(workGroup);
		
		//기본 그룹에 참여
		WorkGroupMember workGroupMember = new WorkGroupMember();
		workGroupMember.setGroup_seq(workGroup.getSeq());
		workGroupMember.setMember_seq(member.getSeq());
		workGroupMember.setRegdate(work.getRegdate());
		
		workGroupMember = workGroupMemberRepository.save(workGroupMember);
		
		return 1;
	}
}
