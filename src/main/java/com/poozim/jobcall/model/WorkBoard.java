package com.poozim.jobcall.model;

import lombok.Data;

@Data
public class WorkBoard {
	int seq;
	int member_seq;
	String member_id;
	String member_name;
	int work_seq;
	int group_seq;
	String title;
	String type;
	String startdate;
	String enddate;
	String worker;
	String content;
	String status;
	String regdate;
	String register;
}
