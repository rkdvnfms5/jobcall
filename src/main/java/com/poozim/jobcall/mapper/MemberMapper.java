package com.poozim.jobcall.mapper;

import java.util.List;

import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.WorkGroup;

public interface MemberMapper {
	public List<Member> getMemberList(Member member);
	
	public List<Member> getInviteList(WorkGroup workGroup);
}
