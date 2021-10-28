package com.poozim.jobcall.repository;

import java.util.List;

import com.poozim.jobcall.model.WorkGroup;

public interface WorkGroupRepositoryCustom{
	public List<WorkGroup> getWorkGroupList(WorkGroup workGroup);
}
