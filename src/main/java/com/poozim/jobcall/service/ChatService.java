package com.poozim.jobcall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.poozim.jobcall.mapper.WorkMapper;
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
	
	@Autowired
	private WorkMapper workMapper;
	
	public List<WorkChat> getWorkChatList(int member_seq){
		return chatRepository.getWorkChatList(member_seq);
	}
	
	public WorkChat getWorkChatOne(WorkChat workChat) {
		return chatRepository.getWorkChatOne(workChat);
	}
	
	@Transactional
	public WorkChat insertWorkChat(WorkChat workChat) {
		//workChat = chatRepository.save(workChat);
		workChat = chatRepository.saveAndFlush(workChat);
		return workChat;
	}
	
	@Transactional
	public List<WorkChatLog> getWorkChatLogList(WorkChatLog workChatLog){
		
		return chatRepository.getWorkChatLogList(workChatLog);
	}
	
	@Transactional
	public List<WorkChatLog> getWorkChatLogListMapper(WorkChatLog workChatLog){
		
		return workMapper.getWorkChatLogListMapper(workChatLog);
	}
	
	@Transactional
	public int insertWorkChatLog(WorkChatLog workChatLog) {
		chatLogRepository.save(workChatLog);
		return 1;
	}
	
	@Transactional
	public int updateWorkChatLog(WorkChatLog workChatLog) {
		return chatRepository.updateWorkChatLog(workChatLog);
	}
	
	public List<WorkChatMember> getWorkChatMemberList(WorkChatMember workChatMember){
		return chatRepository.getWorkChatMemberList(workChatMember);
	}
	
	public List<WorkChatMember> getWorkChatMemberListMapper(WorkChatMember workChatMember){
		return workMapper.getWorkChatMemberListMapper(workChatMember);
	}
	
	@Transactional
	public int insertWorkChatMember(WorkChatMember workChatMember) {
		//chatMemberRepository.save(workChatMember);
		chatMemberRepository.saveAndFlush(workChatMember);
		return 1;
	}
	
}
