package com.poozim.jobcall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poozim.jobcall.model.WorkChat;
import com.poozim.jobcall.model.WorkChatLog;
import com.poozim.jobcall.model.WorkChatMember;
import com.poozim.jobcall.repository.WorkChatLogRepository;
import com.poozim.jobcall.repository.WorkChatMemberRepository;
import com.poozim.jobcall.repository.WorkChatRepository;

@Service
public class ChatService {

	@Autowired
	private WorkChatRepository chatRepository;
	
	@Autowired
	private WorkChatLogRepository chatLogRepository;
	
	@Autowired
	private WorkChatMemberRepository chatMemberRepository;
	
	public List<WorkChat> getWorkChatList(int member_seq){
		return chatRepository.getWorkChatList(member_seq);
	}
	
	public WorkChat getWorkChatOne(WorkChat workChat) {
		return chatRepository.getWorkChatOne(workChat);
	}
	
	public int insertWorkChat(WorkChat workChat) {
		workChat = chatRepository.save(workChat);
		return workChat.getSeq();
	}
	
	public int insertWorkChatLog(WorkChatLog workChatLog) {
		chatLogRepository.save(workChatLog);
		return 1;
	}
	
	public int insertWorkChatMember(WorkChatMember workChatMember) {
		chatMemberRepository.save(workChatMember);
		return 1;
	}
	
}
