package com.poozim.jobcall.repository;

import java.util.List;

import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.QMember;
import com.querydsl.jpa.impl.JPAQueryFactory;

public class MemberRepositoryCustomImpl implements MemberRepositoryCustom {

	private JPAQueryFactory queryFactory;
	
	public MemberRepositoryCustomImpl(JPAQueryFactory queryFactory) {
		this.queryFactory = queryFactory;
	}
	
	public List<Member> getWorkMemberList(Member param) {
		QMember member = QMember.member;
		return queryFactory.selectFrom(member).where(member.work_seq.eq(param.getWork_seq()), member.useyn.eq("Y")).fetch();
	}

	@Override
	public List<Integer> getWorkMemberSeqList(Member param) {
		QMember member = QMember.member;
		return queryFactory.select(member.seq).from(member).where(member.work_seq.eq(param.getWork_seq()), member.useyn.eq("Y")).fetch();
	}

}
