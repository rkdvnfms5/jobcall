package com.poozim.jobcall.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.poozim.jobcall.model.ChatTemplate;
import com.poozim.jobcall.model.WorkChatLog;
import com.poozim.jobcall.service.ChatService;
import com.poozim.jobcall.util.LoginUtil;
import com.poozim.jobcall.util.TimeUtil;

@Controller
public class ChatController {

	@Autowired
	private ChatService chatService;
	
	@MessageMapping("/send/{chat_seq}")	//  /chat/sendMessage
	@SendTo("/topic/send/{chat_seq}")
	public WorkChatLog sendMessage(HttpServletRequest request, HttpServletResponse response,
			@Payload WorkChatLog message, @DestinationVariable("chat_seq") int chat_seq) {
		//insert chatLog
		String regdate = TimeUtil.getDateTime();
		int member_seq = LoginUtil.getLoginMember(request, response).getSeq();
		message.setMember_seq(member_seq);
		message.setRegdate(regdate);
		message.setChat_seq(chat_seq);
		chatService.insertWorkChatLog(message);
		
		return message;
	}
	
	@MessageMapping("/start/{member_seq}")	//  /chat/sendMessage
	@SendTo("/topic/send/{member_seq}")
	public ChatTemplate startChat(@DestinationVariable("member_seq") int member_seq) {
		ChatTemplate chatTemplate = new ChatTemplate();
		
		//get workChat
		
		//if exist
		//	set chat_seq
		//	set chatLogs
		
		
		//if not exist
		//	insert workChat
		//	insert WorkChatMember
		
		
		return null;
	}
}
