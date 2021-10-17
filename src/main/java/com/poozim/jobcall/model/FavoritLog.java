package com.poozim.jobcall.model;

import lombok.Data;

@Data
public class FavoritLog {
	int seq;
	String type;
	int type_seq;
	int member_seq;
	String member_id;
	String member_name;
	String regdate;
}
