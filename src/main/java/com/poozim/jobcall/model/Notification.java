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
public class Notification {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) //auto increament 되는 값
	private int seq;
	private int group_seq;
	private int board_seq;
	private int member_seq;
	private String member_profile;
	private String content;
	private String confirmyn;
	private String regdate;
	
	@Transient
	private int limit = 20;
	
	@Transient
	private int offset;
	
	@Transient
	private List<Integer> seqList;
}
