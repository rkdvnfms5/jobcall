package com.poozim.jobcall.model;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

import lombok.Data;

@Data
@Entity
public class WorkGroup {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int seq;
	private int member_seq;
	private int work_seq;
	private String name;
	private String content;
	private String access;
	private String defaultyn = "N";
	private String useyn;
	private int master_seq;
	private String master_name;
	private String master_id;
	private String register;
	private String regdate;
	
	@Transient
	private int category_seq;
	
	@Transient
	private int member_count;
	
	@Transient
	private String search;
	
	@Transient
	private String attendyn;
	
}
