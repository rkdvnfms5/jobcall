package com.poozim.jobcall.model;

import java.util.List;

import lombok.Data;

@Data
public class ChatTemplate {

	private int res;
	private int chat_seq;
	private int request_member_seq;
	private int receive_member_seq;
	
	private List<WorkChatLog> chatLogList;
}
