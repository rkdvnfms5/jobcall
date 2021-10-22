package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poozim.jobcall.model.WorkGroup;

public interface WorkGroupRepository extends JpaRepository<WorkGroup, Integer>{
	
}
