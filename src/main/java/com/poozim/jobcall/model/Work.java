package com.poozim.jobcall.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.ColumnDefault;
import org.springframework.data.redis.core.RedisHash;

import lombok.Data;

@Data
@Entity	//
//@Table(name="Work")	// 테이블 명과 클래스 명이 다른 경우 사용
public class Work implements Serializable{
	private static final long serialVersionUID = -4217571607689112562L;
	
	@Id	// 고유 값인듯
	@GeneratedValue(strategy = GenerationType.IDENTITY) //auto increament 되는 값
	private int seq;
	private int member_seq;
	private String title;
	private String code;
	private String email;
	private String bucket_name;
	private String preauth_code;
	private String useyn;
	private String regdate;
	private String register;
	
	@Transient	//영속 제외 필드
	private String search;
}
