package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.model.WorkBoard;

public interface WorkBoardRepository extends JpaRepository<WorkBoard, Integer>{
	
}
