package com.poozim.jobcall.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Data;

@Data
@Entity
public class WorkCategoryGroup {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int seq;
	int category_seq;
	int group_seq;
	int member_seq;
}
