package com.poozim.jobcall.repository;

import java.util.List;

import com.poozim.jobcall.model.WorkCategory;
import com.poozim.jobcall.model.WorkCategoryGroup;
import com.poozim.jobcall.model.WorkGroup;

public interface WorkCategoryRepositoryCustom{
	public List<WorkCategory> getWorkCategoryList(int workseq);
	
	public WorkCategory getDefaultCategory(int workseq);
	
	public List<WorkCategoryGroup> getCategoryGroupList(int groupseq);
	
	public int updateCategoryGroupCategoryseq(int categoryseq, int modifyseq);
}
