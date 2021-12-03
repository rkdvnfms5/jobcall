package com.poozim.jobcall.repository;

import java.util.List;

import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.QMember;
import com.poozim.jobcall.model.QWorkGroupMember;
import com.poozim.jobcall.model.WorkGroupMember;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.jpa.impl.JPAQueryFactory;

public class MemberRepositoryCustomImpl implements MemberRepositoryCustom {

	private JPAQueryFactory queryFactory;
	
	public MemberRepositoryCustomImpl(JPAQueryFactory queryFactory) {
		this.queryFactory = queryFactory;
	}
	
	public List<Member> getWorkMemberList(Member param) {
		QMember member = QMember.member;
		
		BooleanBuilder builder = new BooleanBuilder();
        if(param.getSeq() > 0){
            builder.and(member.seq.eq(param.getSeq()));
        }
        if(param.getWork_seq() > 0){
            builder.and(member.work_seq.eq(param.getWork_seq()));
        }
        if(param.getId() != null && !param.getId().equals("")){
            builder.and(member.id.like(param.getId()));
        }
        if(param.getName() != null && !param.getName().equals("")){
            builder.and(member.name.like(param.getName()));
        }
        if (param.getDepartment() != null && !param.getDepartment().equals("")){
            builder.and(member.department.like(param.getDepartment()));
        }
        if (param.getEmail() != null&& !param.getEmail().equals("")){
            builder.and(member.email.like(param.getEmail()));
        }
        if (param.getAuth() != null&& !param.getAuth().equals("")){
            builder.and(member.auth.eq(param.getAuth()));
        }
        builder.and(member.useyn.eq("Y"));
		
		return queryFactory.selectFrom(member).where(builder).fetch();
	}

	@Override
	public List<Integer> getWorkMemberSeqList(Member param) {
		QMember member = QMember.member;
		return queryFactory.select(member.seq).from(member).where(member.work_seq.eq(param.getWork_seq()), member.useyn.eq("Y")).fetch();
	}

	@Override
	public List<Member> getWorkGroupMemberList(WorkGroupMember wgm) {
		QMember member = QMember.member;
		QWorkGroupMember workGroupMember = QWorkGroupMember.workGroupMember;
		
		List<Integer> groupMemberSeqList = queryFactory.select(workGroupMember.member_seq).from(workGroupMember).where(workGroupMember.group_seq.eq(wgm.getGroup_seq())).fetch();
		
		return queryFactory.selectFrom(member).where(member.seq.in(groupMemberSeqList)).fetch();
	}

	@Override
	public Member getMemberOne(Member param) {
		QMember member = QMember.member;
		
		BooleanBuilder builder = new BooleanBuilder();
        if(param.getSeq() > 0){
            builder.and(member.seq.eq(param.getSeq()));
        }
        if(param.getWork_seq() > 0){
            builder.and(member.work_seq.eq(param.getWork_seq()));
        }
        if (param.getEmail() != null){
            builder.and(member.email.eq(param.getEmail()));
        }
        
		return queryFactory.selectFrom(member).where(builder).fetchOne();
	}
	
	

}
