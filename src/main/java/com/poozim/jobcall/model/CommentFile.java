package com.poozim.jobcall.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import lombok.Data;

@Data
@Entity
public class CommentFile {
	@Id
	@GeneratedValue
	int seq;
	int comment_seq;
	String path;
	String name;
	String src;
	String regdate;
}
