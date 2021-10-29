package com.poozim.jobcall.mapper;

import java.util.List;

import com.poozim.jobcall.model.Member;

public interface MemberMapper {
	public List<Member> getMemberList(Member member);
}
