package com.poozim.jobcall.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import lombok.Data;

@Data
@Entity
public class WorkGroup {
	@Id
	@GeneratedValue
	int seq;
	int member_seq;
	int work_seq;
	String name;
	String content;
	String access;
	String register;
	String regdate;
}
