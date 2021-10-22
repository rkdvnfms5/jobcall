package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poozim.jobcall.model.Member;

public interface MemberRepository extends JpaRepository<Member, Integer>{
	
}
