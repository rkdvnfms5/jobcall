package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.poozim.jobcall.model.GroupInviteLog;

public interface GroupInviteLogRepository extends JpaRepository<GroupInviteLog, Integer> {
	@Transactional
	@Query(value = "SELECT gil FROM GroupInviteLog gil WHERE code = :#{#groupInviteLog.code}")
	public GroupInviteLog getGroupInviteLogByCode(@Param("groupInviteLog") GroupInviteLog gil);
}
