package com.poozim.jobcall.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;

import com.poozim.jobcall.model.ChatTemplate;
import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.WorkChat;
import com.poozim.jobcall.model.WorkChatLog;
import com.poozim.jobcall.model.WorkChatMember;
import com.poozim.jobcall.service.ChatService;
import com.poozim.jobcall.service.MemberService;
import com.poozim.jobcall.util.LoginUtil;
import com.poozim.jobcall.util.SessionUtil;
import com.poozim.jobcall.util.TimeUtil;

@Controller
public class ChatController {

	@Autowired
	private ChatService chatService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private View jsonView;
	
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
	@SendTo("/topic/start/{member_seq}")
	public ChatTemplate newChat(HttpServletRequest request, HttpServletResponse response,
			@Payload WorkChat workChat, @DestinationVariable("member_seq") int member_seq) {
		if(workChat.getTarget_member_seq() < 1) {
			workChat.setTarget_member_seq(member_seq);
		}
		
		//get workChat
		workChat = chatService.getWorkChatOne(workChat);
		
		ChatTemplate res = new ChatTemplate();
		if(workChat != null && workChat.getSeq() > 0) { //if exist
//			set chat_seq
			res.setChat_seq(workChat.getSeq());
			
			//	set chatLogs
			WorkChatLog wcl = new WorkChatLog();
			wcl.setChat_seq(workChat.getSeq());
			res.setChatLogList(chatService.getWorkChatLogList(wcl));
			
		}
		else { //if not exist
			//insert WorkChat
			String regdate = TimeUtil.getDateTime();
			int work_seq = SessionUtil.getWorkInfo(request, response).getSeq();
			workChat.setRegdate(regdate);
			workChat.setWork_seq(work_seq);
			workChat = chatService.insertWorkChat(workChat);
			
			//	insert WorkChatMember
			// requester
			Member request_member = memberService.getMemberOne(workChat.getMember_seq());
			
			// reciever
			Member receive_member = memberService.getMemberOne(workChat.getTarget_member_seq());
			
			WorkChatMember wcm = new WorkChatMember();
			wcm.setWork_seq(work_seq);
			wcm.setChat_seq(workChat.getSeq());
			wcm.setMember_seq(request_member.getSeq());
			wcm.setTitle(receive_member.getId() + " (" + receive_member.getName() + ") " + receive_member.getDepartment());
			wcm.setTarget_seq(receive_member.getSeq());
			wcm.setTarget_profile(receive_member.getProfile());
			chatService.insertWorkChatMember(wcm);
			
			wcm = new WorkChatMember();
			wcm.setWork_seq(work_seq);
			wcm.setChat_seq(workChat.getSeq());
			wcm.setMember_seq(receive_member.getSeq());
			wcm.setTitle(request_member.getId() + " (" + request_member.getName() + ") " + request_member.getDepartment());
			wcm.setTarget_seq(request_member.getSeq());
			wcm.setTarget_profile(request_member.getProfile());
			res.setChat_seq(workChat.getSeq());
		}
		
		
		return res;
	}
	
	//get Chat List
	
	//get chat member list
	@RequestMapping(value = "/chat/members", method = RequestMethod.GET)
	public View workChatMemberList(HttpServletRequest request, HttpServletResponse response, Model model) {
		WorkChatMember wcm = new WorkChatMember();
		int work_seq = SessionUtil.getWorkInfo(request, response).getSeq();
		int member_seq = LoginUtil.getLoginMember(request, response).getSeq();
		
		wcm.setMember_seq(member_seq);
		wcm.setWork_seq(work_seq);
		
		List<WorkChatMember> list = chatService.getWorkChatMemberList(wcm);
		model.addAttribute("list", list);
		return jsonView;
	}
	
	//get Chat Log List
	@RequestMapping(value = "/chat/logs", method = RequestMethod.GET)
	public View workChatLogList(HttpServletRequest request, HttpServletResponse response, Model model,
			WorkChatLog wcl) {
		if(wcl.getChat_seq() == 0) {
			model.addAttribute("msg", "채팅정보가 없습니다.");
			return jsonView;
		}
		List<WorkChatLog> list = chatService.getWorkChatLogList(wcl);
		model.addAttribute("list", list);
		return jsonView;
	}
	
	@RequestMapping(value = "/chat/search", method = RequestMethod.GET)
	public View searchMemberList(HttpServletRequest request, HttpServletResponse response, Model model,
			Member member) {
		int work_seq = SessionUtil.getWorkInfo(request, response).getSeq();
		member.setWork_seq(work_seq);
		List<Member> list = memberService.getMemberList(member);
		model.addAttribute("list", list);
		return jsonView;
	}
}
