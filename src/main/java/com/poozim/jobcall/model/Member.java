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
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int seq;
	int work_seq;
	String id;
	String password;
	String name;
	String department;
	String email;
	String useyn;
	String auth;
	String regdate;
}
