package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.poozim.jobcall.model.Work;

public interface WorkRepository extends JpaRepository<Work, Integer>{

	@Modifying
	@Transactional
	@Query(value = "INSERT INTO Work (member_seq, title, code, email, useyn, register, regdate) "
			+ "VALUES (:#{#work.member_seq}, :#{#work.title}, getWorkCode(:#{#work.title}), :#{#work.email}, 'Y', :#{#work.register}, NOW())", 
			nativeQuery = true)
	public int insertWork(@Param("work") Work work);
	
	@Modifying
	@Transactional
	@Query(value = "UPDATE Work "
			+ "SET code = getWorkCode(:#{#work.title}) "
			+ "WHERE seq = :#{#work.seq}", 
			nativeQuery = true)
	public int setWorkCode(@Param("work") Work work);
	
	@Transactional
	@Query(value = "SELECT w FROM Work w WHERE code LIKE :#{#code} AND useyn = 'Y'")
	public Work getWorkOneByCode(@Param("code") String code);
}
