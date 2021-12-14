package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poozim.jobcall.model.WorkCategory;
import com.poozim.jobcall.model.WorkChat;
import com.poozim.jobcall.model.WorkChatMember;

public interface WorkChatMemberRepository extends JpaRepository<WorkChatMember, Integer>{
	
}
