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
public class BoardVote {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int seq;
	private int board_seq;
	private String name;
	private String regdate;
	
	@Transient
	private List<BoardVoteMember> boardVoteMemberList;
	
	@Transient
	private String voteyn;
}
