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
public class GroupInviteLog {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int seq;
	private int group_seq;
	private int member_seq;
	private String code;
	private String regdate;
}
