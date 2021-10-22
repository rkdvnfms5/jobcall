package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poozim.jobcall.model.StatusLog;

public interface StatusLogRepository extends JpaRepository<StatusLog, Integer>{
	
}
