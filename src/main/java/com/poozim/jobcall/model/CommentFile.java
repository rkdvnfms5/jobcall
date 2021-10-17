package com.poozim.jobcall.model;

import lombok.Data;

@Data
public class CommentFile {
	int seq;
	int comment_seq;
	String path;
	String name;
	String src;
	String regdate;
}
