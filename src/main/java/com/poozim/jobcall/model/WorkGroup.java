package com.poozim.jobcall.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

import lombok.Data;

@Data
@Entity
public class WorkGroup {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int seq;
	int member_seq;
	int work_seq;
	String name;
	String content;
	String access;
	String useyn;
	String register;
	String regdate;
	
	@Transient
	int category_seq;
}
