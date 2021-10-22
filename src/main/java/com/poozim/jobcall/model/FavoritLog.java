package com.poozim.jobcall.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import lombok.Data;

@Data
@Entity
public class FavoritLog {
	@Id
	@GeneratedValue
	int seq;
	String type;
	int type_seq;
	int member_seq;
	String member_id;
	String member_name;
	String regdate;
}
