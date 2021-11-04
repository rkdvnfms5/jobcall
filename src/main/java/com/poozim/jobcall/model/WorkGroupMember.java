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
public class WorkGroupMember {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int seq;
	int group_seq;
	int member_seq;
	String regdate;
	
	@Transient
	List<Integer> memberSeqList;
}
