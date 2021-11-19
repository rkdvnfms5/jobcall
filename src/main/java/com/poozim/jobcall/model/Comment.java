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
public class Comment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int seq;
	private int board_seq;
	private int member_seq;
	private String member_id;
	private String member_name;
	private String content;
	private String regdate;
	private String register;
	private String moddate;
	private String modifier;
	
	@Transient
	private List<CommentFile> commentFileList;
	
	@Transient
	private List<MultipartFile> attachFileList;
	
	@Transient
	private List<Integer> commentFileSeqList;
	
	//action
	@Transient
	private List<ActionLog> likeList;
	
	@Transient
	private List<ActionLog> dislikeList;
	
	@Transient
	private String action;
	
	@Transient
	private String target;
	
	@Transient
	private String like;
	
	@Transient
	private String dislike;
	
	@Transient
	private int actionLog_seq;
	
	@Transient
	private int search_member_seq;
}
