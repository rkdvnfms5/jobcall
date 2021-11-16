package com.poozim.jobcall.model;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
@Entity
public class WorkBoard {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int seq;
	private int member_seq;
	private String member_id;
	private String member_name;
	private int work_seq;
	private int group_seq;
	private String title;
	private String type;
	private String startdate;
	private String enddate;
	private String worker;
	private String content;
	private String status;
	private String regdate;
	private String register;
	
	@Transient
	private List<WorkBoardFile> workBoardFileList;
	
	@Transient
	private List<Comment> commentList;
	
	@Transient
	private List<MultipartFile> attachFileList;
	
	@Transient
	private List<Integer> boardFileSeqList;
}
