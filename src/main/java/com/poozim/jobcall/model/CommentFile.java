package com.poozim.jobcall.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Data;

@Data
@Entity
public class CommentFile {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int seq;
	int comment_seq;
	String path;
	String name;
	String object_name;
	String size;
	String src;
	String regdate;
}
