package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poozim.jobcall.model.WorkCategory;
import com.poozim.jobcall.model.WorkChat;

public interface WorkChatRepository extends JpaRepository<WorkChat, Integer>, WorkChatRepositoryCustom{
	
}
