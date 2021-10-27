package com.poozim.jobcall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.repository.MemberRepository;
import com.poozim.jobcall.repository.WorkRepository;

@Service
public class MemberService {

	@Autowired
	private MemberRepository memberRepository;
	
	public Member getMemberOne(int seq) {
		return memberRepository.findById(seq).get();
	}
	
	public Member insertMember(Member member) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		member.setPassword(passwordEncoder.encode(member.getPassword()));
		
		return memberRepository.save(member);
	}
	
	public Member getMemberById(Member member) {
		return memberRepository.getMemberById(member);
	}
}
