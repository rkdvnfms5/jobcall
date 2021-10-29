package com.poozim.jobcall.mapper;

import java.util.List;

import com.poozim.jobcall.model.WorkGroup;

public interface WorkMapper {
	public List<WorkGroup> getWorkGroupList(WorkGroup workGroup);
}
