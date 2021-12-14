package com.poozim.jobcall.repository;

import java.util.List;

import com.poozim.jobcall.model.WorkChat;

public interface WorkChatRepositoryCustom {

	public List<WorkChat> getWorkChatList(int member_seq);
	
	public WorkChat getWorkChatOne(WorkChat workChat);
}
