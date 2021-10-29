package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poozim.jobcall.model.WorkCategoryGroup;

public interface WorkCategoryGroupRepository extends JpaRepository<WorkCategoryGroup, Integer>{
	
}
