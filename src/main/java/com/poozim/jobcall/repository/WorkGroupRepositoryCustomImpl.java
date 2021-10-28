package com.poozim.jobcall.repository;

import java.util.List;

import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport;
import org.springframework.stereotype.Repository;

import com.poozim.jobcall.model.QWorkGroup;
import com.poozim.jobcall.model.WorkGroup;
import com.querydsl.jpa.impl.JPAQueryFactory;

public class WorkGroupRepositoryCustomImpl extends QuerydslRepositorySupport implements WorkGroupRepositoryCustom {

	
	private JPAQueryFactory queryFactory;
	
	public WorkGroupRepositoryCustomImpl(JPAQueryFactory queryFactory) {
		super(WorkGroup.class);
		this.queryFactory = queryFactory;
	}
	
	@Override
	public List<WorkGroup> getWorkGroupList(WorkGroup param) {
		QWorkGroup workgroup = QWorkGroup.workGroup;

		List<WorkGroup> list = queryFactory.selectFrom(workgroup).where(workgroup.work_seq.eq(param.getWork_seq())).fetch();
		
		return list;
	}

}
