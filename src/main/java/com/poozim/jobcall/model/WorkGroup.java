package com.poozim.jobcall.model;

import lombok.Data;

@Data
public class WorkGroup {
	int seq;
	int member_seq;
	int work_seq;
	String name;
	String content;
	String access;
	String register;
	String regdate;
}
