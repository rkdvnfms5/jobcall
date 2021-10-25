package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.poozim.jobcall.model.Work;

public interface WorkRepository extends JpaRepository<Work, Integer>{

/*	@Query(value = "INSERT INTO Work (member_seq, title, code, email, useyn, register, regdate) VALUES (#{member_seq}, #{title}, getWorkCode(#{title}), #{email}, 'Y', #{register}, NOW())", 
			nativeQuery = true) */
	
	@Modifying
	@Query(value = "INSERT INTO Work (member_seq, title, code, email, useyn, register, regdate) VALUES (:#{#work.member_seq}, :#{#work.title}, getWorkCode(:#{#work.title}), :#{#work.email}, 'Y', :#{#work.register}, NOW())", 
			nativeQuery = true)
	public int savesibal(@Param("work") Work work);
}
