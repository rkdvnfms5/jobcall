package com.poozim.jobcall.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.poozim.jobcall.model.Work;

public interface WorkRepository extends JpaRepository<Work, Integer>{
	public List<Work> findAll();
}
