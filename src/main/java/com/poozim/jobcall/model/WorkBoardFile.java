package com.poozim.jobcall.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

import lombok.Data;

@Data
@Entity
public class WorkBoardFile {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int seq;
	private int board_seq;
	private String path;
	private String name;
	private String object_name;
	private String size;
	private String src;
	private String regdate;	
	
	@Transient
	private int target_seq;
	
	@Transient
	private String type;
}
