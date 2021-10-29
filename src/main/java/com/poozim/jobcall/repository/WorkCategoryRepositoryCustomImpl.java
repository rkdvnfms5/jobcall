package com.poozim.jobcall.repository;

import java.util.List;

import com.poozim.jobcall.model.QWorkCategory;
import com.poozim.jobcall.model.QWorkCategoryGroup;
import com.poozim.jobcall.model.WorkCategory;
import com.poozim.jobcall.model.WorkCategoryGroup;
import com.querydsl.jpa.impl.JPAQueryFactory;

public class WorkCategoryRepositoryCustomImpl implements WorkCategoryRepositoryCustom{

	private JPAQueryFactory queryFactory;
	
	@Override
	public List<WorkCategory> getWorkCategoryList(int workseq) {
		QWorkCategory workcategory = QWorkCategory.workCategory;
		return queryFactory.selectFrom(workcategory).where(workcategory.work_seq.eq(workseq)).fetch();
	}

	@Override
	public WorkCategory getDefaultCategory(int workseq) {
		QWorkCategory workcategory = QWorkCategory.workCategory;
		
		return queryFactory.selectFrom(workcategory).where(workcategory.work_seq.eq(workseq), workcategory.defaultyn.eq("Y")).fetchOne();
	}

	@Override
	public List<WorkCategoryGroup> getCategoryGroupList(int groupseq) {
		QWorkCategoryGroup wcg = QWorkCategoryGroup.workCategoryGroup;
		
		return queryFactory.selectFrom(wcg).where(wcg.group_seq.eq(groupseq)).fetch();
	}

	@Override
	public int updateCategoryGroupCategoryseq(int categoryseq, int modifyseq) {
		QWorkCategoryGroup wcg = QWorkCategoryGroup.workCategoryGroup;
		
		return (int) queryFactory.update(wcg).set(wcg.category_seq, modifyseq).where(wcg.category_seq.eq(categoryseq)).execute();
	}
	
	
	
}
