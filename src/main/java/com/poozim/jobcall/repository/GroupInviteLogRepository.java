package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poozim.jobcall.model.GroupInviteLog;

public interface GroupInviteLogRepository extends JpaRepository<GroupInviteLog, Integer> {
	
}
