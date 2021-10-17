package com.poozim.jobcall.model;

import lombok.Data;

@Data
public class Comment {
	int seq;
	int board_seq;
	int member_seq;
	String member_id;
	String member_name;
	String content;
	String regdate;
	String register;
	String moddate;
	String modifier;
}
