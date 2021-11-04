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
	int seq;
	int work_seq;
	int member_seq;
	String title;
	String defaultyn;
	String regdate;
	
	@Transient
	int group_count;
}
