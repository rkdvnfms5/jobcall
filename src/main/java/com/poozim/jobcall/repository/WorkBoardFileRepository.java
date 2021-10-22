package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poozim.jobcall.model.WorkBoardFile;

public interface WorkBoardFileRepository extends JpaRepository<WorkBoardFile, Integer>{
	
}
