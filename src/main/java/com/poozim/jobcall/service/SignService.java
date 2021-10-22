package com.poozim.jobcall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.repository.MemberRepository;
import com.poozim.jobcall.repository.WorkRepository;

@Service
public class SignService {

	@Autowired
	private WorkRepository wokrRepository;
	
	@Autowired
	private MemberRepository memberRepository;
	
	@Transactional
	public int signupWork(Work work, Member member) {
		int res = 0;
		
		work = wokrRepository.save(work);
		member = memberRepository.save(member);
		
		if(work.getSeq() > 0 && member.getSeq() > 0) {
			res = 1;
		}
		return res;
	}
}
