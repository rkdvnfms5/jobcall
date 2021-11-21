package com.poozim.jobcall.repository;

import java.util.List;

import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport;
import org.springframework.stereotype.Repository;

import com.poozim.jobcall.model.QWorkGroup;
import com.poozim.jobcall.model.QWorkGroupMember;
import com.poozim.jobcall.model.WorkGroup;
import com.poozim.jobcall.model.WorkGroupMember;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.jpa.impl.JPAQueryFactory;

public class WorkGroupRepositoryCustomImpl extends QuerydslRepositorySupport implements WorkGroupRepositoryCustom {

	
	private JPAQueryFactory queryFactory;
	
	public WorkGroupRepositoryCustomImpl(JPAQueryFactory queryFactory) {
		super(WorkGroup.class);
		this.queryFactory = queryFactory;
	}
	
	@Override
	public List<WorkGroup> getWorkGroupList(int workseq, int memberseq) {
		QWorkGroup workgroup = QWorkGroup.workGroup;

		List<WorkGroup> list = queryFactory.selectFrom(workgroup).where(workgroup.work_seq.eq(workseq)).fetch();
		
		return list;
	}

	@Override
	public int getWorkGroupMemberCnt(WorkGroup param) {
		QWorkGroupMember wgm = QWorkGroupMember.workGroupMember;
		int cnt = (int)queryFactory.selectFrom(wgm).where(wgm.group_seq.eq(param.getSeq())).fetchCount();
		return cnt;
	}

	@Override
	public WorkGroupMember getWorkGroupMemberOne(int groupseq, int memberseq) {
		QWorkGroupMember wgm = QWorkGroupMember.workGroupMember;
		return queryFactory.selectFrom(wgm).where(wgm.group_seq.eq(groupseq), wgm.member_seq.eq(memberseq)).fetchOne();
	}

	@Override
	public WorkGroup getWorkGroupOne(WorkGroup workGroup) {
		QWorkGroup workgroup = QWorkGroup.workGroup;
		
		BooleanBuilder builder = new BooleanBuilder();
        if(workGroup.getSeq() > 0){
            builder.and(workgroup.seq.eq(workGroup.getSeq()));
        }
        if(workGroup.getDefaultyn() != null){
            builder.and(workgroup.defaultyn.eq(workGroup.getDefaultyn()));
        }
        if (workGroup.getWork_seq() > 0){
            builder.and(workgroup.work_seq.eq(workGroup.getWork_seq()));
        }
		
		return queryFactory.selectFrom(workgroup).where(builder).fetchOne();
	}

	
	
}
