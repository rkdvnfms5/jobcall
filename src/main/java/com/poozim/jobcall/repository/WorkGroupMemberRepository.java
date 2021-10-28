package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poozim.jobcall.model.WorkGroupMember;

public interface WorkGroupMemberRepository extends JpaRepository<WorkGroupMember, Integer>{
	
}
