package com.poozim.jobcall.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

import lombok.Data;

@Data
@Entity
public class WorkCategory {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int seq;
	private int work_seq;
	private int member_seq;
	private String title;
	private String defaultyn;
	private String regdate;
	
	@Transient
	private int group_count;
}
