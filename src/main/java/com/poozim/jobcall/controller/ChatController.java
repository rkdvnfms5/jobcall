package com.poozim.jobcall.controller;

import java.io.IOException;
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
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;

import com.poozim.jobcall.model.ChatTemplate;
import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.model.WorkChat;
import com.poozim.jobcall.model.WorkChatLog;
import com.poozim.jobcall.model.WorkChatMember;
import com.poozim.jobcall.service.ChatService;
import com.poozim.jobcall.service.MemberService;
import com.poozim.jobcall.util.LoginUtil;
import com.poozim.jobcall.util.OciUtil;
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
	public WorkChatLog sendMessage(@Payload WorkChatLog message, @DestinationVariable("chat_seq") int chat_seq) {
		//insert chatLog
		String regdate = TimeUtil.getDateTime();
		message.setRegdate(regdate);
		message.setChat_seq(chat_seq);
		message.setConfirmyn("N");
		chatService.insertWorkChatLog(message);
		return chatService.getWorkChatLogListMapper(message).get(0);
	}
	
	@MessageMapping("/start/{member_seq}")	//  /chat/sendMessage
	@SendTo("/topic/start/{member_seq}")
	public ChatTemplate newChat(@Payload WorkChat workChat, @DestinationVariable("member_seq") int member_seq) {
		if(workChat.getTarget_member_seq() < 1) {
			workChat.setTarget_member_seq(member_seq);
		}
		int work_seq = workChat.getWork_seq();
		int target_member_seq = workChat.getTarget_member_seq();
		int request_member_seq = workChat.getMember_seq();
		
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
			workChat = new WorkChat();
			workChat.setWork_seq(work_seq);
			workChat.setRegdate(regdate);
			workChat = chatService.insertWorkChat(workChat);
			
			//	insert WorkChatMember
			// requester
			Member request_member = memberService.getMemberOne(request_member_seq);
			
			// reciever
			Member receive_member = memberService.getMemberOne(target_member_seq);
			
			WorkChatMember wcm = new WorkChatMember();
			wcm.setWork_seq(work_seq);
			wcm.setChat_seq(workChat.getSeq());
			wcm.setMember_seq(request_member.getSeq());
			wcm.setTitle(receive_member.getId() + " (" + receive_member.getName() + ") " + receive_member.getDepartment());
			wcm.setTarget_seq(receive_member.getSeq());
			wcm.setTarget_profile(receive_member.getProfile());
			wcm.setRegdate(regdate);
			chatService.insertWorkChatMember(wcm);
			
			wcm = new WorkChatMember();
			wcm.setWork_seq(work_seq);
			wcm.setChat_seq(workChat.getSeq());
			wcm.setMember_seq(receive_member.getSeq());
			wcm.setTitle(request_member.getId() + " (" + request_member.getName() + ") " + request_member.getDepartment());
			wcm.setTarget_seq(request_member.getSeq());
			wcm.setTarget_profile(request_member.getProfile());
			wcm.setRegdate(regdate);
			chatService.insertWorkChatMember(wcm);
			
			res.setChat_seq(workChat.getSeq());
			
		}
		
		
		return res;
	}
	
	//get Chat One
	@RequestMapping(value = "/chat/one", method = RequestMethod.GET)
	public View workChatOne(HttpServletRequest request, HttpServletResponse response, Model model,
			WorkChat workChat) {
		workChat = chatService.getWorkChatOne(workChat);
		model.addAttribute("WorkChat", workChat);
		return jsonView;
	}
	
	//get chat member list
	@RequestMapping(value = "/chat/members", method = RequestMethod.GET)
	public View workChatMemberList(HttpServletRequest request, HttpServletResponse response, Model model) {
		WorkChatMember wcm = new WorkChatMember();
		int work_seq = SessionUtil.getWorkInfo(request, response).getSeq();
		int member_seq = LoginUtil.getLoginMember(request, response).getSeq();
		int chat_seq = ServletRequestUtils.getIntParameter(request, "chat_seq", 0);
		
		wcm.setMember_seq(member_seq);
		wcm.setWork_seq(work_seq);
		if(chat_seq > 0) {
			wcm.setChat_seq(chat_seq);
		}
		
		//List<WorkChatMember> list = chatService.getWorkChatMemberList(wcm);
		List<WorkChatMember> list = chatService.getWorkChatMemberListMapper(wcm);
		model.addAttribute("list", list);
		return jsonView;
	}
	
	//get Chat Log List
	@RequestMapping(value = "/chat/logs", method = RequestMethod.GET)
	public View workChatLogList(HttpServletRequest request, HttpServletResponse response, Model model,
			@ModelAttribute("WorkChatLog") WorkChatLog wcl) {
		if(wcl.getChat_seq() == 0) {
			model.addAttribute("msg", "채팅정보가 없습니다.");
			return jsonView;
		}
		List<WorkChatLog> list = chatService.getWorkChatLogListMapper(wcl);
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
	
	@RequestMapping(value = "/chat/upload", method = RequestMethod.POST)
	public View uploadFileMsg(HttpServletRequest request, HttpServletResponse response, Model model,
			@RequestParam("file") MultipartFile file) {
		int res = 0;
		if(file != null && !file.isEmpty()) {
			String str = file.getOriginalFilename();
			String objectName =  str.substring(0, str.lastIndexOf(".")) + "_" + TimeUtil.getDateTimeString() + str.substring(str.lastIndexOf("."));
			Work sessionWork = SessionUtil.getWorkInfo(request, response);
			String bucketName = sessionWork.getBucket_name();
			try {
				res = OciUtil.createObject(bucketName, file, objectName);
				if(res > 0) {
					String src = OciUtil.getObjectSrc(sessionWork.getPreauth_code(), bucketName, objectName);
					model.addAttribute("src", src);
					model.addAttribute("file_name", str);
					model.addAttribute("object_name", objectName);
				}
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		model.addAttribute("res", res);
		return jsonView;
	}
	
	@RequestMapping(value = "/chat/log", method = RequestMethod.PUT)
	public View updateChatLog(HttpServletRequest request, HttpServletResponse response, Model model,
			WorkChatLog wcl) {
		if(wcl.getChat_seq() == 0) {
			model.addAttribute("msg", "채팅정보가 없습니다.");
			return jsonView;
		}
		
		if(wcl.getMember_seq() == 0 && wcl.getSeq() == 0) {
			model.addAttribute("msg", "채팅정보가 없습니다.");
			return jsonView;
		}
		model.addAttribute("res", chatService.updateWorkChatLog(wcl));
		return jsonView;
	}
}
