package com.poozim.jobcall.model;

import lombok.Data;

@Data
public class Member {
	int seq;
	int work_seq;
	String id;
	String password;
	String name;
	String department;
	String useyn;
	String auth;
	String regdate;
}
