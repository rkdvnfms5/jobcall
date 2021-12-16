package com.poozim.jobcall.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

import lombok.Data;

@Data
@Entity
public class WorkChatMember {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int seq;
	private int work_seq;
	private int chat_seq;
	private int member_seq;
	private String title;
	private int target_seq;
	private String target_profile;
	private String regdate;
	
	@Transient
	private String last_msg;
}
