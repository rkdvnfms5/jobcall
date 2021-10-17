package com.poozim.jobcall.model;

import lombok.Data;

@Data
public class WorkBoardFile {
	int seq;
	int board_seq;
	String path;
	String name;
	String src;
	String regdate;
}
