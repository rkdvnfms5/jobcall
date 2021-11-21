package com.poozim.jobcall.repository;

import java.util.List;

import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.WorkGroupMember;

public interface MemberRepositoryCustom{
	public List<Member> getWorkMemberList(Member member);
	
	public List<Integer> getWorkMemberSeqList(Member member);
	
	public List<Member> getWorkGroupMemberList(WorkGroupMember wgm);
	
	public Member getMemberOne(Member member);
}
