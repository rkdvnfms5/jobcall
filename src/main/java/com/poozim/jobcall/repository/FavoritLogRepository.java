package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poozim.jobcall.model.FavoritLog;

public interface FavoritLogRepository extends JpaRepository<FavoritLog, Integer>{
	
}
