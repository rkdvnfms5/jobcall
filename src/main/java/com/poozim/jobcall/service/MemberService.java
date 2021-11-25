package com.poozim.jobcall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.model.WorkGroupMember;
import com.poozim.jobcall.repository.MemberRepository;
import com.poozim.jobcall.repository.WorkRepository;

@Service
public class MemberService {

	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private BCryptPasswordEncoder bcryEncoder;
	
	public Member getMemberOne(int seq) {
		return memberRepository.findById(seq).get();
	}
	
	public Member getMemberOneCustom(Member member) {
		return memberRepository.getMemberOne(member);
	}
	
	public Member insertMember(Member member) {
		member.setPassword(bcryEncoder.encode(member.getPassword()));
		
		return memberRepository.save(member);
	}
	
	public Member getMemberById(Member member) {
		return memberRepository.getMemberById(member);
	}
	
	public List<Member> getGroupMemberList(WorkGroupMember wgm){
		return memberRepository.getWorkGroupMemberList(wgm);
	}
	
	public int updateMember(Member member) {
		memberRepository.save(member);
		return 1;
	}
}
