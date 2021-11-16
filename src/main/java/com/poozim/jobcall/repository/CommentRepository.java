package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poozim.jobcall.model.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer>, CommentRepositoryCustom{
	
}
