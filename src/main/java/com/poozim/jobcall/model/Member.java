package com.poozim.jobcall.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.hibernate.annotations.ColumnDefault;

import lombok.Data;

@Data
@Entity
public class Member implements Serializable{
	private static final long serialVersionUID = -7147352927860924205L;
		
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int seq;
	private int work_seq;
	private String id;
	private String password;
	private String name;
	private String department;
	private String email;
	private String position;
	private String tel;
	private String worktime;
	private String description;
	private String useyn;
	private String auth;
	private String profile;
	private String regdate;
}
