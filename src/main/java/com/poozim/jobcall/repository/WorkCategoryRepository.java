package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poozim.jobcall.model.WorkCategory;

public interface WorkCategoryRepository extends JpaRepository<WorkCategory, Integer>, WorkCategoryRepositoryCustom{
	
}
