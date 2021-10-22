package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poozim.jobcall.model.CommentFile;

public interface CommentFileRepository extends JpaRepository<CommentFile, Integer>{
	
}
