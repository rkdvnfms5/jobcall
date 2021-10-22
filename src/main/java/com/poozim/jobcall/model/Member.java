package com.poozim.jobcall.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import lombok.Data;

@Data
@Entity
public class Member {
	@Id
	@GeneratedValue
	int seq;
	int work_seq;
	String id;
	String password;
	String name;
	String department;
	String useyn;
	String auth;
	String regdate;
}
