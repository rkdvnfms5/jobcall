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
public class WorkBoard {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
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
	
	@Transient
	List<WorkBoardFile> workBoardFileList;
}
