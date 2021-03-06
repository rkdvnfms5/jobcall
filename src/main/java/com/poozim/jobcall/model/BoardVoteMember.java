package com.poozim.jobcall.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Data;

@Data
@Entity
public class BoardVoteMember {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int seq;
	private int board_seq;
	private int vote_seq;
	private int member_seq;
	private String member_id;
	private String member_name;
	private String regdate;
}
