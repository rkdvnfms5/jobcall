package com.poozim.jobcall.repository;

import java.util.List;

import com.poozim.jobcall.model.WorkChat;
import com.poozim.jobcall.model.WorkChatLog;
import com.poozim.jobcall.model.WorkChatMember;

public interface WorkChatRepositoryCustom {

	public List<WorkChat> getWorkChatList(int member_seq);
	
	public WorkChat getWorkChatOne(WorkChat workChat);
	
	public List<WorkChatLog> getWorkChatLogList(WorkChatLog workChatLog);
	
	public List<WorkChatMember> getWorkChatMemberList(WorkChatMember workChatMember);
	
	public int updateWorkChatMember(WorkChatMember workChatMember);
	
	public int updateWorkChatLog(WorkChatLog workChatLog);
}
