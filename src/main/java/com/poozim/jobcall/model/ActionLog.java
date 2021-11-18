package com.poozim.jobcall.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Data;

@Data
@Entity
public class ActionLog {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int seq;
	private int member_seq;
	private String member_id;
	private String member_name;
	private String target;
	private int target_seq;
	private String action;
	private String regdate;
}
