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
public class Comment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int seq;
	int board_seq;
	int member_seq;
	String member_id;
	String member_name;
	String content;
	String regdate;
	String register;
	String moddate;
	String modifier;
	
	@Transient
	List<CommentFile> commentFileList;
}
