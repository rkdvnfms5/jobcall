package com.poozim.jobcall.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.Data;

@Data
@Entity	//
@Table(name="Work")	// 테이블 명과 클래스 명이 다른 경우 사용
public class Work {
	@Id	// 고유 값인듯
	@GeneratedValue //auto increament 되는 값
	int seq;
	int member_seq;
	String title;
	String code;
	String email;
	String useyn;
	String regdate;
	String register;
	
	@Transient	//영속 제외 필드
	String search;
}
