package com.poozim.jobcall.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import lombok.Data;

@Data
@Entity
public class WorkBoardFile {
	@Id
	@GeneratedValue
	int seq;
	int board_seq;
	String path;
	String name;
	String src;
	String regdate;
}
