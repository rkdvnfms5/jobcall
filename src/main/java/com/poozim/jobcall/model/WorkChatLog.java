package com.poozim.jobcall.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

import lombok.Data;

@Data
@Entity
public class WorkChatLog {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int seq;
	private int chat_seq;
	private int member_seq;
	private String message;
	private String src;
	private String file_name;
	private String object_name;
	private String confirmyn;
	private String regdate;
	
	@Transient
	private int limit = 100;
	
	@Transient
	private int offset = 0;
	
	@Transient
	private String firstyn;
}
