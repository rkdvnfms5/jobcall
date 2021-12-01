package com.poozim.jobcall.model;

import lombok.Data;

@Data
public class WorkGroupFile {
	private int group_seq;
	private int limit = 10;
	private int offset = 0;
	private String allyn = "N";
	private String ext;
	private String file_type;
}
