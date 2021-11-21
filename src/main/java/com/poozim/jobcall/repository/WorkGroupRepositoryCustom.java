package com.poozim.jobcall.repository;

import java.util.List;

import com.poozim.jobcall.model.WorkGroup;
import com.poozim.jobcall.model.WorkGroupMember;

public interface WorkGroupRepositoryCustom{
	public List<WorkGroup> getWorkGroupList(int workseq, int memberseq);
	
	public int getWorkGroupMemberCnt(WorkGroup workGroup);
	
	public WorkGroupMember getWorkGroupMemberOne(int groupseq, int memberseq);
	
	public WorkGroup getWorkGroupOne(WorkGroup workGroup);
}
