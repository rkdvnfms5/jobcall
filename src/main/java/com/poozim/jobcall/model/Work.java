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
	@Id	// 고유 값인듯
	@GeneratedValue(strategy = GenerationType.IDENTITY) //auto increament 되는 값
	int seq;
	int member_seq;
	String title;
	String code;
	String email;
	String bucket_name;
	String preauth_code;
	String useyn;
	String regdate;
	String register;
	
	@Transient	//영속 제외 필드
	String search;
}
