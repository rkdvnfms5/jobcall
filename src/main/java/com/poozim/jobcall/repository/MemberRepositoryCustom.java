package com.poozim.jobcall.repository;

import java.util.List;

import com.poozim.jobcall.model.Member;

public interface MemberRepositoryCustom{
	public List<Member> getWorkMemberList(Member member);
	
	public List<Integer> getWorkMemberSeqList(Member member);
}
