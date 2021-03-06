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
	private String member_profile;
	private int work_seq;
	private int group_seq;
	private String title;
	private String type;
	private String startdate;
	private String starttime;
	private String enddate;
	private String endtime;
	private String worker;
	private String content;
	private String status;
	private String regdate;
	private String register;
	private String modifier;
	private String moddate;
	
	@Transient
	private List<WorkBoardFile> workBoardFileList;
	
	@Transient
	private List<Comment> commentList;
	
	@Transient
	private List<MultipartFile> attachFileList;
	
	@Transient
	private List<Integer> boardFileSeqList;
	
	//Paging
	@Transient
	private int limit = 10;
	
	@Transient
	private int offset = 0;
	
	@Transient
	private int comment_limit = 5;
	
	@Transient
	private int comment_offset = 0;
	
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
	
	@Transient
	private String noticeyn = "N";
	
	@Transient
	private List<BoardVote> boardVoteList;
	
	@Transient
	private List<String> voteList;
	
	@Transient
	private int first_comment_seq;
	
	@Transient
	private String allyn = "N";
	
	@Transient
	private String group_name;
	
	@Transient
	private String search;
	
}
